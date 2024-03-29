abstract class IPlaylistLoopStrategy {

  int currentIndex = 0;

  int size = 0;

  bool endTrack();

  bool next();

  bool previous();

  bool canNext();

  bool canPrevious();
}
