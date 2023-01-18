import 'package:darq/darq.dart';
import 'package:gibbon_music/domain/interfaces/iplaylist_loop_strategy.dart';
import 'package:gibbon_music/domain/models/loop_strategy/loop_strategies.dart';
import 'package:yam_api/track/track.dart';

class Playlist {
  Playlist();

  bool _shuffled = false;

  bool get shuffled => _shuffled;

  int get currentTrackIndex => _loopStrategy.currentIndex;

  set currentTrackIndex(int value) => _loopStrategy.currentIndex = value;

  List<int> _trackIds = [];
  List<Track?>? _tracks = [];

  IPlaylistLoopStrategy _loopStrategy = PlaylistLoopStrategy();

  set loopStrategy(IPlaylistLoopStrategy value) {
    value.currentIndex = currentTrackIndex;
    value.size = _loopStrategy.size;
    _loopStrategy = value;
  }

  IPlaylistLoopStrategy get loopStrategy => _loopStrategy;

  List<Track?>? get queue => _tracks!.isEmpty ? [] : _trackIds.select((element, _) => _tracks![element]).toList();

  List<Track?>? get tracks => _tracks;

  set tracks(List<Track?>? value) {
    _tracks = value;
    _loopStrategy.size = value!.length;
    _trackIds.clear();
    _trackIds.length = value.length;

    currentTrackIndex = 0;

    _sortTracks();
  }

  Track? get currentTrack => _tracks!.isEmpty ? null : _tracks![_trackIds[currentTrackIndex]];

  bool nextTrack() => _loopStrategy.next();

  bool afterTrackEnd() => _loopStrategy.endTrack();

  bool previousTrack() => _loopStrategy.previous();

  //region predicates
  bool canNext() => _loopStrategy.canNext();

  bool canPrevious() => _loopStrategy.canPrevious();

  //endregion

  // TODO: implement
  void reorder(int oldIndex, int newIndex) {
    throw UnimplementedError("reorder method in development");

    Track track = _tracks![_trackIds[oldIndex]]!;
    _tracks!.removeAt(_trackIds[oldIndex]);

    _tracks!.insert(newIndex, track);

    // _trackIds
  }

  void addTrackToEnd(Track track) {
    _trackIds.add(_trackIds.length);
    _tracks!.add(track);
  }

  void removeTrack(int index) {
    //TODO: check index for every method in this file

    _tracks!.removeAt(_trackIds[index]);

    int removedIndex = _trackIds[index];
    _trackIds.removeAt(index);

    _trackIds = _trackIds.select(((element, index) => element < removedIndex ? element : element - 1)).toList();

    currentTrackIndex--;
  }

  void addTrackAfterCurrent(Track track) {
    int index = _trackIds.length;

    _trackIds = _trackIds.select((element, _) => element <= currentTrackIndex ? element : element + 1).toList();
    _trackIds.add(_trackIds.length);
    _trackIds[index] = currentTrackIndex + 1;

    _tracks!.add(track);
  }

  void shuffle(bool value) {
    if (tracks!.isEmpty) return;

    int index = _trackIds[currentTrackIndex];

    if (value) {
      _trackIds.remove(index);
      _shuffleNumbers();
      _trackIds.insert(0, index);
      currentTrackIndex = 0;
      return;
    }

    currentTrackIndex = index;
    _sortTracks();
  }

  void _sortTracks() {
    _setSortedNumbers();
    _shuffled = false;
  }

  void _setSortedNumbers() {
    for (int i = 0; i < tracks!.length; i++) {
      _trackIds[i] = i;
    }
  }

  void _shuffleNumbers() {
    _trackIds.shuffle();
    _shuffled = true;
  }
}
