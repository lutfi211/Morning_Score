import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/app_strings.dart';

class NotificationItem {
  const NotificationItem({
    required this.date,
    this.matches = const [],
    this.matchesByLeague = const {},
  });

  final DateTime date;
  final List<String> matches;
  final Map<String, List<String>> matchesByLeague;

  Map<String, dynamic> toJson() => {
        'date': date.toIso8601String(),
        'matches': matches,
        'matchesByLeague': matchesByLeague,
      };

  factory NotificationItem.fromJson(Map<String, dynamic> json) {
    final rawMatches = json['matches'];
    final rawMatchesByLeague = json['matchesByLeague'];
    return NotificationItem(
      date: DateTime.tryParse('${json['date']}') ?? DateTime.now(),
      matches: rawMatches is List ? rawMatches.map((e) => '$e').toList() : const [],
      matchesByLeague: rawMatchesByLeague is Map
          ? rawMatchesByLeague.map((league, matches) {
              final value = matches is List ? matches.map((e) => '$e').toList() : <String>[];
              return MapEntry('$league', value);
            })
          : const {},
    );
  }
}

class StorageService {
  static const _favoritesKey = 'favorites';
  static const _notificationsKey = 'notifications';
  static const _languageKey = 'language';
  static const _themeModeKey = 'themeMode';

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

  Future<AppLanguage> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(_languageKey);
    return value == AppLanguage.en.name ? AppLanguage.en : AppLanguage.id;
  }

  Future<void> setLanguage(AppLanguage language) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, language.name);
  }

  Future<ThemeMode> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(_themeModeKey);
    return value == ThemeMode.light.name ? ThemeMode.light : ThemeMode.dark;
  }

  Future<void> setThemeMode(ThemeMode themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeModeKey, themeMode.name);
  }
}
