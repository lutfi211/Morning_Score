import 'package:flutter/foundation.dart';

import '../models/match.dart';
import '../models/team.dart';
import '../services/api_service.dart';
import '../utils/constants.dart';
import 'favorites_provider.dart';

class MatchesProvider extends ChangeNotifier {
  MatchesProvider(this._apiService, this._favoritesProvider);

  final ApiService _apiService;
  final FavoritesProvider _favoritesProvider;

  Map<String, List<Match>> _matchesByLeague = {};
  bool _isLoading = false;
  String? _error;

  Map<String, List<Match>> get matchesByLeague => Map.unmodifiable(_matchesByLeague);
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get hasError => _error != null;

  Future<void> fetchMatchesForFavorites() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final next = <String, List<Match>>{};

      for (final entry in curatedTeamsByLeague.entries) {
        final league = entry.key;
        final teams = _teamsForLeague(league);
        final seen = <String>{};
        final matches = <Match>[];

        for (final team in teams) {
          final match = await _apiService.getLastMatch(team.teamId);
          if (match == null || match.homeScore == null || match.awayScore == null) continue;

          final key = '${match.eventName}-${match.date.toIso8601String()}';
          if (seen.add(key)) matches.add(match);
        }

        matches.sort((a, b) => b.date.compareTo(a.date));
        next[league] = matches;
      }

      _matchesByLeague = next;
    } catch (_) {
      _error = 'loadScoresFailed';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  List<Team> _teamsForLeague(String league) {
    final teams = curatedTeamsByLeague[league] ?? const <Team>[];
    final favorites = _favoritesProvider.favorites[league] ?? const <String>[];
    if (favorites.isEmpty) return teams;
    return teams.where((team) => favorites.contains(team.name)).toList();
  }
}
