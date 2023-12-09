import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:darq/darq.dart';
import 'package:flutter/material.dart' as m;
import 'package:flutter/material.dart';
import 'package:gibbon_music/constants/app_consts.dart';
import 'package:gibbon_music/extensions/duration.dart';
import 'package:gibbon_music/extensions/string.dart';
import 'package:gibbon_music/providers/audio_provider.dart';
import 'package:gibbon_music/updated_ui/widgets/Image_thumbnail.dart';
import 'package:gibbon_music/updated_ui/widgets/card_view.dart';
import 'package:gibbon_music/updated_ui/widgets/context_widget.dart';
import 'package:provider/provider.dart';
import 'package:yam_api/track/track.dart';
import 'package:yam_api/yam_api.dart';

import '../../domain/models/playlist.dart';
import '../../providers/yandex_provider.dart';
import '../other/music_visualizer.dart';

class TrackCard extends StatelessWidget {
  const TrackCard({Key? key, required this.track, required this.onPressed}) : super(key: key);

  final VoidCallback onPressed;
  final Track track;

  //final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    YandexProvider yandexProvider = context.watch();
    bool isPlay = false;
    bool isSelected = false;
    bool isLike = yandexProvider.trackIsLiked(track.id.toString());
    String image = track.coverUri != null ? track.coverUri!.linkImage(80) : AppConsts.imageEmptyLink;

    double size = Platform.isWindows ? 44 : 56;

    if (context.watch<NewPlaylist>().currentTrack != null) {
      isSelected = track.id == context.watch<NewPlaylist>().currentTrack!.id;
      isPlay = context.watch<AudioProvider>().playerState == PlayerState.playing;
    }

    return GestureDetector(
        onSecondaryTapUp: (details) {
          showDialog(
            barrierDismissible: true,
            context: context,
            builder: (context) {
              return ContextWidget(track: track);
            },
          );
        },
        child: GCardView(
          onPressed: () {
            onPressed();
            YamApi().getTrack(track.id);
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Stack(
                  children: [
                    ImageThumbnail(url: image, height: size, width: size),
                    AnimatedScale(
                      scale: isSelected ? 1 : 0,
                      duration: AppConsts.slowAnimation,
                      curve: AppConsts.defaultCurve,
                      child: Container(
                          width: size,
                          height: size,
                          decoration: BoxDecoration(color: Theme.of(context).colorScheme.primaryContainer.withOpacity(.4)),
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
              ),
              AppConsts.defaultHSpacer,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      track.title.toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    ArtistsListWidgets(
                      track: track,
                    )
                  ],
                ),
              ),
              AppConsts.fillSpacer,
              if (Platform.isWindows) TrackCommandBar(isLike: isLike, id: track.id),
              Text(track.durationMs == null ? "" : Duration(milliseconds: track.durationMs!.toInt()).toHms()),
            ],
          ),
        ));
  }
}

class ArtistsListWidgets extends StatelessWidget {
  const ArtistsListWidgets({Key? key, required this.track}) : super(key: key);

  final Track track;

  @override
  Widget build(BuildContext context) {
    List<String> artistButtonList = [];

    artistButtonList = track.artists!.select((element, index) => element.name.toString()).toList();

    return InkWell(
      onTap: () {
        showDialog(
          barrierDismissible: true,
          context: context,
          builder: (context) {
            return ContextWidget(track: track);
          },
        );
      },
      child: Text(
        artistButtonList.join(", "),
        maxLines: 1,
      ),
    );
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
        IconButton(
            onPressed: () {
              likeAction();
            },
            icon: Icon(
              isLike ? m.Icons.favorite : m.Icons.favorite_border_rounded,
              size: 24,
            )),
        AppConsts.defaultHSpacer,
      ],
    );
  }
}
