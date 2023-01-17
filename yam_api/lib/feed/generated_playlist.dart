import '../playlist/playlist.dart';

class GeneratedPlaylists {
  GeneratedPlaylists({
    this.type,
    this.ready,
    this.notify,
    this.data,});

  GeneratedPlaylists.fromJson(dynamic json) {
    type = json['type'];
    ready = json['ready'];
    notify = json['notify'];
    data = json['data'] != null ? MPlaylist.fromJson(json['data']) : null;
  }
  String? type;
  bool? ready;
  bool? notify;
  MPlaylist? data;
  GeneratedPlaylists copyWith({  String? type,
    bool? ready,
    bool? notify,
    MPlaylist? data,
  }) => GeneratedPlaylists(  type: type ?? this.type,
    ready: ready ?? this.ready,
    notify: notify ?? this.notify,
    data: data ?? this.data,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['ready'] = ready;
    map['notify'] = notify;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}