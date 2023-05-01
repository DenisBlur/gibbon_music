import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gibbon_music/constants/app_consts.dart';
import 'package:gibbon_music/extensions/string.dart';
import 'package:gibbon_music/updated_ui/player/windows/win_player_controls.dart';
import 'package:gibbon_music/updated_ui/widgets/Image_thumbnail.dart';
import 'package:gibbon_music/updated_ui/widgets/playlist_widget.dart';
import 'package:gibbon_music/updated_ui/widgets/track_card.dart';
import 'package:provider/provider.dart';
import 'package:yam_api/track/track.dart';

import '../../constants/style_consts.dart';
import '../../domain/models/playlist.dart';
import '../widgets/header.dart';

class PageFullscreen extends StatelessWidget {
  const PageFullscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    NewPlaylist playlist = context.watch();
    Track? track = playlist.currentTrack;

    return ScaffoldPage(
      padding: const EdgeInsets.all(0),
      content: Stack(
        children: [
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ImageThumbnail(
                    url: track!.ogImage!.linkImage(600), width: AppConsts.pageSize(context).width / 4, height: AppConsts.pageSize(context).width / 4),
                SizedBox(
                  width: AppConsts.pageSize(context).width / 4,
                  child: Text(
                    track.title!,
                    style: AppStyle.title(context),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                SizedBox(
                  width: AppConsts.pageSize(context).width / 4,
                  child: ArtistsListWidgets(
                    track: track,
                  ),
                ),
                AppConsts.defaultVSpacer,
                const PlayerMainControl(),
              ],
            ),
          ),
          const UPlaylistWidget(),
          const Header(menu: false),
        ],
      ).animate(delay: 500.ms).fadeIn().moveY(begin: 150, end: 0, curve: AppConsts.defaultCurve, duration: 1500.ms),
    );
  }
}
