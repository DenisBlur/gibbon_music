import 'package:gibbon_music/API/Interfaces/IQueueStrategy.dart';

class BoundedQueueStrategy implements IQueueStrategy {
  @override
  int currentIndex;

  @override
  int size;

  @override
  int next() {
    currentIndex = (currentIndex + 1) % size;
    return currentIndex;
  }

  @override
  bool canNext() {
    return true;
  }

  @override
  bool canPrevious() {
    return currentIndex != 0;
  }
}
