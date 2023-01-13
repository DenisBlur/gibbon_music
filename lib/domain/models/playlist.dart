import 'package:gibbon_music/api/models/M_Track.dart';
import 'package:gibbon_music/domain/interfaces/iplaylist_loop_strategy.dart';
import 'package:gibbon_music/domain/models/loop_strategy/loop_strategies.dart';

class Playlist {
  Playlist();

  int _currentTrackIndex = 0;
  List<int> _trackIds = [];
  List<MTrack> _tracks = [];

  IPlaylistLoopStrategy _loopStrategy = PlaylistLoopStrategy(0, 0);

  set loopStrategy(IPlaylistLoopStrategy value) {
    _loopStrategy = value;
  }

  List<MTrack> get tracks => _tracks;

  set tracks(List<MTrack> value) {
    _tracks = value;
    _loopStrategy.size = value.length;
    _trackIds = List<int>(value.length);
    _sortTracks();
  }

  set currentTrackIndex(int value) {
    _currentTrackIndex = value;
  }

  MTrack get currentTrack => _tracks[_trackIds[_currentTrackIndex]];

  int nextTrack() => _loopStrategy.next();

  int afterTrackEnd() => _loopStrategy.endTrack();

  int previousTrack() => _loopStrategy.previous();

  bool canNext() => _loopStrategy.canNext();

  bool canPrevious() => _loopStrategy.canPrevious();

  void reorder(int oldIndex, int newIndex) {
    MTrack track = _tracks[oldIndex];
    _tracks.removeAt(oldIndex);
    _tracks.insert(newIndex, track);
  }

  void addTrackToEnd(MTrack track) {
    _trackIds.add(_trackIds.length);
    _tracks.add(track);
  }

  void addTrackAfterCurrent(MTrack track) {
    _trackIds.add(_trackIds.length);
    _tracks.insert(_currentTrackIndex + 1, track);
  }

  void shuffle(bool value) {
    if (value) {
      _shuffle();
      return;
    }

    _sortTracks();
  }

  void _sortTracks() {
    for (int i = 0; i < tracks.length; i++) {
      _trackIds[i] = i;
    }
  }

  void _shuffle() {
    _trackIds.shuffle();
  }
}
