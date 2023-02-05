import 'dart:ui';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/constants/app_consts.dart';
import 'package:gibbon_music/domain/models/playlist.dart';
import 'package:gibbon_music/extensions/string.dart';
import 'package:gibbon_music/updated_ui/widgets/ImageThumbnail.dart';
import 'package:gibbon_music/updated_ui/widgets/track_card.dart';
import 'package:provider/provider.dart';
import 'package:yam_api/track/track.dart';

class PlayerInfo extends StatelessWidget {
  const PlayerInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NewPlaylist playlist = context.watch();
    Track? track = playlist.currentTrack;
    return SizedBox(
      width: AppConsts.pageSize(context).width,
      height: AppConsts.pageSize(context).height,
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 28),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: FluentTheme.of(context).scaffoldBackgroundColor,
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(.15), offset: const Offset(0, 8), blurRadius: 5)]),
            child: ImageThumbnail(
              url: track!.coverUri!.linkImage(400),
              height: 44,
              width: 44,
            ),
          ),
          AppConsts.defaultHSpacer,
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: AppConsts.pageSize(context).width / 6, child:Text(
                track.title!,
                style: const TextStyle(fontSize:14),
                overflow: TextOverflow.ellipsis,
              ),),
              SizedBox(width: AppConsts.pageSize(context).width / 6, child: ArtistsListWidgets(track: track),)
            ],
          ),
        ],
      ),
    );
  }
}
