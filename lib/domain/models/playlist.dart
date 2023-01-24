import 'dart:async';
import 'dart:collection';
import 'dart:math';

import 'package:darq/darq.dart';
import 'package:flutter/foundation.dart';
import 'package:gibbon_music/domain/interfaces/iplaylist_loop_strategy.dart';
import 'package:gibbon_music/domain/models/loop_strategy/loop_strategies.dart';
import 'package:yam_api/track/track.dart';

// class Playlist {
//   Playlist();
//
//   bool _shuffled = false;
//
//   bool get shuffled => _shuffled;
//
//   int get currentTrackIndex => _loopStrategy.currentIndex;
//
//   set currentTrackIndex(int value) => _loopStrategy.currentIndex = value;
//
//   List<int> _trackIds = [];
//   List<Track?>? _tracks = [];
//
//   IPlaylistLoopStrategy _loopStrategy = PlaylistLoopStrategy();
//
//   set loopStrategy(IPlaylistLoopStrategy value) {
//     value.currentIndex = currentTrackIndex;
//     value.size = _loopStrategy.size;
//     _loopStrategy = value;
//   }
//
//   IPlaylistLoopStrategy get loopStrategy => _loopStrategy;
//
//   List<Track?>? get queue => _tracks!.isEmpty ? [] : _trackIds.select((element, _) => _tracks![element]).toList();
//
//   List<Track?>? get tracks => _tracks;
//
//   set tracks(List<Track?>? value) {
//     _tracks = value;
//     _loopStrategy.size = value!.length;
//     _trackIds.clear();
//     _trackIds = value.select((_, index) => index).toList();
//     currentTrackIndex = 0;
//     _sortTracks();
//   }
//
//   Track? get currentTrack => _tracks!.isEmpty ? null : _tracks![_trackIds[currentTrackIndex]];
//
//   bool nextTrack() => _loopStrategy.next();
//
//   bool afterTrackEnd() => _loopStrategy.endTrack();
//
//   bool previousTrack() => _loopStrategy.previous();
//
//   //region predicates
//   bool canNext() => _loopStrategy.canNext();
//
//   bool canPrevious() => _loopStrategy.canPrevious();
//
//   //endregion
//
//   // TODO: implement
//   void reorder(int oldIndex, int newIndex) {
//     throw UnimplementedError("reorder method in development");
//
//     Track track = _tracks![_trackIds[oldIndex]]!;
//     _tracks!.removeAt(_trackIds[oldIndex]);
//
//     _tracks!.insert(newIndex, track);
//
//     // _trackIds
//   }
//
//   void addTrackToEnd(Track track) {
//     _trackIds.add(_trackIds.length);
//     _tracks!.add(track);
//   }
//
//   void removeTrack(int index) {
//     //TODO: check index for every method in this file
//
//     _tracks!.removeAt(_trackIds[index]);
//
//     int removedIndex = _trackIds[index];
//     _trackIds.removeAt(index);
//
//     _trackIds = _trackIds.select(((element, index) => element < removedIndex ? element : element - 1)).toList();
//
//     currentTrackIndex--;
//   }
//
//   void addTrackAfterCurrent(Track track) {
//     int index = _trackIds.length;
//     _trackIds = _trackIds.select((element, _) => element <= currentTrackIndex ? element : element + 1).toList();
//     _trackIds.add(_trackIds.length);
//     _trackIds[index] = currentTrackIndex + 1;
//
//     _tracks!.add(track);
//   }
//
//   void shuffle(bool value) {
//     if (tracks!.isEmpty) return;
//
//     int index = _trackIds[currentTrackIndex];
//
//     if (value) {
//       _trackIds.remove(index);
//       _shuffleNumbers();
//       _trackIds.insert(0, index);
//       currentTrackIndex = 0;
//       return;
//     }
//
//     currentTrackIndex = index;
//     _sortTracks();
//   }
//
//   void _sortTracks() {
//     _setSortedNumbers();
//     _shuffled = false;
//   }
//
//   void _setSortedNumbers() {
//     for (int i = 0; i < tracks!.length; i++) {
//       _trackIds[i] = i;
//     }
//   }
//
//   void _shuffleNumbers() {
//     _trackIds.shuffle();
//     _shuffled = true;
//   }
// }

class NewPlaylist with ChangeNotifier {
  NewPlaylist();

  final List<Track?> _tracks = [];
  final List<int> _ids = [];

  bool _shuffled = false;

  IPlaylistLoopStrategy _loop = PlaylistLoopStrategy();

  //region Events

  final _onPlaylistUpdateController = StreamController.broadcast();
  final _onTrackChangeController = StreamController.broadcast();

  //endregion

  //region setters

  set shuffle(bool value) {
    if (value == _shuffled) return;

    if (value) {
      _shuffle();
      _loop.currentIndex = 0;
    } else {
      var index = _ids[_loop.currentIndex];
      _indexing();
      _loop.currentIndex = index;
    }

    _shuffled = value;

    // launch events
    _onPlaylistUpdateController.add(true);
    notifyListeners();
  }

