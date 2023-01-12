import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/constants/style_consts.dart';
import 'package:gibbon_music/constants/ui_consts.dart';
import 'package:gibbon_music/extensions/string.dart';
import 'package:gibbon_music/ui/widgets/card_view.dart';

import '../widgets/ImageThumbnail.dart';

class AlbumCard extends StatelessWidget {
  const AlbumCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GCardView(
      onPressed: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ImageThumbnail(url: "avatars.yandex.net/get-music-content/7548376/aef04514.a.23754447-1/%x%".linkImage(200), width: 150, height: 150),
          AppConsts.smallVSpacer,
          Text("Любимое в Spotify", style: AppStyle.trackHeaderStyle),
          Text("Denis Tokar", style: AppStyle.subTrackHeaderStyle(context)),
        ],
      ),
    );
  }
}
