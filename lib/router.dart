import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gibbon_music/providers/navigator_provider.dart';
import 'package:gibbon_music/providers/ux_provider.dart';
import 'package:gibbon_music/updated_ui/screens/page_album.dart';
import 'package:gibbon_music/updated_ui/screens/page_artist.dart';
import 'package:gibbon_music/updated_ui/screens/page_playlist.dart';
import 'package:gibbon_music/updated_ui/screens/page_search.dart';
import 'package:gibbon_music/updated_ui/screens/page_setting.dart';
import 'package:gibbon_music/updated_ui/screens/page_test.dart';
import 'package:gibbon_music/updated_ui/screens/page_more.dart';
import 'package:provider/provider.dart';

class AppRouter {
  AppRouter();

  tryPop(BuildContext context) {
    context.read<UxProvider>().isContextMenu = false;
    NavigatorProvider provider = context.read();
    provider.pop(context);
  }

  gotoPlaylist(BuildContext context, String id, String kind, bool isChart) {
    context.read<UxProvider>().isContextMenu = false;
    NavigatorProvider provider = context.read();
    provider.push(
        "playlist",
        context,
        PagePlaylist(
          id: id,
          kind: kind,
          isChart: isChart,
        ));
  }

  gotoAlbum(BuildContext context, int id) {
    NavigatorProvider provider = context.read();
    provider.push(
        "album",
        context,
        PageAlbum(
          id: id,
        ));
  }

  gotoArtist(BuildContext context, String? id) {
    NavigatorProvider provider = context.read();
    provider.push(
        "artist",
        context,
        PageArtist(
          id: id.toString(),
        ));
  }

  gotoMore(BuildContext context, List<dynamic> listData, String title) {
    NavigatorProvider provider = context.read();
    provider.push(
        "test",
        context,
        PageMore(
          title: title,
          listData: listData,
        ));
  }

  gotoTest(BuildContext context) {
    NavigatorProvider provider = context.read();
    provider.push("test", context, const PageTest());
  }

  gotoSetting(BuildContext context) {
    NavigatorProvider provider = context.read();
    provider.push("setting", context, const PageSetting());
  }

  gotoSearch(BuildContext context) {
    NavigatorProvider provider = context.read();
    provider.push("search", context, const PageSearch());
  }
}
