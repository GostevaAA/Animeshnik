class Player {
  final List<Episode> list;
  final Episodes episodes;

  Player(this.list, this.episodes);

  Player.fromJson(Map<String, dynamic> json)
      : list = (json['list'] as Map<String, dynamic>)
            .entries
            .map((entry) => Episode.fromJson(entry.value as Map<String, dynamic>))
            .toList(),
        episodes = Episodes.fromJson(json['episodes'] as Map<String, dynamic>);
}

class Episode {
  final int episode; //Номер серии
  final String? name; //Имя серии
  final String uuid; //Уникальный идентификатор серии
  final int createdTimestamp; //Время создания/изменения плейлиста в формате unix timestamp
  final String? preview; //Ссылка без домена на превью серии

  Episode(this.episode, this.name, this.uuid, this.createdTimestamp, this.preview);

  Episode.fromJson(Map<String, dynamic> json)
      : episode = (json['episode'] as num).toInt(),
        name = json['name'] as String?,
        uuid = json['uuid'] as String,
        createdTimestamp = json['created_timestamp'] as int,
        preview = json['preview'] as String?;
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
