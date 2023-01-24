import 'package:animate_do/animate_do.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/constants/style_consts.dart';
import 'package:gibbon_music/domain/models/playlist.dart';
import 'package:gibbon_music/extensions/string.dart';
import 'package:gibbon_music/router.dart';
import 'package:gibbon_music/updated_ui/controls/buttons.dart';
import 'package:gibbon_music/updated_ui/widgets/ImageThumbnail.dart';
import 'package:provider/provider.dart';
import 'package:smooth_corner/smooth_corner.dart';

import '../../constants/ui_consts.dart';
import '../../providers/ux_provider.dart';

class ContextWidget extends StatefulWidget {
  const ContextWidget({Key? key}) : super(key: key);

  @override
  State<ContextWidget> createState() => _ContextWidgetState();
}

class _ContextWidgetState extends State<ContextWidget> {
  final GlobalKey _keyRed = GlobalKey();
  var x = 0.0;
  var y = 0.0;

  @override
  Widget build(BuildContext context) {
    UxProvider ux = context.watch();
    return StreamBuilder<TrackContextDetail>(
      stream: ux.onChangeDetails.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData && ux.isContextMenu) {

          var track = snapshot.data!.track;
          var x = snapshot.data!.details.globalPosition.dx.toInt();
          var y = snapshot.data!.details.globalPosition.dy.toInt();

          return FadeInUp(
            duration: AppConsts.fastAnimation,
            child: Stack(
              children: [
                HoverButton(onTapDown: () {
                  ux.isContextMenu = false;
                }, builder: (p0, state) {
                  return Container(
                    color: Colors.black.withOpacity(.5),
                    width: AppConsts.pageSize(context).width,
                    height: AppConsts.pageSize(context).height,
                  );
                }),
                Consumer<UxProvider>(builder: (context, value, child) {
                  if (x > AppConsts.pageSize(context).width / 2) {
                    x -= 266;
                  }
                  if (y > AppConsts.pageSize(context).height / 2) {
                    int btnCount = track.artists!.length + track.albums!.length + 5;
                    y -= (30*btnCount)+100;
                  }
                  return Positioned(
                    left: x.toDouble(),
                    top: y.toDouble(),
                    width: 250,
                    child: FadeInUp(
                      duration: const Duration(milliseconds: 100),
                        child: SmoothContainer(
                      padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                      key: _keyRed,
                      smoothness: 1,
                      borderRadius: BorderRadius.circular(16),
                      color: FluentTheme.of(context).cardColor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(.1),
                                      offset: const Offset(0,4),
                                      blurRadius: 5
                                    )
                                  ]
                                ),
                                child: ImageThumbnail(url: track.ogImage.toString().linkImage(100), height: 56, width: 56, radius: 16,),
                              ),
                              AppConsts.defaultHSpacer,
                              Expanded(child: Text(track.title.toString(), style: AppStyle.subTitle(context), maxLines: 1),),
                            ],
                          ),
                          AppConsts.defaultVSpacer,
                          GButton(onPressed: () {
                            context.read<NewPlaylist>().removeTrack(track);
                            ux.isContextMenu = false;
                          }, title: "Удалить из очереди"),
                          AppConsts.smallVSpacer,
                          GButton(onPressed: () {
                            context.read<NewPlaylist>().addTrackToEnd(track);
                            ux.isContextMenu = false;
                          }, title: "Добавить в конец"),
                          AppConsts.smallVSpacer,
                          GButton(onPressed: () {
                            context.read<NewPlaylist>().addTrackAfterCurrent(track);
                            ux.isContextMenu = false;
                          }, title: "Добавить после текущего"),
                          AppConsts.smallVSpacer,
                          GButton(onPressed: () {
                            ux.isContextMenu = false;
                          }, title: "Моя волна по треку"),
                          AppConsts.defaultHSpacer,
                          Text("Исполнители", style: AppStyle.subTitle(context),),
                          AppConsts.smallVSpacer,
                          for(var e in track.artists!) Padding(padding: const EdgeInsets.only(bottom: 8), child: GButton(onPressed: () {
                            AppRouter().gotoArtist(context, e.id);
                            ux.isContextMenu = false;
                          }, title: e.name!),),
                          AppConsts.defaultHSpacer,
                          Text("Альбомы", style: AppStyle.subTitle(context),),
                          AppConsts.smallVSpacer,
                          for(var e in track.albums!) Padding(padding: const EdgeInsets.only(bottom: 8), child: GButton(onPressed: () {
                            AppRouter().gotoAlbum(context, e.id!.toInt());
                            ux.isContextMenu = false;
                          }, title: e.title!),),
                        ],
                      ),
                    )),
                  );
                })
              ],
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
