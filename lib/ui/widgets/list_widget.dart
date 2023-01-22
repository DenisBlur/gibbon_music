import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/constants/ui_consts.dart';
import 'package:gibbon_music/ui/widgets/album_card.dart';
import 'package:yam_api/album/album.dart';
import 'package:yam_api/artist/brief_info.dart';
import 'package:yam_api/playlist/playlist.dart';

class ListWidget extends StatelessWidget {
  const ListWidget({Key? key, required this.list}) : super(key: key);

  final List<dynamic> list;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppConsts.standartCardHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          Widget listItem = const Text("");

          if (list is List<MPlaylist>) {
            listItem = PlaylistCard(playlist: list[index]);
          }

          if (list is List<BriefInfo>) {
            listItem = ArtistCard(artist: list[index]);
          }

          if (list is List<Album>) {
            listItem = AlbumCard(album: list[index]);
          }

          return listItem;
        },
        itemCount: list.length,
      ),
    );
  }
}
