import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/api/mainYamFunction.dart';
import 'package:gibbon_music/api/models/PageModels/M_PageArtist.dart';
import 'package:gibbon_music/api/models/PageModels/M_PageDashboard.dart';

class PageArtistProvider{
  PageArtistProvider();

  MPageArtist _mPageArtist;

  MPageArtist get mPageArtist => _mPageArtist;

  set mPageArtist(MPageArtist value) {
    _mPageArtist = value;
  }

  Future<void> init(int id) async {
    mPageArtist  = await getArtist(id);
  }

  Future<void> dispose() async {
    mPageArtist = null;
  }
}
