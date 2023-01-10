import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/DesignWidget/GListView/GInfinityListView.dart';
import 'package:gibbon_music/DesignWidget/ListItems/AlbumItem.dart';
import 'package:gibbon_music/DesignWidget/ListItems/ArtistItem.dart';
import 'package:gibbon_music/DesignWidget/ListItems/PlaylistItem.dart';
import 'package:gibbon_music/NewAPI/models/M_Album.dart';
import 'package:gibbon_music/NewAPI/models/M_Artist.dart';
import 'package:gibbon_music/NewAPI/models/M_Entities.dart';
import 'package:gibbon_music/NewAPI/models/M_Playlist.dart';

import '../../../DesignWidget/Styles/ConstValue.dart';

class PlayContextSection extends StatelessWidget {
  const PlayContextSection({Key key, @required this.playContexts})
      : super(key: key);

  final List<MEntities> playContexts;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 212,
      child: GListView(
        scrollButtons: Platform.isWindows,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {

          Widget widget;

          switch(playContexts[index].data["context"]) {
            case "album":
              MAlbum album = MAlbum.fromJson(playContexts[index].data["payload"]);
              widget = AlbumItem(album: album, index: index);
              break;
            case "artist":
              MArtist artist = MArtist.fromJson(playContexts[index].data["payload"]);
              widget = ArtistItem(artist: artist, index: index);
              break;
            default:
              MPlaylist playlist = MPlaylist.fromJson(playContexts[index].data["payload"]);
              widget = PlaylistItem(playlist: playlist, index: index);
              break;
          }

          return FadeIn(
            duration: fastAnimation,
            delay: Duration(milliseconds: 50 * index),
            child: widget,
          );
        },
        itemCount: playContexts.length,
      ),
    );
  }
}
