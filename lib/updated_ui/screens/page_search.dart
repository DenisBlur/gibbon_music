import 'package:flutter/material.dart';
import 'package:gibbon_music/constants/app_consts.dart';
import 'package:gibbon_music/providers/search_provider.dart';
import 'package:gibbon_music/updated_ui/widgets/card_view.dart';
import 'package:gibbon_music/updated_ui/widgets/custom_scaffold.dart';
import 'package:gibbon_music/updated_ui/widgets/dynamic_list.dart';
import 'package:gibbon_music/updated_ui/widgets/track_card.dart';
import 'package:provider/provider.dart';
import 'package:yam_api/album/album.dart';
import 'package:yam_api/artist/brief_info.dart';
import 'package:yam_api/enums.dart';
import 'package:yam_api/playlist/playlist.dart';
import 'package:yam_api/track/track.dart';

import '../../domain/models/playlist.dart';
import '../../providers/audio_provider.dart';
import '../widgets/aap_card.dart';

class PageSearch extends StatelessWidget {
  const PageSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    return SafeArea(child: Scaffold(body: Consumer<SearchProvider>(builder: (_, search, __) {
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
                  onPressed: () {
                    context.read<NewPlaylist>().setTracksWithActiveTrack("search", QueueType.search, [data], 0, true);
                    context.read<AudioProvider>().resume();
                  },
                );
                break;
              default:
                break;
            }
            lists.add(const Text(
              "Лучший результат",
            ));
            lists.add(AppConsts.smallVSpacer);
            lists.add(widget);
          }
          if (search.searchResult.artists != null && search.searchResult.artists!.results != null) {
            var results = search.searchResult.artists!.results;
            lists.add(DynamicListWidget(listData: results!, title: "Артисты"));
          }
          if (search.searchResult.albums != null && search.searchResult.albums!.results != null) {
            var results = search.searchResult.albums!.results;
            lists.add(DynamicListWidget(listData: results!, title: "Альбомы"));
          }
          if (search.searchResult.playlists != null && search.searchResult.playlists!.results != null) {
            var results = search.searchResult.playlists!.results;
            lists.add(DynamicListWidget(listData: results!, title: "Плейлисты"));
          }

          lists.add(AppConsts.bigVSpacer);
          lists.add(const Text(
            "Треки",
          ));
          lists.add(AppConsts.smallVSpacer);
          lists.add(SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, i) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: TrackCard(
                  track: search.searchResult.tracks!.results![i],
                  onPressed: () {
                    context.read<NewPlaylist>().setTracksWithActiveTrack("search", QueueType.search, search.searchResult.tracks!.results!, i, true);
                    context.read<AudioProvider>().resume();
                  },
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
                    )),
                onPressed: () {
                  search.getSearch(search.suggest.suggestions![i]);
                  controller.text = search.suggest.suggestions![i];
                },
              ),
              childCount: search.suggest.suggestions!.length,
            ),
          ));
        }
      } else {
        lists.add(const Text("Ничего нет :)"));
      }

      return CustomScaffold(
        children: [
          Container(
              height: 60.0,
              alignment: Alignment.centerLeft,
              child: TextField(
                controller: controller,
                onChanged: (value) {
                  search.getSuggest(value);
                },
                onSubmitted: (value) {
                  search.getSearch(value);
                },
                autofocus: true,
                decoration: const InputDecoration(label: Text("Search...")),
              )),
          for (var e in lists) e,
        ],
      );
    })));
  }
}
