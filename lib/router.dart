import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gibbon_music/providers/navigator_provider.dart';
import 'package:gibbon_music/ui/screens/page_album.dart';
import 'package:gibbon_music/ui/screens/page_artist.dart';
import 'package:gibbon_music/ui/screens/page_playlist.dart';
import 'package:gibbon_music/ui/screens/page_test.dart';
import 'package:provider/provider.dart';

class AppRouter {
  AppRouter();

  tryPop(BuildContext context) {
    NavigatorProvider provider = context.read();
    provider.pop(context);
  }

  gotoPlaylist(BuildContext context, String id, String kind) {
    NavigatorProvider provider = context.read();
    provider.push("album", context, PagePlaylist(id: id, kind: kind,));
  }

  gotoAlbum(BuildContext context, int id) {
    NavigatorProvider provider = context.read();
    provider.push("album", context, PageAlbum(id: id,));
  }

  gotoArtist(BuildContext context, int id) {
    NavigatorProvider provider = context.read();
    provider.push("artist", context, PageArtist(id: id,));
  }

  gotoTest(BuildContext context) {
    NavigatorProvider provider = context.read();
    provider.push("test", context, const PageTest());
  }

}
