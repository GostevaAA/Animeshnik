import 'package:animeshnik/data/models/player.dart';

class Title {
  final int id;
  final String code;
  final Names names;
  final List<String> genres;
  final PostersList posters;
  final String description;
  final Player player;
  final Type type;
  final int updated;
  final Status status;
  final Season season;

  Title(this.id, this.code, this.names, this.genres, this.posters, this.description, this.player, this.type,
      this.updated, this.status, this.season);

  Title.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        code = json['code'] as String,
        names = Names.fromJson(json['names'] as Map<String, dynamic>),
        genres = (json['genres'] as List<dynamic>).map((e) => e as String).toList(),
        posters = PostersList.fromJson(json['posters'] as Map<String, dynamic>),
        description = json['description'] as String,
        player = Player.fromJson(json['player'] as Map<String, dynamic>),
        type = Type.fromJson(json['type'] as Map<String, dynamic>),
        updated = json['updated'] as int,
        status = Status.fromJson(json['status'] as Map<String, dynamic>),
        season = Season.fromJson(json['season'] as Map<String, dynamic>);
}

class Names {
  final String ru;
  final String en;
  final String? alternative;

  Names(this.ru, this.en, this.alternative);

  Names.fromJson(Map<String, dynamic> json)
      : ru = json['ru'] as String,
        en = json['en'] as String,
        alternative = json['alternative'] as String?;
}

class PostersList {
  final Poster small;
  final Poster medium;
  final Poster original;

  PostersList(this.small, this.medium, this.original);

  PostersList.fromJson(Map<String, dynamic> json)
      : small = Poster.fromJson(json['small'] as Map<String, dynamic>),
        medium = Poster.fromJson(json['medium'] as Map<String, dynamic>),
        original = Poster.fromJson(json['original'] as Map<String, dynamic>);
}

class Poster {
  final String url;
  final String? rawBase64File;

  Poster(this.url, this.rawBase64File);

  Poster.fromJson(Map<String, dynamic> json)
      : url = json['url'] as String,
        rawBase64File = json['raw_base64_file'] as String?;

  String get fullUrl => 'https://static-libria.weekstorm.one$url';
}

class Type {
  final String? fullString;
  final String? string;
  final int? episodes;
  final int? length;
  final int? code;

  Type(this.fullString, this.string, this.episodes, this.length, this.code);

  Type.fromJson(Map<String, dynamic> json)
      : fullString = json['full_string'] as String?,
        string = json['string'] as String?,
        episodes = json['episodes'] as int?,
        length = json['length'] as int?,
        code = json['code'] as int?;
}

class Status {
  final String string;
  final int code;

  Status(this.string, this.code);

  Status.fromJson(Map<String, dynamic> json)
      : string = json['string'] as String,
        code = json['code'] as int;
}

class Season {
  final int year;
  final int weekDay;
  final String string;
  final int code;

  Season(this.year, this.weekDay, this.string, this.code);

  Season.fromJson(Map<String, dynamic> json)
      : year = json['year'] as int,
        weekDay = json['week_day'] as int,
        string = json['string'] as String,
        code = json['code'] as int;
}
