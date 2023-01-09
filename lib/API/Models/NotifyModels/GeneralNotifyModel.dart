import 'package:fluent_ui/fluent_ui.dart';

import '../ArtistPage/MV_ArtistPage.dart';

class GeneralNotifyModel extends ChangeNotifier {
  bool _backArrow = false;
  Track _mTrack;
  List<Track> _mPlaylist = [];

  List<String> mNavList = [];

  List<Track> get mPlaylist => _mPlaylist;

  Track get mTrack => _mTrack;

  bool get backArrow => _backArrow;

  set backArrow(bool value) {
    if (!value) {
      if (mNavList.isEmpty) {
        _backArrow = value;
      }
    } else {
      _backArrow = value;
    }
    notifyListeners();
  }

  set mPlaylist(List<Track> value) {
    _mPlaylist = value;
    notifyListeners();
  }

  set mTrack(Track value) {
    _mTrack = value;
    notifyListeners();
  }

  addNavList(String value) {
    mNavList.add(value);
    notifyListeners();
  }

  removeNavList() {
    mNavList.removeLast();
    notifyListeners();
  }
}
