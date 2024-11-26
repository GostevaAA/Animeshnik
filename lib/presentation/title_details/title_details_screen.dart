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
      body: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: titleUiModel.title.posters.medium.fullUrl,
            imageBuilder: (context, imageProvider) => Container(
              height: MediaQuery.of(context).size.height * 0.6,
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
          DraggableScrollableSheet(
            initialChildSize: 0.5,
            minChildSize: 0.5,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                  color: theme.cardColor,
                ),
                clipBehavior: Clip.antiAlias,
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: titleUiModel.title.player.list.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return Column(
                        children: [
                          const SizedBox(height: 20),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              titleUiModel.title.names.ru,
                              style: theme.textTheme.titleLarge,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              titleUiModel.title.names.en,
                              style: theme.textTheme.titleSmall,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              RichText(
                                  text: TextSpan(style: theme.textTheme.labelSmall, children: [
                                const TextSpan(text: 'Обновлён '),
                                TextSpan(text: titleUiModel.getUpdatedFromNow()),
                                const TextSpan(text: ' назад,')
                              ])),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              RichText(
                                  text: TextSpan(style: theme.textTheme.bodyMedium, children: [
                                const TextSpan(text: 'Сезон: ', style: TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(text: titleUiModel.title.season.string),
                              ]))
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              RichText(
                                  text: TextSpan(style: theme.textTheme.bodyMedium, children: [
                                const TextSpan(text: 'Тип: ', style: TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(text: titleUiModel.title.type.fullString ?? ''),
                              ]))
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Flexible(
                                child: RichText(
                                    text: TextSpan(style: theme.textTheme.bodyMedium, children: [
                                  const TextSpan(text: 'Жанры: ', style: TextStyle(fontWeight: FontWeight.bold)),
                                  TextSpan(text: titleUiModel.getGenres()),
                                ])),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              RichText(
                                  text: TextSpan(style: theme.textTheme.bodyMedium, children: [
                                const TextSpan(text: 'Состояние: ', style: TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(
                                  text: titleUiModel.title.status.string,
                                ),
                              ]))
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(titleUiModel.title.description, style: theme.textTheme.bodyMedium),
                          const SizedBox(height: 16),
                        ],
                      );
                    } else {
                      return EpisodeCard(episode: reversedEpisodesList[index - 1]);
                    }
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
