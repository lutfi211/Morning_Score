import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/match.dart';
import '../utils/constants.dart';
import '../utils/date_utils.dart' as app_dates;
import 'badge_icon.dart';

class MatchCard extends StatelessWidget {
  const MatchCard({super.key, required this.match});

  final Match match;

  @override
  Widget build(BuildContext context) {
    final homeUrl = teamYouTubeChannels[match.homeTeam];
    final awayUrl = teamYouTubeChannels[match.awayTeam];

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              app_dates.formatDisplayDate(match.date),
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                BadgeIcon(
                  assetPath: teamIconAssets[match.homeTeam],
                  fallbackText: match.homeTeam,
                  size: 34,
                ),
                const SizedBox(width: 10),
                Expanded(child: Text(match.homeTeam, style: Theme.of(context).textTheme.titleMedium)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    match.scoreText(),
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ),
                Expanded(
                  child: Text(
                    match.awayTeam,
                    textAlign: TextAlign.end,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const SizedBox(width: 10),
                BadgeIcon(
                  assetPath: teamIconAssets[match.awayTeam],
                  fallbackText: match.awayTeam,
                  size: 34,
                ),
              ],
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _HighlightButton(label: 'Highlights Home', url: homeUrl),
                _HighlightButton(label: 'Highlights Away', url: awayUrl),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _HighlightButton extends StatelessWidget {
  const _HighlightButton({required this.label, required this.url});

  final String label;
  final String? url;

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonalIcon(
      onPressed: url == null ? null : () => launchUrl(Uri.parse(url!), mode: LaunchMode.externalApplication),
      icon: const Icon(Icons.play_circle_outline),
      label: Text(label),
    );
  }
}
