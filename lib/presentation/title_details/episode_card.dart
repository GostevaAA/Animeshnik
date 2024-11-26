import 'package:animeshnik/data/models/player.dart';
import 'package:flutter/material.dart';

class EpisodeCard extends StatelessWidget {
  const EpisodeCard({super.key, required this.episode});

  final Episode episode;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.only(left: 16, top: 8, right: 16, bottom: 8),
        child: Text(
          'Серия ${episode.episode}: ${episode.name ?? '-'}',
          style: theme.textTheme.bodyMedium,
        ),
      ),
    );
  }
}
