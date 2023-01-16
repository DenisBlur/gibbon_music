import 'package:gibbon_music/domain/interfaces/iplaylist_loop_strategy.dart';

// class OneTrackLoopStrategy implements IPlaylistLoopStrategy {
//
// }

class PlaylistLoopStrategy extends IPlaylistLoopStrategy {
  PlaylistLoopStrategy();

  bool _checkRange(int index) {
    return index >= 0 && index < size;
  }

  @override
  bool endTrack() {
    return next();
  }

  @override
  bool next() {
    if (canNext() == false) return false;

    currentIndex++;
    currentIndex = currentIndex % size;

    return true;
  }

  @override
  bool previous() {
    if (canPrevious() == false) return false;

    currentIndex--;

    return true;
  }

  @override
  bool canNext() {
    return size != 0;
  }

  @override
  bool canPrevious() {
    return _checkRange(currentIndex - 1);
  }
}

// class NoLoopStrategy implements IPlaylistLoopStrategy {
//
// }
