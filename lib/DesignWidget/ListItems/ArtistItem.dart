import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as m;
import 'package:gibbon_music/API/MainMethod/GMethod.dart';
import 'package:gibbon_music/DesignWidget/ListItems/AAPMain.dart';
import 'package:gibbon_music/DesignWidget/Styles/ConstValue.dart';
import 'package:gibbon_music/NewAPI/models/M_Artist.dart';

class ArtistItem extends StatelessWidget {
  const ArtistItem({Key key, @required this.artist, @required this.index}) : super(key: key);

  final MArtist artist;
  final int index;

  @override
  Widget build(BuildContext context) {
    return AAPMain(
      onPressed: () {
        goToArtist(context, int.parse(artist.id));
      },
      icon: m.Icons.person,
      index: index,
      bottomTitle: artist.genres.isNotEmpty ? artist.genres.first : "",
      coverUri:  artist.cover != null ? artist.cover.uri : imagePlaceholder,
      subTitle: "${artist.counts.tracks} Tracks",
      title: artist.name,
    );
  }
}
