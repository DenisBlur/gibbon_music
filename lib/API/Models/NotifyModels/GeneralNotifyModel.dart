import 'package:event/event.dart';
import 'package:fluent_ui/fluent_ui.dart';

import '../ArtistPage/MV_ArtistPage.dart';

class GeneralNotifyModel extends ChangeNotifier {
  final trackChanged = Event<TrackChangedArgs>();

  bool _backArrow = false;

  Track _mTrack;
  int _currentIndex;

  List<Track> _mPlaylist = [];

  int get currentIndex => _currentIndex;

  set currentIndex(int value) {
    _currentIndex = value;
    notifyListeners();
  }

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
    trackChanged.broadcast(TrackChangedArgs(mTrack));
    print("HEEELOO track");
    notifyListeners();
  }

  void playTrack(int index) {
    if (_checkRange(index)) {
      currentIndex = index;
      mTrack = mPlaylist[index];
    }
  }

  bool _checkRange(int index) {
    return index > -1 && index < _mPlaylist.length;
  }

  next() {
    playTrack(currentIndex + 1);
  }

  previous() {
    playTrack(currentIndex - 1);
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

class TrackChangedArgs extends EventArgs {
  Track track;

  TrackChangedArgs(this.track) {
    print("args created");
  }
}
