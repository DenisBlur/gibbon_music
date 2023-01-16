import 'package:gibbon_music/api/mainYamFunction.dart';
import 'package:gibbon_music/api/models/PageModels/M_PageAlbum.dart';

class PageAlbumProvider {
  PageAlbumProvider();

  MPageAlbum _mPageAlbum;

  MPageAlbum get mPageAlbum => _mPageAlbum;

  set mPageAlbum(MPageAlbum value) {
    _mPageAlbum = value;
  }

  Future<void> init(int id) async {
    mPageAlbum  = await getAlbum(id);
  }

  Future<void> dispose() async {
    mPageAlbum = null;
  }

}