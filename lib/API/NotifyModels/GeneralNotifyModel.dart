import 'package:event/event.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/NewAPI/models/M_Track.dart';

class GeneralNotifyModel extends ChangeNotifier {
  final trackChanged = Event<TrackChangedArgs>();

  bool _backArrow = false;

  MTrack _mTrack;
  int _currentIndex;

  List<MTrack> _mPlaylist = [];

  int get currentIndex => _currentIndex;

  set currentIndex(int value) {
    _currentIndex = value;
    notifyListeners();
  }

  List<String> mNavList = [];

  List<MTrack> get mPlaylist => _mPlaylist;

  MTrack get mTrack => _mTrack;

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

  set mPlaylist(List<MTrack> value) {
    _mPlaylist = value;
    notifyListeners();
  }

  set mTrack(MTrack value) {
    _mTrack = value;
    trackChanged.broadcast(TrackChangedArgs(mTrack));
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

  bool canNext() {
    return _checkRange(currentIndex + 1);
  }

  bool canPrevious() {
    return _checkRange(currentIndex - 1);
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
  MTrack track;

  TrackChangedArgs(this.track);
}
