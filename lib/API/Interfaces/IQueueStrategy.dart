import 'package:fluent_ui/fluent_ui.dart';

abstract class IQueueStrategy {
  int _size = 0;
  int _currentIndex = 0;

  bool canNext();
  bool canPrevious();

  int end();
  int get size => _size;
  set size(int value) {
    _size = value;
  }
  int get currentIndex => _currentIndex;
  set currentIndex(int value) {
    if (value < 0) throw ArgumentError("index must be positive");
    if (value >= size) throw ArgumentError("еру currentIndex must be smaller than the size");

    _currentIndex = value;
  }

  int next();
}
