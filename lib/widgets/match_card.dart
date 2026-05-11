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
      margin: const EdgeInsets.only(bottom: 14),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              app_dates.formatDisplayDate(match.date),
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BadgeIcon(
                  assetPath: teamIconAssets[match.homeTeam],
                  fallbackText: match.homeTeam,
                  size: 34,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    match.homeTeam,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
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
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
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
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _HighlightButton(label: 'Home', url: homeUrl)),
                const SizedBox(width: 12),
                Expanded(child: _HighlightButton(label: 'Away', url: awayUrl)),
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
    return SizedBox(
      height: 44,
      child: FilledButton.tonalIcon(
        onPressed: url == null ? null : () => launchUrl(Uri.parse(url!), mode: LaunchMode.externalApplication),
        icon: const Icon(Icons.play_circle_outline, size: 18),
        label: Text(
          'Highlights $label',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
