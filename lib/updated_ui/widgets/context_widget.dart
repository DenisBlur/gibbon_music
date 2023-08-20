import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/constants/style_consts.dart';
import 'package:gibbon_music/domain/models/playlist.dart';
import 'package:gibbon_music/extensions/string.dart';
import 'package:gibbon_music/router.dart';
import 'package:gibbon_music/updated_ui/widgets/Image_thumbnail.dart';
import 'package:provider/provider.dart';
import 'package:yam_api/track/track.dart';

import '../../constants/app_consts.dart';

class ContextWidget extends StatelessWidget {
  const ContextWidget({Key? key, required this.track}) : super(key: key);

  final Track track;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Container(
              constraints: const BoxConstraints(
                maxWidth: 250,
                maxHeight: 450,
              ),
              padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(22, 22, 22, 1),
                borderRadius: BorderRadius.circular(8)
              ),
              child: SingleChildScrollView(
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
                              boxShadow: [BoxShadow(color: Colors.black.withOpacity(.1), offset: const Offset(0, 4), blurRadius: 5)]),
                          child: ImageThumbnail(
                            url: track.ogImage.toString().linkImage(100),
                            height: 56,
                            width: 56,
                            radius: 16,
                          ),
                        ),
                        AppConsts.defaultHSpacer,
                        Expanded(
                          child: Text(track.title.toString(), style: AppStyle.subTitle(context), maxLines: 1),
                        ),
                      ],
                    ),
                    AppConsts.defaultVSpacer,
                    Button(
                        onPressed: () {
                          Navigator.pop(context);
                          context.read<NewPlaylist>().removeTrack(track);
                        },
                        child: const Text("Удалить из очереди")),
                    AppConsts.smallVSpacer,
                    Button(
                        onPressed: () {
                          Navigator.pop(context);
                          context.read<NewPlaylist>().addTrackToEnd(track);
                        },
                        child: const Text("Добавить в конец")),
                    AppConsts.smallVSpacer,
                    Button(
                        onPressed: () {
                          Navigator.pop(context);
                          context.read<NewPlaylist>().addTrackAfterCurrent(track);
                        },
                        child: const Text("Добавить после текущего")),
                    AppConsts.smallVSpacer,
                    Button(
                        onPressed: () {
                          Navigator.pop(context);
                          context.read<NewPlaylist>().startRadio(station: "track:${track.albums![0].id}");
                        },
                        child: const Text("Моя волна по треку")),
                    AppConsts.smallVSpacer,
                    Text(
                      "Исполнители",
                      style: AppStyle.subTitle(context),
                    ),
                    AppConsts.smallVSpacer,
                    for (var e in track.artists!)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Button(
                            onPressed: () {
                              Navigator.pop(context);
                              AppRouter().gotoArtist(context, e.id);
                            },
                            child: Text(e.name!)),
                      ),
                    AppConsts.smallVSpacer,
                    Text(
                      "Альбомы",
                      style: AppStyle.subTitle(context),
                    ),
                    AppConsts.smallVSpacer,
                    for (var e in track.albums!)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Button(
                            onPressed: () {
                              Navigator.pop(context);
                              AppRouter().gotoAlbum(context, e.id!.toInt());
                            },
                            child: Text(e.title!)),
                      ),
                  ],
                ),
              )),
        ),
      ],
    );
  }
}
