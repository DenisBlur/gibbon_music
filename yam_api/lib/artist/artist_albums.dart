import '../album/album.dart';
import '../pager.dart';

class ArtistAlbums {
  ArtistAlbums({
    this.pager,
    this.albums,});

  ArtistAlbums.fromJson(dynamic json) {
    pager = json['pager'] != null ? Pager.fromJson(json['pager']) : null;
    if (json['albums'] != null) {
      albums = [];
      json['albums'].forEach((v) {
        albums?.add(Album.fromJson(v));
      });
    }
  }
  Pager? pager;
  List<Album>? albums;
  ArtistAlbums copyWith({  Pager? pager,
    List<Album>? tracks,
  }) => ArtistAlbums(  pager: pager ?? this.pager,
    albums: tracks ?? albums,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (pager != null) {
      map['pager'] = pager?.toJson();
    }
    if (albums != null) {
      map['albums'] = albums?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}