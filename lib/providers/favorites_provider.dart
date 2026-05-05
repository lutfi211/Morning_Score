import 'package:flutter/foundation.dart';

import '../services/storage_service.dart';

class FavoritesProvider extends ChangeNotifier {
  FavoritesProvider(this._storageService);

  static const maxFavoritesPerLeague = 6;
  final StorageService _storageService;
  Map<String, List<String>> _favorites = {};

  Map<String, List<String>> get favorites => Map.unmodifiable(_favorites);

  bool hasAnyFavorites() => _favorites.values.any((teams) => teams.isNotEmpty);

  bool isFavorite(String league, String teamName) {
    return _favorites[league]?.contains(teamName) ?? false;
  }

  Future<void> loadFavorites() async {
    _favorites = await _storageService.getFavorites();
    notifyListeners();
  }

  Future<bool> toggleFavorite(String league, String teamName) async {
    final teams = List<String>.from(_favorites[league] ?? const []);
    if (teams.contains(teamName)) {
      teams.remove(teamName);
    } else {
      if (teams.length >= maxFavoritesPerLeague) return false;
      teams.add(teamName);
    }

    _favorites = {..._favorites, league: teams};
    await _storageService.setFavorites(_favorites);
    notifyListeners();
    return true;
  }
}
