class MQueue {
  MQueue({
      this.id, 
      this.context, 
      this.initialContext, 
      this.tracks, 
      this.currentIndex, 
      this.modified,});

  MQueue.fromJson(dynamic json) {
    id = json['id'];
    context = json['context'] != null ? Context.fromJson(json['context']) : null;
    initialContext = json['initialContext'] != null ? InitialContext.fromJson(json['initialContext']) : null;
    if (json['tracks'] != null) {
      tracks = [];
      json['tracks'].forEach((v) {
        tracks.add(Tracks.fromJson(v));
      });
    }
    currentIndex = json['currentIndex'];
    modified = json['modified'];
  }
  String id;
  Context context;
  InitialContext initialContext;
  List<Tracks> tracks;
  num currentIndex;
  String modified;
MQueue copyWith({  String id,
  Context context,
  InitialContext initialContext,
  List<Tracks> tracks,
  num currentIndex,
  String modified,
}) => MQueue(  id: id ?? this.id,
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
      map['context'] = context.toJson();
    }
    if (initialContext != null) {
      map['initialContext'] = initialContext.toJson();
    }
    if (tracks != null) {
      map['tracks'] = tracks.map((v) => v.toJson()).toList();
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
  String trackId;
  String albumId;
  String from;
Tracks copyWith({  String trackId,
  String albumId,
  String from,
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

class InitialContext {
  InitialContext({
      this.login, 
      this.id, 
      this.type,});

  InitialContext.fromJson(dynamic json) {
    login = json['login'];
    id = json['id'];
    type = json['type'];
  }
  String login;
  String id;
  String type;
InitialContext copyWith({  String login,
  String id,
  String type,
}) => InitialContext(  login: login ?? this.login,
  id: id ?? this.id,
  type: type ?? this.type,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['login'] = login;
    map['id'] = id;
    map['type'] = type;
    return map;
  }

}

class Context {
  Context({
      this.type,});

  Context.fromJson(dynamic json) {
    type = json['type'];
  }
  String type;
Context copyWith({  String type,
}) => Context(  type: type ?? this.type,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    return map;
  }

}