  set loopStrategy(IPlaylistLoopStrategy value) {
    int currentIndex = _loop.currentIndex;
    _loop = value;
    _loop.currentIndex = currentIndex < _tracks.length ? currentIndex : 0;
    _loop.size = _tracks.length;
    notifyListeners();
  }

  set tracks(List<Track?>? tracks) {
    _tracks.clear();
    _tracks.addAll(tracks!);

    _loop.size = _tracks.length;

    currentTrackIndex = 0;
    _indexing();

    // launch events
    _onPlaylistUpdateController.add(true);
    notifyListeners();
  }

  set currentTrackIndex(int index) {
    if (_isValidIndex(index) == false) {
      throw IndexError(index, _tracks);
    }

    _loop.currentIndex = index;

    _onTrackChangeController.add(true);
    notifyListeners();
  }

  //endregion

  //region getters

  List<Track?>? get _tracksQueue => _tracks.select((_, index) => _tracks[_ids[index]]).toList();

  UnmodifiableListView<Track?> get tracksQueue => UnmodifiableListView(_tracksQueue!);

  Stream get onPlaylistUpdate => _onPlaylistUpdateController.stream;

  Stream get onTrackChange => _onTrackChangeController.stream;

  Track? get currentTrack {
    return _tracks.isEmpty ? null : _tracks[_ids[_loop.currentIndex]];
  }

  IPlaylistLoopStrategy get loopStrategy => _loop;

  bool get shuffled => _shuffled;

  //endregion

  void nextTrack() {
    if (_loop.next() == false) {
      return;
    }

    _onTrackChangeController.add(true);
    notifyListeners();
  }

  void previousTrack() {
    if (_loop.previous() == false) {
      return;
    }

    _onTrackChangeController.add(true);
    notifyListeners();
  }

  void onTrackEnd() {
    if (_loop.endTrack() == false) {
      return;
    }

    _onTrackChangeController.add(true);
    notifyListeners();
  }

  bool canNext() => _loop.canNext();

  bool canPrevious() => _loop.canPrevious();

  void addTrackToEnd(Track track) {
    _tracks.add(track);
    _ids.add(_tracks.length - 1);
    _loop.size = _tracks.length;

    _onPlaylistUpdateController.add(true);
    notifyListeners();
  }

  void addTrackAfterCurrent(Track track) {
    int indexToAdd = 0;
    if (shuffled) {
      indexToAdd = _tracks.length;
    } else {
      indexToAdd = currentTrack == null ? 0 : _loop.currentIndex + 1;
    }
    print("added track $track");
    _tracks.insert(indexToAdd, track);

    for (int i = 0; i < _ids.length; i++) {
      if (_ids[i] >= indexToAdd) _ids[i]++;
    }

    _ids.insert(_loop.currentIndex + 1, indexToAdd);

    _loop.size = _tracks.length;

    _onPlaylistUpdateController.add(true);
    notifyListeners();
  }

  void removeTrack(Track track) {
    var index = tracksQueue.indexWhere((element) => element!.id == track.id);
    if (index == -1) return;
    removeTrackByIndex(index);
  }

  void removeTrackByIndex(int index) {
    if (_isValidIndex(index) == false) return;

    bool currentTrack = index == _loop.currentIndex;

    // remove from track list
    var indexInList = _ids[index];
    _tracks.removeAt(indexInList);

    _loop.size--;

    // remove from ids
    _ids.removeAt(index);
    // update all indices that are larger than index of removed track
    for (int i = 0; i < _ids.length; i++) {
      if (_ids[i] > indexInList) _ids[i]--;
    }

    if (_tracks.isNotEmpty && index == _loop.size) {
      _loop.currentIndex--;
    }

    if (currentTrack) _onTrackChangeController.add(true);
    _onPlaylistUpdateController.add(true);
    notifyListeners();
  }

  void reorder(int oldIndex, int newIndex) {
    if ((_isValidIndex(oldIndex) && _isValidIndex(newIndex)) == false) return;

    int trackIndex = _ids[oldIndex];
    _ids.removeAt(oldIndex);
    _ids.insert(newIndex, trackIndex);

    if (_loop.currentIndex == oldIndex) {
      _loop.currentIndex = newIndex;
    } else if (oldIndex < _loop.currentIndex && _loop.currentIndex <= newIndex) {
      _loop.currentIndex--;
    } else if (oldIndex > _loop.currentIndex && _loop.currentIndex >= newIndex) {
      _loop.currentIndex++;
    }

    _onPlaylistUpdateController.add(true);
    notifyListeners();
  }

  //region private functions
  void _indexing() {
    _ids.clear();
    _ids.addAll(_tracks.select((_, index) => index));
  }

  void _shuffle() {
    int index = _ids[_loop.currentIndex];
    _ids.removeAt(_loop.currentIndex);
    _ids.shuffle();
    _ids.insert(0, index);
  }

  bool _isValidIndex(int index) => index >= 0 && index < _tracks.length;
//endregion
}
