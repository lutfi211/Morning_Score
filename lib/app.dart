import 'package:flutter/material.dart';

import 'views/home_page.dart';
import 'views/league_page.dart';
import 'views/notification_page.dart';

class MorningSkorApp extends StatelessWidget {
  const MorningSkorApp({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: const Color(0xFF31C48D),
      surface: const Color(0xFF101418),
    );

    return MaterialApp(
      title: 'Morning Skor',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: colorScheme,
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
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _index, children: _pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (value) => setState(() => _index = value),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.sports_soccer), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.shield), label: 'Leagues'),
          NavigationDestination(icon: Icon(Icons.notifications), label: 'Inbox'),
        ],
      ),
    );
  }
}
