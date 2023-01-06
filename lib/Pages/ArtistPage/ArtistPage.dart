import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/API/MainMethod/GMethod.dart';
import 'package:gibbon_music/API/YAM_Functions.dart';
import 'package:gibbon_music/DesignWidget/GButtons.dart';

import '../../API/Models/ArtistPage/MV_ArtistPage.dart';

class ArtistPage extends StatelessWidget {
  const ArtistPage({Key key, @required this.artistId}) : super(key: key);

  final int artistId;

  @override
  Widget build(BuildContext context) {
    MvArtistPage artistPage;
    Future<void> getData() async {
      artistPage = await getYamApiArtist(artistId);
      print(artistPage.artist.name);
    }

    return ScaffoldPage(
      content: SafeArea(
          child: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                    child: GTextButton(
                        onPress: () {
                          goToArtist(context, artistId);
                        },
                        text: artistPage.artist.name)),
              ],
            );
          } else {
            return const Center(
              child: ProgressRing(),
            );
          }
        },
      )),
    );
  }
}
