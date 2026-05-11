import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/favorites_provider.dart';
import '../providers/matches_provider.dart';
import '../providers/settings_provider.dart';
import '../utils/constants.dart';
import '../widgets/league_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _fetch());
  }

  Future<void> _fetch() async {
    final favorites = context.read<FavoritesProvider>();
    if (!favorites.hasAnyFavorites()) return;

    await context.read<MatchesProvider>().fetchMatchesForFavorites();
    if (!mounted) return;

    if (context.read<MatchesProvider>().hasError) {
      final strings = context.read<SettingsProvider>().strings;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(strings.loadScoresFailed)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasFavorites = context.watch<FavoritesProvider>().hasAnyFavorites();
    final matchesProvider = context.watch<MatchesProvider>();
    final strings = context.watch<SettingsProvider>().strings;

    return Scaffold(
      appBar: AppBar(
        title: Text(strings.appName),
        actions: [
          IconButton(
            tooltip: strings.refresh,
            onPressed: matchesProvider.isLoading ? null : _fetch,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: !hasFavorites
          ? const _EmptyFavorites()
          : RefreshIndicator(
              onRefresh: _fetch,
              child: matchesProvider.isLoading && matchesProvider.matchesByLeague.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [
                        const SizedBox(height: 6),
                        for (final league in curatedTeamsByLeague.keys)
                          LeagueSection(
                            title: league,
                            matches: matchesProvider.matchesByLeague[league] ?? const [],
                          ),
                        if (matchesProvider.matchesByLeague.values.every((items) => items.isEmpty))
                          Padding(
                            padding: const EdgeInsets.only(top: 160),
                            child: Center(child: Text(strings.noLatestScores)),
                          ),
                      ],
                    ),
            ),
    );
  }
}

class _EmptyFavorites extends StatelessWidget {
  const _EmptyFavorites();

  @override
  Widget build(BuildContext context) {
    final strings = context.watch<SettingsProvider>().strings;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          strings.chooseFavorites,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
