import 'package:animeshnik/title_updates_screen.dart';
import 'package:flutter/material.dart';

class TitleScreen extends StatelessWidget {
  const TitleScreen({super.key, required this.titleUiModel});

  final TitleUiModel titleUiModel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            titleUiModel.title.posters.small.fullUrl,
            width: 130,
            height: 186,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(titleUiModel.title.names.ru,
                      style: theme.textTheme.titleMedium),
                  SizedBox(height: 8),
                  Text(
                    titleUiModel.title.description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium,
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Эпизоды: ... из ${titleUiModel.title.type.episodes ?? 0}",
                    style: theme.textTheme.labelMedium,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
