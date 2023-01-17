import '../pager.dart';
import '../track/track.dart';

class ArtistTracks {
  ArtistTracks({
    this.pager,
    this.tracks,
  });

  ArtistTracks.fromJson(dynamic json) {
    pager = json['pager'] != null ? Pager.fromJson(json['pager']) : null;
    if (json['tracks'] != null) {
      tracks = [];
      json['tracks'].forEach((v) {
        tracks?.add(Track.fromJson(v));
      });
    }
  }

  Pager? pager;
  List<Track>? tracks;

  ArtistTracks copyWith({
    Pager? pager,
    List<Track>? tracks,
  }) =>
      ArtistTracks(
        pager: pager ?? this.pager,
        tracks: tracks ?? this.tracks,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (pager != null) {
      map['pager'] = pager?.toJson();
    }
    if (tracks != null) {
      map['tracks'] = tracks?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
