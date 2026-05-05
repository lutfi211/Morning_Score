import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class NotificationItem {
  const NotificationItem({
    required this.date,
    required this.matches,
  });

  final DateTime date;
  final List<String> matches;

  Map<String, dynamic> toJson() => {
        'date': date.toIso8601String(),
        'matches': matches,
      };

  factory NotificationItem.fromJson(Map<String, dynamic> json) {
    final rawMatches = json['matches'];
    return NotificationItem(
      date: DateTime.tryParse('${json['date']}') ?? DateTime.now(),
      matches: rawMatches is List ? rawMatches.map((e) => '$e').toList() : const [],
    );
  }
}

class StorageService {
  static const _favoritesKey = 'favorites';
  static const _notificationsKey = 'notifications';

  Future<Map<String, List<String>>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_favoritesKey);
    if (raw == null || raw.isEmpty) return {};

    final decoded = jsonDecode(raw) as Map<String, dynamic>;
    return decoded.map((league, teams) {
      final value = teams is List ? teams.map((e) => '$e').toList() : <String>[];
      return MapEntry(league, value);
    });
  }

  Future<void> setFavorites(Map<String, List<String>> favorites) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_favoritesKey, jsonEncode(favorites));
  }

  Future<List<NotificationItem>> getNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_notificationsKey) ?? const [];
    return raw
        .map((item) => NotificationItem.fromJson(jsonDecode(item) as Map<String, dynamic>))
        .toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }

  Future<void> addNotificationItem(NotificationItem item) async {
    final prefs = await SharedPreferences.getInstance();
    final current = prefs.getStringList(_notificationsKey) ?? <String>[];
    final next = [jsonEncode(item.toJson()), ...current].take(30).toList();
    await prefs.setStringList(_notificationsKey, next);
  }
}
