import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as m;
import 'package:gibbon_music/API/MainMethod/GMethod.dart';
import 'package:gibbon_music/NewAPI/models/M_Album.dart';

import 'AAPMain.dart';
class AlbumItem extends StatelessWidget {
  const AlbumItem({Key key, @required this.album, @required this.index}) : super(key: key);

  final MAlbum album;
  final int index;

  @override
  Widget build(BuildContext context) {
    return AAPMain(
      onPressed: () {
        goToAlbum(context, album.id);
      },
      index: index,
      icon: m.Icons.album,
      bottomTitle: album.year.toString(),
      coverUri: album.coverUri,
      subTitle: album.artists.first.name,
      title: album.title,
    );

  }
}
