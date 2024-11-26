import 'package:animeshnik/presentation/title_details/episode_card.dart';
import 'package:animeshnik/presentation/title_updates/title_updates_ui_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TitleDetailsScreen extends StatelessWidget {
  const TitleDetailsScreen({super.key, required this.titleUiModel});

  final TitleUiModel titleUiModel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final reversedEpisodesList = titleUiModel.title.player.list.reversed.toList();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: titleUiModel.title.posters.medium.fullUrl,
            imageBuilder: (context, imageProvider) => Container(
              height: MediaQuery.sizeOf(context).height * 0.6,
              decoration: BoxDecoration(
                image: DecorationImage(
                  alignment: Alignment.topCenter,
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) => SvgPicture.asset(
              'assets/icons/A.svg',
              height: 50,
              width: 50,
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ],
      ),
      bottomSheet: DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.5,
        minChildSize: 0.5,
        builder: (BuildContext context, ScrollController scrollController) {
          return ListView(padding: const EdgeInsets.all(16), controller: scrollController, children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  titleUiModel.title.names.ru,
                  style: theme.textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  titleUiModel.title.names.en,
                  style: theme.textTheme.titleSmall,
                ),
                const SizedBox(height: 4),
                RichText(
                    text: TextSpan(style: theme.textTheme.labelSmall, children: [
                  const TextSpan(text: 'Обновлён '),
                  TextSpan(text: titleUiModel.getUpdatedFromNow()),
                  const TextSpan(text: ' назад,')
                ])),
                const SizedBox(height: 16),
                RichText(
                    text: TextSpan(style: theme.textTheme.bodyMedium, children: [
                  const TextSpan(text: 'Сезон: ', style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: titleUiModel.title.season.string),
                ])),
                const SizedBox(height: 4),
                RichText(
                    text: TextSpan(style: theme.textTheme.bodyMedium, children: [
                  const TextSpan(text: 'Тип: ', style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: titleUiModel.title.type.fullString ?? ''),
                ])),
                const SizedBox(height: 4),
                RichText(
                    text: TextSpan(style: theme.textTheme.bodyMedium, children: [
                  const TextSpan(text: 'Жанры: ', style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: titleUiModel.getGenres()),
                ])),
                const SizedBox(height: 4),
                RichText(
                    text: TextSpan(style: theme.textTheme.bodyMedium, children: [
                  const TextSpan(text: 'Состояние: ', style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                    text: titleUiModel.title.status.string,
                  ),
                ])),
                const SizedBox(height: 16),
                Text(titleUiModel.title.description, style: theme.textTheme.bodyMedium),
                const SizedBox(height: 16),
              ],
            ),
            for (var i = titleUiModel.title.player.list.length - 1; i >= 0; i--)
              EpisodeCard(episode: reversedEpisodesList[i])
          ]);
        },
      ),
    );
  }
}
