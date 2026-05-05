import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'providers/favorites_provider.dart';
import 'providers/matches_provider.dart';
import 'services/api_service.dart';
import 'services/background_service.dart';
import 'services/notification_service.dart';
import 'services/storage_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storageService = StorageService();
  final apiService = ApiService();
  final notificationService = NotificationService();

  if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
    await notificationService.initialize();
    await BackgroundService.initialize();
  }

  final favoritesProvider = FavoritesProvider(storageService);
  await favoritesProvider.loadFavorites();

  runApp(
    MultiProvider(
      providers: [
        Provider.value(value: storageService),
        Provider.value(value: apiService),
        Provider.value(value: notificationService),
        ChangeNotifierProvider.value(value: favoritesProvider),
        ChangeNotifierProvider(
          create: (_) => MatchesProvider(apiService, favoritesProvider),
        ),
      ],
      child: const MorningSkorApp(),
    ),
  );
}
