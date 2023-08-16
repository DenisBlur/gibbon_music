import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/constants/style_consts.dart';
import 'package:gibbon_music/extensions/string.dart';
import 'package:gibbon_music/router.dart';
import 'package:gibbon_music/updated_ui/widgets/image_hovered.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:yam_api/landing/promotion.dart';

import '../../constants/app_consts.dart';

class PromotionCard extends StatelessWidget {
  const PromotionCard({Key? key, required this.data}) : super(key: key);

  final Promotion data;

  @override
  Widget build(BuildContext context) {
    return HoverButton(
      onPressed: () {
        if (data.url!.contains("playlist")) {
          String url = data.url!;
          String uid = url.substring(7, url.indexOf("/playlists/"));
          String kind = url.substring(url.indexOf("/playlists/") + 11, url.length);
          AppRouter().gotoPlaylist(context, uid, kind, false);
        }
        if (data.url!.contains("album")) {
          String url = data.url!;
          String uid = url.substring(7, url.length);
          AppRouter().gotoAlbum(context, int.parse(uid));
        }
        print(data.url!);
      },
      builder: (p0, state) {
        double imageState = 1.0;
        if (state.isPressing) {
          imageState = 0.9;
        } else if (state.isHovering) {
          imageState = 0.98;
        } else {
          imageState = 1;
        }

        return ClipRRect(borderRadius: BorderRadius.circular(8), child: SizedBox(
          width: AppConsts.wideCardWidth,
          height: AppConsts.wideCardHeight,
          child: Stack(
            children: [
              FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: data.image!.linkImage(400),
                width: AppConsts.wideCardWidth,
                height: AppConsts.wideCardHeight,
                fit: BoxFit.cover,
              ),
              Container(
                width: AppConsts.wideCardWidth,
                height: AppConsts.wideCardHeight,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color.fromRGBO(34, 34, 34, 1),
                    Color.fromRGBO(34, 34, 34, 0),
                  ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
                ),
              ),
              AnimatedScale(
                scale: imageState + 0.01,
                duration: AppConsts.defaultAnimation,
                curve: AppConsts.defaultCurve,
                child: Container(
                  padding: const EdgeInsets.only(bottom: 0, right: 16, left: 16),
                  width: AppConsts.wideCardWidth,
                  height: AppConsts.wideCardHeight-16,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(data.title!, style: AppStyle.prTitle(context), maxLines: 1, overflow: TextOverflow.ellipsis),
                      Text(data.subtitle!, style: AppStyle.prSubTitle(context), maxLines: 1, overflow: TextOverflow.ellipsis),
                      Text(data.heading!.toUpperCase(), style: AppStyle.prHeading(context), maxLines: 1, overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),);
      },
    );
  }
}
