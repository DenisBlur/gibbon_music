import 'package:animate_do/animate_do.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/api/models/M_Track.dart';
import 'package:gibbon_music/constants/ui_consts.dart';
import 'package:gibbon_music/extensions/string.dart';
import 'package:gibbon_music/providers/audio_provider.dart';
import 'package:gibbon_music/providers/playlist_provider.dart';
import 'package:gibbon_music/ui/widgets/ImageThumbnail.dart';
import 'package:gibbon_music/ui/widgets/track_card.dart';
import 'package:provider/provider.dart';

class PlayerInfo extends StatelessWidget {
  const PlayerInfo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AudioProvider provider = context.watch();
    PlayListProvider playlist = context.watch();
    MTrack track = playlist.currentTrack;
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: FluentTheme.of(context).scaffoldBackgroundColor,
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(.15), offset: Offset(0, 8), blurRadius: 5)]),
          child: ImageThumbnail(
            url: track.coverUri.linkImage(100),
            height: 44,
            width: 44,
          ),
        ),
        AppConsts.defaultHSpacer,
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text(track.title), ArtistsListWidgets(mInnerArtistList: track.artists)],
        )
      ],
    );
  }
}
