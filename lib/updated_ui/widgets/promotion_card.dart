import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/constants/style_consts.dart';
import 'package:gibbon_music/router.dart';
import 'package:gibbon_music/updated_ui/widgets/image_hovered.dart';
import 'package:smooth_corner/smooth_corner.dart';
import 'package:yam_api/landing/promotion.dart';

import '../../constants/ui_consts.dart';

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
      },
      builder: (p0, state) {
        double imageState = 1.0;
        if (state.isPressing) {
          imageState = 0.9;
        } else if (state.isHovering) {
          imageState = 0.98;
        } else {
          imageState = .95;
        }

        return SizedBox(
          width: AppConsts.wideCardWidth(context),
          height: AppConsts.wideCardHeight(context),
          child: Stack(
            children: [
              ImageHovered(
                imageState: imageState,
                uri: data.image!,
                uriSize: 400,
                height: AppConsts.wideCardHeight(context) - 16,
                width: AppConsts.wideCardWidth(context),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 32, right: 16, left: 16),
                width: AppConsts.wideCardWidth(context),
                height: AppConsts.wideCardHeight(context),
                decoration: ShapeDecoration(
                  gradient: LinearGradient(colors: [
                    FluentTheme.of(context).scaffoldBackgroundColor.withOpacity(1),
                    FluentTheme.of(context).scaffoldBackgroundColor.withOpacity(0),
                  ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
                  shape: SmoothRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                    smoothness: 1,
                  ),
                ),
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
            ],
          ),
        );
      },
    );
  }
}
