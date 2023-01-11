import 'package:gibbon_music/API/Interfaces/IQueueStrategy.dart';

class QueueStrategy implements IQueueStrategy {
  @override
  int currentIndex;

  @override
  int size;

  @override
  int next() {
    if (canNext()) currentIndex++;

    return currentIndex;
  }

  @override
  bool canNext() {
    return size != 0 && currentIndex != size - 1;
  }

  @override
  bool canPrevious() {
    return currentIndex != 0;
  }
}
