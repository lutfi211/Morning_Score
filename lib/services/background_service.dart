import 'package:flutter/widgets.dart';
import 'package:workmanager/workmanager.dart';

import '../models/match.dart';
import '../models/team.dart';
import '../utils/constants.dart';
import 'api_service.dart';
import 'notification_service.dart';
import 'storage_service.dart';

const backgroundSyncTask = 'morning_skor_background_sync';
const dailyMorningTask = 'morning_skor_daily_0600';

class BackgroundService {
  static Future<void> initialize() async {
    await Workmanager().initialize(callbackDispatcher, isInDebugMode: false);
    await Workmanager().registerPeriodicTask(
      backgroundSyncTask,
      backgroundSyncTask,
      frequency: const Duration(hours: 6),
      constraints: Constraints(networkType: NetworkType.connected),
      existingWorkPolicy: ExistingWorkPolicy.keep,
    );
    await _registerNextDailyTask();
  }

  static Future<void> _registerNextDailyTask() async {
    final now = DateTime.now();
    var next = DateTime(now.year, now.month, now.day, 6);
    if (!next.isAfter(now)) next = next.add(const Duration(days: 1));

    await Workmanager().registerOneOffTask(
      dailyMorningTask,
      dailyMorningTask,
      initialDelay: next.difference(now),
      constraints: Constraints(networkType: NetworkType.connected),
      existingWorkPolicy: ExistingWorkPolicy.replace,
    );
  }
}

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    WidgetsFlutterBinding.ensureInitialized();

    final lines = await _fetchNotificationLines();
    if (lines.isNotEmpty) {
      final storage = StorageService();
      await storage.addNotificationItem(
        NotificationItem(date: DateTime.now(), matches: lines),
      );

      final notificationService = NotificationService();
      await notificationService.initialize();
      await notificationService.showMorningNotification(lines);
    }

    if (task == dailyMorningTask) {
      await BackgroundService._registerNextDailyTask();
    }

    return true;
  });
}

Future<List<String>> _fetchNotificationLines() async {
  final storage = StorageService();
  final favorites = await storage.getFavorites();
  final api = ApiService();
  final seen = <String>{};
  final lines = <String>[];

  for (final entry in curatedTeamsByLeague.entries) {
    final teams = _teamsForLeague(entry.key, favorites[entry.key]);
    for (final team in teams) {
      final match = await api.getLastMatch(team.teamId);
      if (match == null || match.homeScore == null || match.awayScore == null) continue;

      final key = _matchKey(match);
      if (seen.add(key)) lines.add(match.notificationLine());
    }
  }

  return lines;
}

List<Team> _teamsForLeague(String league, List<String>? favoriteNames) {
  final teams = curatedTeamsByLeague[league] ?? const <Team>[];
  if (favoriteNames == null || favoriteNames.isEmpty) return teams;
  return teams.where((team) => favoriteNames.contains(team.name)).toList();
}

String _matchKey(Match match) => '${match.eventName}-${match.date.toIso8601String()}';
