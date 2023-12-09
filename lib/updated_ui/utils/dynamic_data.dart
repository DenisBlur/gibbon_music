import 'package:flutter/material.dart';
import 'package:gibbon_music/constants/app_consts.dart';
import 'package:gibbon_music/updated_ui/widgets/aap_card.dart';
import 'package:gibbon_music/updated_ui/widgets/dynamic_list.dart';
import 'package:gibbon_music/updated_ui/widgets/promotion_card.dart';
import 'package:yam_api/album/album.dart';
import 'package:yam_api/artist/brief_info.dart';
import 'package:yam_api/landing/entities.dart';
import 'package:yam_api/landing/promotion.dart';
import 'package:yam_api/playlist/playlist.dart';

Widget getDynamicData(List<dynamic> listData, int index) {
  Widget listItem = const Text("");

  if (listData is List<Entities>) {
    switch (listData[index].data["context"]) {
      case "album":
        Album data = Album.fromJson(listData[index].data["payload"]);
        listItem = AlbumCard(album: data);
        break;
      case "playlist":
        MPlaylist data = MPlaylist.fromJson(listData[index].data["payload"]);
        listItem = PlaylistCard(playlist: data);
        break;
      case "artist":
        BriefInfo data = BriefInfo.fromJson(listData[index].data["payload"]);
        listItem = ArtistCard(artist: data);
        break;
      default:
        break;
    }
  }

  if (listData is List<Promotion>) {
    listItem = PromotionCard(data: listData[index],);
  }

  if (listData is List<MPlaylist>) {
    listItem = PlaylistCard(playlist: listData[index]);
  }

  if (listData is List<BriefInfo>) {
    listItem = ArtistCard(artist: listData[index]);
  }

  if (listData is List<Album>) {
    listItem = AlbumCard(album: listData[index]);
  }

  if (listData is List<String>) {
    listItem = Text(listData.toString());
  }

  return listItem;
}

List<Widget> widgetsToSliver(List<Widget> data) {
  List<Widget> returnedList = [];

  for (var value in data) {
    if (value is StatelessWidget || value is StatefulWidget || value is SingleChildRenderObjectWidget || value is Flex) {
      if (value is !DynamicListWidget) {
        if (value is SliverPersistentHeader) {
          returnedList.add(value);
        } else {
          returnedList.add(SliverToBoxAdapter(
            child: Padding(padding: AppConsts.pageOffset, child: value),
          ));
        }
      } else {
          returnedList.add(SliverToBoxAdapter(
            child: value,
          ));
      }
    } else {
      if(value is SliverPersistentHeader) {
        returnedList.add(value);
      } else {
        returnedList.add(SliverPadding(padding: AppConsts.pageOffset, sliver: value));
      }
    }
  }

  return returnedList;
}
