import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/DesignWidget/GListView/PageScrollerWidget.dart';
import 'package:gibbon_music/DesignWidget/ListItems/AlbumItem.dart';
import 'package:gibbon_music/DesignWidget/ListItems/PlaylistItem.dart';
import 'package:gibbon_music/DesignWidget/ListItems/TrackItem.dart';
import 'package:gibbon_music/DesignWidget/Styles/GStyles.dart';
import 'package:gibbon_music/NewAPI/mainYamFunction.dart';
import 'package:gibbon_music/NewAPI/models/SearchModels/M_Search.dart';
import 'package:provider/provider.dart';

import '../API/NotifyModels/UxNotifyModel.dart';
import '../DesignWidget/GListView/GInfinityListView.dart';
import '../DesignWidget/ListItems/ArtistItem.dart';
import '../DesignWidget/Styles/ConstValue.dart';
import '../main.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return ScaffoldPage(
      padding: const EdgeInsets.all(0),
      content: Consumer<UxNotifyModel>(
        builder: (context, value, child) {
          Widget empty = const SliverToBoxAdapter(
            child: SizedBox(),
          );

          MSearch mSearch = context.watch<UxNotifyModel>().mSearch;
          bool emptyTracks = mSearch == null || mSearch.tracks == null;
          bool emptyArtists = mSearch == null || mSearch.artists == null;
          bool emptyAlbums = mSearch == null || mSearch.albums == null;
          bool emptyPlaylist = mSearch == null || mSearch.playlists == null;

          /*
            List<Widget> suggestWidgets = [];
            if (context.watch<UxNotifyModel>().mSearchSuggest != null) {
              context.watch<UxNotifyModel>().mSearchSuggest.suggestions.forEach((element) {
                suggestWidgets.add(Text(element));
              });
            }
             */

          return ScrollerWidget(
            slivers: [
              SliverToBoxAdapter(
                  child: Column(
                children: [
                  SizedBox(
                    height: windowHeader + 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 32, right: 32),
                    child: TextBox(
                      header: "Поиск по Яндекс музыке",
                      placeholder: "Поиск...",
                      controller: controller,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          getSearchSuggest(value);
                          getSearchResult(value);
                        }
                      },
                    ),
                  ),
                ],
              )),
              emptyArtists
                  ? empty
                  : SliverToBoxAdapter(
                      child: Padding(
                          padding: EdgeInsets.only(bottom: 16, top: 32),
                          child: Text(
                            "Артисты",
                            style: titleTextStyle,
                          )),
                    ),
              emptyArtists
                  ? empty
                  : SliverToBoxAdapter(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        child: GListView(
                          scrollButtons: Platform.isWindows,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return FadeIn(
                              duration: fastAnimation,
                              delay: Duration(milliseconds: 50 * index),
                              child: ArtistItem(artist: mSearch.artists.results[index], index: index),
                            );
                          },
                          itemCount: mSearch.artists.results.length,
                        ),
                      ),
                    ),
              emptyAlbums
                  ? empty
                  : SliverToBoxAdapter(
                      child: Padding(
                          padding: EdgeInsets.only(bottom: 16, top: 32),
                          child: Text(
                            "Альбомы",
                            style: titleTextStyle,
                          )),
                    ),
              emptyAlbums
                  ? empty
                  : SliverToBoxAdapter(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        child: GListView(
                          scrollButtons: Platform.isWindows,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return FadeIn(
                              duration: fastAnimation,
                              delay: Duration(milliseconds: 50 * index),
                              child: AlbumItem(album: mSearch.albums.results[index], index: index),
                            );
                          },
                          itemCount: mSearch.albums.results.length,
                        ),
                      ),
                    ),
              if (emptyPlaylist)
                empty
              else
                SliverToBoxAdapter(
                  child: Padding(
                      padding: EdgeInsets.only(bottom: 16, top: 32),
                      child: Text(
                        "Плейлисты",
                        style: titleTextStyle,
                      )),
                ),
              emptyPlaylist
                  ? empty
                  : SliverToBoxAdapter(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        child: GListView(
                          scrollButtons: Platform.isWindows,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return FadeIn(
                              duration: fastAnimation,
                              delay: Duration(milliseconds: 50 * index),
                              child: PlaylistItem(playlist: mSearch.playlists.results[index], index: index),
                            );
                          },
                          itemCount: mSearch.playlists.results.length,
                        ),
                      ),
                    ),
              emptyTracks
                  ? empty
                  : SliverToBoxAdapter(
                      child: Padding(
                          padding: const EdgeInsets.only(bottom: 16, top: 32),
                          child: Text(
                            "Треки",
                            style: titleTextStyle,
                          )),
                    ),
              emptyTracks
                  ? const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 250,
                        child: Center(child: Text("Ничего не найдено :(")),
                      ),
                    )
                  : SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 16),
                        child: TrackItem(
                          track: mSearch.tracks.results[index],
                          callback: () {
                            generalNotifyModel.mPlaylist = mSearch.tracks.results;
                            generalNotifyModel.playTrack(index);
                          },
                        ),
                      );
                    }, childCount: mSearch.tracks.results.length)),
              const SliverToBoxAdapter(
                child: SizedBox(height: 150),
              )
            ],
          );
        },
      ),
    );
  }
}
