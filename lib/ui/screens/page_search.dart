import 'package:animate_do/animate_do.dart' as ad;
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:gibbon_music/constants/style_consts.dart';
import 'package:gibbon_music/constants/ui_consts.dart';
import 'package:gibbon_music/providers/search_provider.dart';
import 'package:gibbon_music/ui/controls/buttons.dart';
import 'package:gibbon_music/ui/widgets/card_view.dart';
import 'package:gibbon_music/ui/widgets/scroller_scaffold.dart';
import 'package:gibbon_music/ui/widgets/track_card.dart';
import 'package:provider/provider.dart';
import 'package:yam_api/album/album.dart';
import 'package:yam_api/artist/brief_info.dart';
import 'package:yam_api/playlist/playlist.dart';
import 'package:yam_api/track/track.dart';

import '../widgets/album_card.dart';
import '../widgets/list_widget.dart';

class PageSearch extends StatelessWidget {
  const PageSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();
    return ScaffoldPage(
        padding: EdgeInsets.zero,
        content: Consumer<SearchProvider>(builder: (_, search, __) {
          List<Widget> lists = [];

          if (search.suggest.suggestions != null && search.suggest.suggestions!.isNotEmpty) {
            if (!search.isSuggests && search.searchResult.tracks != null) {
              if (search.searchResult.best != null && search.searchResult.best!.result != null) {
                Widget widget = Text(search.searchResult.best!.type.toString());
                var type = search.searchResult.best!.type;
                var results = search.searchResult.best!.result;
                switch (type) {
                  case "album":
                    Album data = Album.fromJson(results);
                    widget = AlbumCard(album: data);
                    break;
                  case "playlist":
                    MPlaylist data = MPlaylist.fromJson(results);
                    widget = PlaylistCard(playlist: data);
                    break;
                  case "artist":
                    BriefInfo data = BriefInfo.fromJson(results);
                    widget = ArtistCard(artist: data);
                    break;
                  case "track":
                    Track data = Track.fromJson(results);
                    widget = TrackCard(
                      track: data,
                      onPressed: () {},
                    );
                    break;
                  default:
                    break;
                }
                lists.add(const SliverToBoxAdapter(
                    child: Text(
                  "Лучший результат",
                  style: AppStyle.header1Style,
                )));
                lists.add(const SliverToBoxAdapter(child: AppConsts.smallVSpacer));
                lists.add(SliverToBoxAdapter(child: widget));
              }
              if (search.searchResult.artists != null && search.searchResult.artists!.results != null) {
                var results = search.searchResult.artists!.results;
                lists.add(const SliverToBoxAdapter(child: AppConsts.bigVSpacer));
                lists.add(const SliverToBoxAdapter(
                    child: Text(
                  "Артисты",
                  style: AppStyle.header1Style,
                )));
                lists.add(const SliverToBoxAdapter(child: AppConsts.smallVSpacer));
                lists.add(SliverToBoxAdapter(child: ListWidget(list: results!)));
              }
              if (search.searchResult.albums != null && search.searchResult.albums!.results != null) {
                var results = search.searchResult.albums!.results;
                lists.add(const SliverToBoxAdapter(child: AppConsts.bigVSpacer));
                lists.add(const SliverToBoxAdapter(
                    child: Text(
                  "Альбомы",
                  style: AppStyle.header1Style,
                )));
                lists.add(const SliverToBoxAdapter(child: AppConsts.smallVSpacer));
                lists.add(SliverToBoxAdapter(child: ListWidget(list: results!)));
              }
              if (search.searchResult.playlists != null && search.searchResult.playlists!.results != null) {
                var results = search.searchResult.playlists!.results;
                lists.add(const SliverToBoxAdapter(child: AppConsts.bigVSpacer));
                lists.add(const SliverToBoxAdapter(
                    child: Text(
                  "Плейлисты",
                  style: AppStyle.header1Style,
                )));
                lists.add(const SliverToBoxAdapter(child: AppConsts.smallVSpacer));
                lists.add(SliverToBoxAdapter(child: ListWidget(list: results!)));
              }

              lists.add(const SliverToBoxAdapter(child: AppConsts.bigVSpacer));
              lists.add(const SliverToBoxAdapter(
                  child: Text(
                "Треки",
                style: AppStyle.header1Style,
              )));
              lists.add(const SliverToBoxAdapter(child: AppConsts.smallVSpacer));
              lists.add(SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, i) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: TrackCard(
                      track: search.searchResult.tracks!.results![i],
                      onPressed: () {},
                    ),
                  ),
                  childCount: search.searchResult.tracks!.results!.length,
                ),
              ));
            } else {
              lists.add(SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, i) => GCardView(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Text(
                          search.suggest.suggestions![i],
                          style: AppStyle.trackHeaderStyle,
                        )),
                    onPressed: () {
                      search.getSearch(search.suggest.suggestions![i]);
                      _controller.text = search.suggest.suggestions![i];
                    },
                  ),
                  childCount: search.suggest.suggestions!.length,
                ),
              ));
            }
          } else {
            lists.add(const SliverToBoxAdapter(child: Text("Ничего нет :)")));
          }

          return ScaffoldScroller(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                    height: 60.0,
                    alignment: Alignment.centerLeft,
                    child: TextBox(
                      controller: _controller,
                      onChanged: (value) {
                        search.getSuggest(value);
                      },
                      onSubmitted: (value) {
                        search.getSearch(value);
                      },
                      autofocus: true,
                      placeholder: "Search...",
                    )),
              ),
              for (var e in lists) e,
            ],
            padding: AppConsts.pageInsets,
          );
        }));
  }
}

// if (search.suggest.suggestions != null && search.suggest.suggestions!.isNotEmpty) {
// if (!search.isSuggests && search.searchResult.tracks != null) {
// } else {
// }
// } else {
// return const SliverToBoxAdapter(
// child:
// );
// }
