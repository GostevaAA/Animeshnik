import 'package:animeshnik/data/models/title.dart';

sealed class TitleUpdatesUiModel {}

class TitleUiModel extends TitleUpdatesUiModel {
  final Title title;

  TitleUiModel(this.title);

  String getGenres() {
    return title.genres.join(', ');
  }

  String getUpdatedFromNow() {
    int hours = DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(title.updated * 1000)).inHours;
    if (hours > 24) {
      return '${hours / 24} д.';
    } else {
      return '$hours ч.';
    }
  }
}

class Header extends TitleUpdatesUiModel {
  final HeaderDate type;

  Header(this.type);
}

enum HeaderDate {
  today,
  yesterday,
  other,
}
