import 'package:darq/darq.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as m;
import 'package:gibbon_music/constants/ui_consts.dart';
import 'package:gibbon_music/extensions/duration.dart';
import 'package:gibbon_music/extensions/string.dart';
import 'package:gibbon_music/providers/ux_provider.dart';
import 'package:gibbon_music/updated_ui/widgets/ImageThumbnail.dart';
import 'package:gibbon_music/updated_ui/widgets/card_view.dart';
import 'package:provider/provider.dart';
import 'package:yam_api/artist/brief_info.dart';
import 'package:yam_api/track/track.dart';
import 'package:yam_api/yam_api.dart';

import '../../constants/style_consts.dart';
import '../../providers/yandex_provider.dart';
import '../controls/buttons.dart';
import '../other/music_visualizer.dart';

class TrackCard extends StatelessWidget {
  const TrackCard({Key? key, required this.track, required this.onPressed}) : super(key: key);

  final VoidCallback onPressed;
  final Track track;

  @override
  Widget build(BuildContext context) {
    YandexProvider yandexProvider = context.watch();
    bool isPlay = false;
    bool isSelected = false;
    bool isLike = yandexProvider.trackIsLiked(track.id.toString());
    String image = track.coverUri != null ? track.coverUri!.linkImage(100) : AppConsts.imageEmptyLink;

    return GestureDetector(
        onSecondaryTapUp: (details) {
          UxProvider ux = context.read();
          ux.onChangeDetails.add(details);
          ux.isContextMenu = true;
        },
        child:GCardView(
      onPressed: () {
        onPressed();
        YamApi().getTrack(track.id);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            children: [
              ImageThumbnail(url: image, height: 44, width: 44),
              AnimatedScale(
                scale: isSelected ? 1 : 0,
                duration: AppConsts.slowAnimation,
                curve: AppConsts.defaultCurve,
                child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: FluentTheme
                        .of(context)
                        .cardColor
                        .withOpacity(.4)),
                    child: Center(
                      child: MiniMusicVisualizer(
                        color: Colors.red,
                        active: isPlay,
                        width: 4,
                        height: 15,
                      ),
                    )),
              ),
            ],
          ),
          AppConsts.defaultHSpacer,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  track.title.toString(),
                  maxLines: 1,
                  style: AppStyle.trackHeaderStyle,
                  overflow: TextOverflow.ellipsis,
                ),
                ArtistsListWidgets(
                  mInnerArtistList: track.artists,
                )
              ],
            ),
          ),
          AppConsts.fillSpacer,
          TrackCommandBar(isLike: isLike, id: track.id),
          Text(track.durationMs == null ? "" : Duration(milliseconds: track.durationMs!.toInt()).toHms()),
        ],
      ),
    ));
  }
}

class ArtistsListWidgets extends StatelessWidget {
  const ArtistsListWidgets({Key? key, required this.mInnerArtistList}) : super(key: key);

  final List<BriefInfo>? mInnerArtistList;

  @override
  Widget build(BuildContext context) {
    List<String> artistButtonList = [];

    artistButtonList = mInnerArtistList!.select((element, index) => element.name.toString()).toList();

    return GTextButton(onPressed: () {}, title: artistButtonList.join(","));
  }
}

class TrackCommandBar extends StatelessWidget {
  const TrackCommandBar({Key? key, this.isLike = false, this.id}) : super(key: key);

  final String? id;
  final bool isLike;

  @override
  Widget build(BuildContext context) {
    likeAction() async {
      await context.read<YandexProvider>().trackActionLike(id.toString());
    }

    return Row(
      children: [
        GIconButton(
          onPressed: () {
            likeAction();
          },
          icon: isLike ? m.Icons.favorite : m.Icons.favorite_border_rounded,
          iconColor: isLike ? FluentTheme
              .of(context)
              .accentColor : Colors.transparent,
        ),
        AppConsts.defaultHSpacer,
      ],
    );
  }
}
