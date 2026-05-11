import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/settings_provider.dart';
import 'views/home_page.dart';
import 'views/league_page.dart';
import 'views/notification_page.dart';
import 'views/settings_page.dart';

class MorningSkorApp extends StatelessWidget {
  const MorningSkorApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();
    final darkColorScheme = ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: const Color(0xFF31C48D),
      surface: const Color(0xFF101418),
    );
    final lightColorScheme = ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: const Color(0xFF14825B),
      surface: const Color(0xFFF7FAF8),
    );

    return MaterialApp(
      title: 'Morning Skor',
      debugShowCheckedModeBanner: false,
      themeMode: settings.themeMode,
      theme: _buildTheme(lightColorScheme, const Color(0xFFF7FAF8), const Color(0xFFFFFFFF)),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: darkColorScheme,
        scaffoldBackgroundColor: const Color(0xFF0B0F12),
        cardTheme: CardThemeData(
          color: const Color(0xFF151B20),
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          backgroundColor: Color(0xFF0B0F12),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      home: const MainShell(),
    );
  }

  ThemeData _buildTheme(ColorScheme colorScheme, Color scaffold, Color card) {
    return ThemeData(
      useMaterial3: true,
      brightness: colorScheme.brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: scaffold,
      cardTheme: CardThemeData(
        color: card,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      appBarTheme: AppBarTheme(
        centerTitle: false,
        backgroundColor: scaffold,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
      ),
    );
  }
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;

  static const _pages = [
    HomePage(),
    LeaguePage(),
    NotificationPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final strings = context.watch<SettingsProvider>().strings;

    return Scaffold(
      body: IndexedStack(index: _index, children: _pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (value) => setState(() => _index = value),
        destinations: [
          NavigationDestination(icon: const Icon(Icons.sports_soccer), label: strings.home),
          NavigationDestination(icon: const Icon(Icons.shield), label: strings.leagues),
          NavigationDestination(icon: const Icon(Icons.notifications), label: strings.inbox),
          NavigationDestination(icon: const Icon(Icons.settings), label: strings.settings),
        ],
      ),
    );
  }
}
