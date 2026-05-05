import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/favorites_provider.dart';
import '../utils/constants.dart';

class LeaguePage extends StatelessWidget {
  const LeaguePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: leagues.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Leagues'),
          bottom: TabBar(
            isScrollable: true,
            tabs: [for (final league in leagues) Tab(text: league.name)],
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
                      secondary: const Icon(Icons.shield_outlined),
                      onChanged: (_) async {
                        final ok = await context
                            .read<FavoritesProvider>()
                            .toggleFavorite(league.name, team.name);
                        if (!ok && context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Maksimal 6 tim per liga.')),
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
