import 'package:event/event.dart';
import 'package:flutter/foundation.dart';
import 'package:gibbon_music/api/mainYamFunction.dart';
import 'package:gibbon_music/api/models/M_Track.dart';
import 'package:gibbon_music/api/models/PageModels/M_PageAlbum.dart';
import 'package:gibbon_music/api/models/PageModels/M_PagePlaylist.dart';
import 'package:gibbon_music/domain/interfaces/iplaylist_loop_strategy.dart';
import 'package:gibbon_music/domain/models/loop_strategy/loop_strategies.dart';
import 'package:gibbon_music/domain/models/playlist.dart';

class PagePlaylistProvider {
  PagePlaylistProvider();

  MPagePlaylist _mPagePlaylist;

  MPagePlaylist get mPagePlaylist => _mPagePlaylist;

  set mPagePlaylist(MPagePlaylist value) {
    _mPagePlaylist = value;
  }

  Future<void> init(String id, String kind) async {
    mPagePlaylist = await getPlaylist(id, kind);
  }

  Future<void> dispose() async {
    mPagePlaylist = null;
  }
}

class PlayListProvider extends ChangeNotifier {
  Event onNextTrackPlay = Event();
  Event onCurrentTrackUpdated = Event();

  bool get shuffled => _playlist.shuffled;

  final Playlist _playlist = Playlist();

  MTrack get currentTrack => _playlist.currentTrack;

  IPlaylistLoopStrategy get loopStrategy => _playlist.loopStrategy;

  List<MTrack> get queue => _playlist.queue;

  List<IPlaylistLoopStrategy> loopStrategies = [
    PlaylistLoopStrategy(),
  ];

  void _raiseEvent(bool value) {
    if (value) {
      // onNextTrackPlay.broadcast();
      onCurrentTrackUpdated.broadcast();
    }
  }

  void end() {
    _raiseEvent(_playlist.afterTrackEnd());
    notifyListeners();
  }

  void next() {
    _raiseEvent(_playlist.nextTrack());
    notifyListeners();
  }

  void previous() {
    _raiseEvent(_playlist.previousTrack());
    notifyListeners();
  }

  void toggleShuffle() {
    _playlist.shuffle(!shuffled);
    notifyListeners();
  }

  void setPlaylist(List<MTrack> tracks) {
    _playlist.tracks = tracks;
    onCurrentTrackUpdated.broadcast();
    notifyListeners();
  }

  void setCurrentTrack(int index) {
    _playlist.currentTrackIndex = index;
    onCurrentTrackUpdated.broadcast();
    notifyListeners();
  }

  bool canNext() => _playlist.canNext();

  bool canPrevious() => _playlist.canPrevious();

  void nextLoopStrategy() {
    //TODO: set
  }
}
