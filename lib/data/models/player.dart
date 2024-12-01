import 'package:animeshnik/data/core/exceptions/parse_json_exception.dart';

class Player {
  final List<Episode> list;
  final Episodes episodes;
  final String host;

  Player(this.list, this.episodes, this.host);

  Player.fromJson(Map<String, dynamic> json)
      : list = switch (json['list']) {
          Map<String, dynamic>() => (json['list'] as Map<String, dynamic>)
              .entries
              .map((entry) => Episode.fromJson(entry.value as Map<String, dynamic>))
              .toList(),
          List<dynamic>() =>
            (json['list'] as List<dynamic>).map((e) => Episode.fromJson(e as Map<String, dynamic>)).toList(),
          Object() => throw ParseJsonException(''),
          null => throw ParseJsonException(''),
        },
        episodes = Episodes.fromJson(json['episodes'] as Map<String, dynamic>),
        host = json['host'] as String;
}

class Episode {
  final int episode; //Номер серии
  final String? name; //Имя серии
  final String uuid; //Уникальный идентификатор серии
  final int createdTimestamp; //Время создания/изменения плейлиста в формате unix timestamp
  final String? preview; //Ссылка без домена на превью серии
  final Hls hls; //Объект, содержащий ссылки на потоковое воспроизведение в разном качестве

  Episode(this.episode, this.name, this.uuid, this.createdTimestamp, this.preview, this.hls);

  Episode.fromJson(Map<String, dynamic> json)
      : episode = (json['episode'] as num).toInt(),
        name = json['name'] as String?,
        uuid = json['uuid'] as String,
        createdTimestamp = json['created_timestamp'] as int,
        preview = json['preview'] as String?,
        hls = Hls.fromJson(json['hls'] as Map<String, dynamic>);
}

class Episodes {
  final int? first;
  final int? last;
  final String string;

  Episodes(this.first, this.last, this.string);

  Episodes.fromJson(Map<String, dynamic> json)
      : first = json['first'] as int,
        last = json['last'] as int,
        string = json['string'] as String;
}

class Hls {
  final String fhd;
  final String hd;
  final String sd;

  Hls(this.fhd, this.hd, this.sd);

  Hls.fromJson(Map<String, dynamic> json)
      : fhd = json['fhd'] as String,
        hd = json['hd'] as String,
        sd = json['fhd'] as String;
}
