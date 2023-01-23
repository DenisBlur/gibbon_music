import '../track/track.dart';

class RotorTracks {
  RotorTracks({
      this.id, 
      this.sequence, 
      this.batchId, 
      this.pumpkin,});

  RotorTracks.fromJson(dynamic json) {
    id = json['id'] != null ? Id.fromJson(json['id']) : null;
    if (json['sequence'] != null) {
      sequence = [];
      json['sequence'].forEach((v) {
        sequence?.add(Sequence.fromJson(v));
      });
    }
    batchId = json['batchId'];
    pumpkin = json['pumpkin'];
  }
  Id? id;
  List<Sequence>? sequence;
  String? batchId;
  bool? pumpkin;
RotorTracks copyWith({  Id? id,
  List<Sequence>? sequence,
  String? batchId,
  bool? pumpkin,
}) => RotorTracks(  id: id ?? this.id,
  sequence: sequence ?? this.sequence,
  batchId: batchId ?? this.batchId,
  pumpkin: pumpkin ?? this.pumpkin,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (id != null) {
      map['id'] = id?.toJson();
    }
    if (sequence != null) {
      map['sequence'] = sequence?.map((v) => v.toJson()).toList();
    }
    map['batchId'] = batchId;
    map['pumpkin'] = pumpkin;
    return map;
  }

}

class Sequence {
  Sequence({
      this.type, 
      this.track, 
      this.liked, 
      this.trackParameters,});

  Sequence.fromJson(dynamic json) {
    type = json['type'];
    track = json['track'] != null ? Track.fromJson(json['track']) : null;
    liked = json['liked'];
    trackParameters = json['trackParameters'] != null ? TrackParameters.fromJson(json['trackParameters']) : null;
  }
  String? type;
  Track? track;
  bool? liked;
  TrackParameters? trackParameters;
Sequence copyWith({  String? type,
  Track? track,
  bool? liked,
  TrackParameters? trackParameters,
}) => Sequence(  type: type ?? this.type,
  track: track ?? this.track,
  liked: liked ?? this.liked,
  trackParameters: trackParameters ?? this.trackParameters,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    if (track != null) {
      map['track'] = track?.toJson();
    }
    map['liked'] = liked;
    if (trackParameters != null) {
      map['trackParameters'] = trackParameters?.toJson();
    }
    return map;
  }

}

class TrackParameters {
  TrackParameters({
      this.bpm, 
      this.hue, 
      this.energy,});

  TrackParameters.fromJson(dynamic json) {
    bpm = json['bpm'];
    hue = json['hue'];
    energy = json['energy'];
  }
  num? bpm;
  num? hue;
  num? energy;
TrackParameters copyWith({  num? bpm,
  num? hue,
  num? energy,
}) => TrackParameters(  bpm: bpm ?? this.bpm,
  hue: hue ?? this.hue,
  energy: energy ?? this.energy,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bpm'] = bpm;
    map['hue'] = hue;
    map['energy'] = energy;
    return map;
  }

}

class Id {
  Id({
      this.type,
      this.tag,});

  Id.fromJson(dynamic json) {
    type = json['type'];
    tag = json['tag'];
  }
  String? type;
  String? tag;
Id copyWith({  String? type,
  String? tag,
}) => Id(  type: type ?? this.type,
  tag: tag ?? this.tag,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['tag'] = tag;
    return map;
  }

}