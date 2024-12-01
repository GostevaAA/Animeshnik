import 'package:animeshnik/data/models/player.dart';
import 'package:animeshnik/presentation/title_details/episode_player.dart';
import 'package:flutter/material.dart';

class EpisodeCard extends StatelessWidget {
  const EpisodeCard({super.key, required this.episode, required this.host});

  final Episode episode;
  final String host;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Future<void> openPlayer() async {
      await Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => EpisodePlayer(
          episode: episode,
          host: host,
        ),
      ));
    }

    void onTap() {
      openPlayer();
    }

    return Card.filled(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.only(left: 16, top: 8, right: 16, bottom: 8),
          child: Text(
            'Серия ${episode.episode}: ${episode.name ?? '-'}',
            style: theme.textTheme.bodyMedium,
          ),
        ),
      ),
    );
  }
}
