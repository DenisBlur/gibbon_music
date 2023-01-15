import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/api/models/M_Album.dart';
import 'package:gibbon_music/api/models/M_Playlist.dart';
import 'package:gibbon_music/constants/ui_consts.dart';
import 'package:gibbon_music/extensions/string.dart';
import 'package:gibbon_music/providers/artist_provider.dart';
import 'package:gibbon_music/ui/widgets/content_loader.dart';
import 'package:gibbon_music/ui/widgets/loading_ring.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../api/models/PageModels/M_PageArtist.dart';
import '../../constants/style_consts.dart';
import '../../providers/audio_provider.dart';
import '../widgets/album_card.dart';
import '../widgets/scroller_scaffold.dart';
import '../widgets/track_card.dart';

class PageArtist extends StatelessWidget {
  const PageArtist({Key key, this.id}) : super(key: key);

  final int id;

  @override
  Widget build(BuildContext context) {
    AudioProvider audioProvider = context.read();

    ArtistProvider artistProvider = context.read();
    artistProvider.dispose();

    return ScaffoldPage(
        padding: const EdgeInsets.all(0),
        content: ContentLoader(
          future: artistProvider.init(id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              MPageArtist mPageArtist = artistProvider.mPageArtist;
              return ScaffoldScroller(slivers: [
                SliverPersistentHeader(
                  pinned: false,
                  delegate: ArtistHeader(mPageArtist.artist.ogImage, 200, mPageArtist.artist.name),
                ),
                SliverToBoxAdapter(
                    child: FadeInUp(
                  delay: const Duration(milliseconds: 150),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [AppConsts.defaultVSpacer, Text("Популярные треки", style: AppStyle.header1Style), AppConsts.defaultVSpacer],
                  ),
                )),
                SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (context, index) => Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: TrackCard(
                                track: mPageArtist.popularTracks[index],
                                onPressed: () {
                                  audioProvider.setPlaylist(mPageArtist.popularTracks);
                                  audioProvider.playTrack(index);
                                },
                              ),
                            ),
                        childCount: mPageArtist.popularTracks.length)),
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppConsts.defaultVSpacer,
                      FadeInUp(child: const Text("Альбомы", style: AppStyle.header1Style)),
                      AppConsts.defaultVSpacer,
                      AlbumSection(
                        albums: mPageArtist.albums,
                      ),
                      AppConsts.defaultVSpacer,
                      FadeInUp(child: const Text("Плейлисты", style: AppStyle.header1Style)),
                      AppConsts.defaultVSpacer,
                      PlaylistSection(
                        playlist: mPageArtist.playlists,
                      ),
                    ],
                  ),
                ),
              ]);
            } else {
              return const LoadingRing();
            }
          },
        ));
  }
}

class AlbumSection extends StatelessWidget {
  const AlbumSection({Key key, @required this.albums}) : super(key: key);

  final List<MAlbum> albums;

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
        delay: const Duration(milliseconds: 250),
        child: SizedBox(
          height: 186,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(padding: const EdgeInsets.only(right: 16), child: AlbumCard(album: albums[index]));
            },
            itemCount: albums.length,
          ),
        ));
  }
}

class PlaylistSection extends StatelessWidget {
  const PlaylistSection({Key key, @required this.playlist}) : super(key: key);

  final List<MPlaylist> playlist;

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
        delay: const Duration(milliseconds: 400),
        child: SizedBox(
          height: 186,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(padding: const EdgeInsets.only(right: 16), child: PlaylistCard(playlist: playlist[index]));
            },
            itemCount: playlist.length,
          ),
        ));
  }
}

class ArtistHeader extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final String image, name;

  ArtistHeader(this.image, this.expandedHeight, this.name);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return ClipRRect(
      child: Stack(
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width,
              height: expandedHeight,
              child: ClipRRect(
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaY: 20, sigmaX: 20),
                  child: FadeInImage.memoryNetwork(placeholder: kTransparentImage, fit: BoxFit.cover, image: image.linkImage(600)),
                ),
              )),
          Container(
            width: MediaQuery.of(context).size.width,
            height: expandedHeight,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [FluentTheme.of(context).scaffoldBackgroundColor, FluentTheme.of(context).scaffoldBackgroundColor.withOpacity(.5)],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter)),
          ),
          Positioned(
              left: 16,
              bottom: (shrinkOffset / 4) + 16,
              child: Row(
                children: [
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: FadeInImage.memoryNetwork(placeholder: kTransparentImage, image: image.linkImage(100)),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Opacity(
                        opacity: (1 - shrinkOffset / expandedHeight),
                        child: Text(
                          "Исполнитель",
                          style: TextStyle(fontSize: 14, color: FluentTheme.of(context).uncheckedColor.withOpacity(.5)),
                        ),
                      ),
                      Text(
                        name,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                      ),
                    ],
                  ),
                ],
              )),
        ],
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => 200;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
