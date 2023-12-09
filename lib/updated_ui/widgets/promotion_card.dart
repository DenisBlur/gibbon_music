import 'package:flutter/material.dart';
import 'package:gibbon_music/extensions/string.dart';
import 'package:gibbon_music/router.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:yam_api/landing/promotion.dart';

import '../../constants/app_consts.dart';

class PromotionCard extends StatelessWidget {
  const PromotionCard({Key? key, required this.data}) : super(key: key);

  final Promotion data;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: SizedBox(
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
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Theme.of(context).colorScheme.secondaryContainer,
                    Theme.of(context).colorScheme.secondaryContainer.withOpacity(0),
                  ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
                ),
              ),
              AnimatedScale(
                scale: 1,
                duration: AppConsts.defaultAnimation,
                curve: AppConsts.defaultCurve,
                child: Container(
                  padding: const EdgeInsets.only(bottom: 0, right: 16, left: 16),
                  width: AppConsts.wideCardWidth,
                  height: AppConsts.wideCardHeight - 16,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(data.title!, maxLines: 1, overflow: TextOverflow.ellipsis),
                      Text(data.subtitle!, maxLines: 1, overflow: TextOverflow.ellipsis),
                      Text(data.heading!.toUpperCase(), maxLines: 1, overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
