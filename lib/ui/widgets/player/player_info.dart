import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/constants/ui_consts.dart';
import 'package:gibbon_music/extensions/string.dart';
import 'package:gibbon_music/providers/audio_provider.dart';
import 'package:gibbon_music/providers/playlist_provider.dart';
import 'package:gibbon_music/ui/widgets/ImageThumbnail.dart';
import 'package:gibbon_music/ui/widgets/track_card.dart';
import 'package:provider/provider.dart';
import 'package:yam_api/track/track.dart';

class PlayerInfo extends StatelessWidget {
  const PlayerInfo({Key? key, this.animationCoef}) : super(key: key);

  final double? animationCoef;

  @override
  Widget build(BuildContext context) {
    AudioProvider provider = context.watch();
    PlayListProvider playlist = context.watch();
    Track? track = playlist.currentTrack;

    double? coef = animationCoef ?? 0;
    var page = MediaQuery.of(context).size;

    double x = lerpDouble(-60, -16, coef)!.toDouble();
    double y = lerpDouble(0, 16, coef)!.toDouble();

    return Stack(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 28),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: FluentTheme.of(context).scaffoldBackgroundColor,
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(.15), offset: Offset(0, 8), blurRadius: 5)]),
          child: ImageThumbnail(
            url: track!.coverUri!.linkImage(400),
            height: lerpDouble(44, page.width-32, coef)!.toDouble(),
            width: lerpDouble(44, page.width-32, coef)!.toDouble(),
          ),
        ),
        AppConsts.defaultHSpacer,
        Transform.translate(offset: Offset(-x, y), child:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text(track.title!), ArtistsListWidgets(mInnerArtistList: track.artists!)],
        ),),
      ],
    );
  }
}
