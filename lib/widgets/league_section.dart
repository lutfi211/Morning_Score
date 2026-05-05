import 'package:flutter/material.dart';

import '../models/match.dart';
import 'match_card.dart';

class LeagueSection extends StatelessWidget {
  const LeagueSection({
    super.key,
    required this.title,
    required this.matches,
  });

  final String title;
  final List<Match> matches;

  @override
  Widget build(BuildContext context) {
    if (matches.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 12),
          ...matches.map((match) => MatchCard(match: match)),
        ],
      ),
    );
  }
}
