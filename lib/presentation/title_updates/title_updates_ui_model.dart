import 'package:animeshnik/data/models/title.dart';

sealed class TitleUpdatesUiModel {}

class TitleUiModel extends TitleUpdatesUiModel {
  final Title title;

  TitleUiModel(this.title);
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
