import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/API/MainMethod/GMethod.dart';
import 'package:gibbon_music/NewAPI/models/M_Promotion.dart';
import 'package:mouse_parallax/mouse_parallax.dart';

import '../Styles/ConstValue.dart';

class PromotionItem extends StatelessWidget {
  const PromotionItem({Key key, @required this.promotion, @required this.index}) : super(key: key);

  final MPromotion promotion;
  final int index;

  @override
  Widget build(BuildContext context) {
    return HoverButton(
      onPressed: () {
        switch (promotion.heading.toLowerCase()) {
          case "плейлист":
            print(promotion.url);
            String uid = promotion.url.substring(7, promotion.url.indexOf("/playlists/"));
            int kind = int.parse(promotion.url.substring(promotion.url.indexOf("/playlists/") + 11, promotion.url.length));
            goToPlaylist(context, uid, kind);
            break;
        }
      },
      builder: (p0, state) {
        return Container(
          margin: EdgeInsets.only(right: 16, left: index == 0 && Platform.isAndroid ? 16 : 0),
          width: 350,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: ParallaxStack(
              layers: [
                ParallaxLayer(
                  xRotation: .25,
                  yRotation: .25,
                  yOffset: Platform.isWindows ? 10 : 0,
                  xOffset: Platform.isWindows ? 10 : 0,
                  child: AnimatedScale(
                    scale: state.isHovering ? 1.2 : 1,
                    duration: slowAnimation,
                    curve: Curves.fastLinearToSlowEaseIn,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        linkImage(promotion.image, 800),
                        width: 450,
                        height: 450,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                ),
                Container(
                  width: 450,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(colors: [
                        FluentTheme.of(context).checkedColor,
                        FluentTheme.of(context).checkedColor.withOpacity(.1),
                      ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(promotion.heading.toString().toUpperCase(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            color: FluentTheme.of(context).accentColor,
                          )),
                      Text(promotion.title.toString(),
                          maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      Text(
                        promotion.subtitle.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
