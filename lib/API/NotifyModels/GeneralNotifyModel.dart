import 'dart:collection';

import 'package:event/event.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/API/Interfaces/IQueueStrategy.dart';
import 'package:gibbon_music/API/MainMethod/Player/QueueStrategy.dart';
import 'package:gibbon_music/NewAPI/models/M_Track.dart';

class GeneralNotifyModel extends ChangeNotifier {
  final trackChanged = Event<TrackChangedArgs>();

  IQueueStrategy _queueStrategy = QueueStrategy();

  IQueueStrategy get queueStrategy => _queueStrategy;

  set queueStrategy(IQueueStrategy value) {
    value.size = queueStrategy.size;
    value.currentIndex = queueStrategy.currentIndex;
    _queueStrategy = value;
    notifyListeners();
  }

  bool _backArrow = false;

  MTrack _mTrack;

  List<MTrack> _mPlaylist = [];

  int get currentIndex => queueStrategy.currentIndex;

  set currentIndex(int value) {
    queueStrategy.currentIndex = value;
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
    queueStrategy.size = value.length;
    notifyListeners();
  }

  bool _checkRange(int index) {
    return index > -1 && index < queueStrategy.size;
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

  next() {
    playTrack(queueStrategy.next());
  }

  bool canNext() => queueStrategy.canNext();

  bool canPrevious() => queueStrategy.canPrevious();

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
