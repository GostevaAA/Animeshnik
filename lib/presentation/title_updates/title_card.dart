import 'package:animeshnik/presentation/title_updates/title_updates_ui_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TitleCard extends StatelessWidget {
  const TitleCard({super.key, required this.titleUiModel});

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
          CachedNetworkImage(
            imageUrl: titleUiModel.title.posters.small.fullUrl,
            height: 186,
            width: 130,
            placeholder: (context, url) => SvgPicture.asset(
              'assets/icons/A.svg',
              height: 50,
              width: 50,
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
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
                    "Эпизоды: ${titleUiModel.title.player.episodes.last} из ${titleUiModel.title.type.episodes ?? 0}",
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
