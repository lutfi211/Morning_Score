import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/favorites_provider.dart';
import '../providers/settings_provider.dart';
import '../utils/constants.dart';
import '../widgets/badge_icon.dart';

class LeaguePage extends StatelessWidget {
  const LeaguePage({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = context.watch<SettingsProvider>().strings;

    return DefaultTabController(
      length: leagues.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(strings.leagues),
          bottom: TabBar(
            isScrollable: true,
            tabs: [
              for (final league in leagues)
                Tab(
                  icon: BadgeIcon(
                    assetPath: leagueIconAssets[league.name],
                    fallbackText: league.name,
                    size: 24,
                  ),
                  text: league.name,
                ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            for (final league in leagues)
              ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: league.teams.length,
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final team = league.teams[index];
                  final provider = context.watch<FavoritesProvider>();
                  final selected = provider.isFavorite(league.name, team.name);

                  return Card(
                    child: SwitchListTile(
                      value: selected,
                      title: Text(team.name),
                      subtitle: Text(league.name),
                      secondary: BadgeIcon(
                        assetPath: teamIconAssets[team.name],
                        fallbackText: team.name,
                        size: 42,
                      ),
                      onChanged: (_) async {
                        final ok = await context
                            .read<FavoritesProvider>()
                            .toggleFavorite(league.name, team.name);
                        if (!ok && context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(strings.maxTeamsPerLeague)),
                          );
                        }
                      },
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
