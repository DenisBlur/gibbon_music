abstract class IPlaylistLoopStrategy {
  int _currentIndex = 0;
  int _size = 0;

  int get currentIndex => _currentIndex;

  set currentIndex(int value) {
    _currentIndex = value;
  }

  int get size => _size;

  set size(int value) {
    _size = value;
  }

  IPlaylistLoopStrategy(this._currentIndex, this._size);

  int endTrack();

  int next();

  int previous();

  bool canNext();

  bool canPrevious();
}
