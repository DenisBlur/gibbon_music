import 'package:gibbon_music/domain/interfaces/iplaylist_loop_strategy.dart';

class OneTrackLoopStrategy implements IPlaylistLoopStrategy {
  @override
  int currentIndex;

  @override
  int size;

  @override
  int endTrack() {
    // TODO: implement endTrack
    throw UnimplementedError();
  }

  @override
  int next() {
    // TODO: implement next
    throw UnimplementedError();
  }

  @override
  int previous() {
    // TODO: implement previous
    throw UnimplementedError();
  }

  @override
  bool canNext() {
    // TODO: implement canNext
    throw UnimplementedError();
  }

  @override
  bool canPrevious() {
    // TODO: implement canPrevious
    throw UnimplementedError();
  }
}

class PlaylistLoopStrategy extends IPlaylistLoopStrategy {
  @override
  int currentIndex;

  @override
  int size;

  PlaylistLoopStrategy(int currentIndex, int size) : super(currentIndex, size);

  bool _checkRange(int index) {
    return index >= -1 && index < size;
  }

  @override
  int endTrack() {
    return next();
  }

  @override
  int next() {
    if (canNext()) {
      currentIndex++;
    }
    currentIndex;
  }

  @override
  int previous() {
    if (canNext()) {
      currentIndex--;
    }
    currentIndex;
  }

  @override
  bool canNext() {
    return _checkRange(currentIndex + 1);
  }

  @override
  bool canPrevious() {
    return _checkRange(currentIndex - 1);
  }
}

class NoLoopStrategy implements IPlaylistLoopStrategy {
  @override
  int currentIndex;

  @override
  int size;

  @override
  int endTrack() {
    // TODO: implement endTrack
    throw UnimplementedError();
  }

  @override
  int next() {
    // TODO: implement next
    throw UnimplementedError();
  }

  @override
  int previous() {
    // TODO: implement previous
    throw UnimplementedError();
  }

  @override
  bool canNext() {
    // TODO: implement canNext
    throw UnimplementedError();
  }

  @override
  bool canPrevious() {
    // TODO: implement canPrevious
    throw UnimplementedError();
  }
}
