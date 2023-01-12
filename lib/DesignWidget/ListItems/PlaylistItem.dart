import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as m;
import 'package:gibbon_music/NewAPI/models/M_Playlist.dart';

import '../../API/MainMethod/GMethod.dart';
import 'AAPMain.dart';
class PlaylistItem extends StatelessWidget {
  const PlaylistItem({Key key, @required this.playlist, @required this.index}) : super(key: key);

  final MPlaylist playlist;
  final int index;

  @override
  Widget build(BuildContext context) {
    return AAPMain(
      onPressed: () {
        goToPlaylist(context, playlist.owner.uid.toString(), playlist.kind);
      },
      index: index,
      icon: m.Icons.playlist_add_check,
      bottomTitle: "${playlist.trackCount} Tracks",
      coverUri: playlist.cover.uri,
      subTitle: playlist.owner.name,
      title: playlist.title,
    );
  }
}
