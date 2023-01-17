class QueueItem {
  QueueItem({
      this.id, 
      this.context, 
      this.initialContext, 
      this.tracks, 
      this.currentIndex, 
      this.modified,});

  QueueItem.fromJson(dynamic json) {
    id = json['id'];
    context = json['context'] != null ? MainContext.fromJson(json['context']) : null;
    initialContext = json['initialContext'] != null ? MainContext.fromJson(json['initialContext']) : null;
    if (json['tracks'] != null) {
      tracks = [];
      json['tracks'].forEach((v) {
        tracks?.add(Tracks.fromJson(v));
      });
    }
    currentIndex = json['currentIndex'];
    modified = json['modified'];
  }
  String? id;
  MainContext? context;
  MainContext? initialContext;
  List<Tracks>? tracks;
  num? currentIndex;
  String? modified;
QueueItem copyWith({  String? id,
  MainContext? context,
  MainContext? initialContext,
  List<Tracks>? tracks,
  num? currentIndex,
  String? modified,
}) => QueueItem(  id: id ?? this.id,
  context: context ?? this.context,
  initialContext: initialContext ?? this.initialContext,
  tracks: tracks ?? this.tracks,
  currentIndex: currentIndex ?? this.currentIndex,
  modified: modified ?? this.modified,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (context != null) {
      map['context'] = context?.toJson();
    }
    if (initialContext != null) {
      map['initialContext'] = initialContext?.toJson();
    }
    if (tracks != null) {
      map['tracks'] = tracks?.map((v) => v.toJson()).toList();
    }
    map['currentIndex'] = currentIndex;
    map['modified'] = modified;
    return map;
  }

}

class Tracks {
  Tracks({
      this.trackId, 
      this.albumId, 
      this.from,});

  Tracks.fromJson(dynamic json) {
    trackId = json['trackId'];
    albumId = json['albumId'];
    from = json['from'];
  }
  String? trackId;
  String? albumId;
  String? from;
Tracks copyWith({  String? trackId,
  String? albumId,
  String? from,
}) => Tracks(  trackId: trackId ?? this.trackId,
  albumId: albumId ?? this.albumId,
  from: from ?? this.from,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['trackId'] = trackId;
    map['albumId'] = albumId;
    map['from'] = from;
    return map;
  }

}

class MainContext {
  MainContext({
      this.description, 
      this.login, 
      this.id, 
      this.type,});

  MainContext.fromJson(dynamic json) {
    description = json['description'];
    login = json['login'];
    id = json['id'];
    type = json['type'];
  }
  String? description;
  String? login;
  String? id;
  String? type;
MainContext copyWith({  String? description,
  String? login,
  String? id,
  String? type,
}) => MainContext(  description: description ?? this.description,
  login: login ?? this.login,
  id: id ?? this.id,
  type: type ?? this.type,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['description'] = description;
    map['login'] = login;
    map['id'] = id;
    map['type'] = type;
    return map;
  }

}