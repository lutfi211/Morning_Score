import 'package:flutter/material.dart';

import '../services/storage_service.dart';
import '../utils/constants.dart';
import '../utils/date_utils.dart' as app_dates;
import '../widgets/badge_icon.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late Future<List<NotificationItem>> _future;

  @override
  void initState() {
    super.initState();
    _future = StorageService().getNotifications();
  }

  Future<void> _reload() async {
    setState(() {
      _future = StorageService().getNotifications();
    });
    await _future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: FutureBuilder<List<NotificationItem>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final items = snapshot.data ?? const <NotificationItem>[];
          if (items.isEmpty) {
            return const Center(child: Text('Inbox masih kosong.'));
          }

          return RefreshIndicator(
            onRefresh: _reload,
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: items.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = items[index];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          app_dates.formatDisplayDate(item.date),
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                        const SizedBox(height: 14),
                        if (item.matchesByLeague.isNotEmpty)
                          for (final league in _orderedLeagues(item.matchesByLeague))
                            _InboxLeagueGroup(
                              league: league,
                              matches: item.matchesByLeague[league] ?? const [],
                            )
                        else
                          for (final match in item.matches)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 6),
                              child: Text(match),
                            ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  List<String> _orderedLeagues(Map<String, List<String>> matchesByLeague) {
    final ordered = <String>[
      for (final league in curatedTeamsByLeague.keys)
        if ((matchesByLeague[league] ?? const []).isNotEmpty) league,
    ];
    final extras = matchesByLeague.keys.where((league) => !ordered.contains(league)).toList();
    return [...ordered, ...extras];
  }
}

class _InboxLeagueGroup extends StatelessWidget {
  const _InboxLeagueGroup({
    required this.league,
    required this.matches,
  });

  final String league;
  final List<String> matches;

  @override
  Widget build(BuildContext context) {
    if (matches.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              BadgeIcon(
                assetPath: leagueIconAssets[league],
                fallbackText: league,
                size: 26,
              ),
              const SizedBox(width: 10),
              Text(
                league,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800),
              ),
            ],
          ),
          const SizedBox(height: 8),
          for (final match in matches)
            Padding(
              padding: const EdgeInsets.only(left: 36, bottom: 6),
              child: Text(match),
            ),
        ],
      ),
    );
  }
}
