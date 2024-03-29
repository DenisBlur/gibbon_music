import 'dart:async';
import 'dart:collection';

import 'package:darq/darq.dart';
import 'package:flutter/foundation.dart';
import 'package:gibbon_music/domain/interfaces/iplaylist_loop_strategy.dart';
import 'package:gibbon_music/domain/models/loop_strategy/loop_strategies.dart';
import 'package:yam_api/enums.dart';
import 'package:yam_api/track/track.dart';

import '../../main.dart';

class NewPlaylist with ChangeNotifier {
  NewPlaylist() {
    firstQueue();
  }

  firstQueue() async {
    await client.queue.getQueue().then((value) async {
      radio = value;
      setTracksWithActiveTrack(client.radio.currentStation, QueueType.radio, await client.queue.getQueueTracks(), client.queue.currentPosition, value);
    });
  }

  final List<IPlaylistLoopStrategy> _loops = [
    PlaylistLoopStrategy(),
    NoLoopStrategy(),
    OneTrackLoopStrategy(),
  ];
  int _currentLoopI = 0;

  final List<Track?> _tracks = [];
  final List<int> _ids = [];

  bool _shuffled = false;

  bool _radio = false;

  bool get radio => _radio;

  RadioDiversity radioDiversity = RadioDiversity.defaultDiversity;
  RadioLanguage radioLanguage = RadioLanguage.any;
  RadioMoodEnergy radioMoodEnergy = RadioMoodEnergy.all;

  set radio(bool value) {
    _radio = value;
    notifyListeners();
  }

  late IPlaylistLoopStrategy _loop = _loops[_currentLoopI];

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
    setTracksWithActiveTrack(client.radio.currentStation, QueueType.radio, tracks, 0, false);
  }

  set currentTrackIndex(int index) {
    if (_isValidIndex(index) == false) {
      throw IndexError(index, _tracks);
    }

    _loop.currentIndex = index;

    _onTrackChangeController.add(false);
    notifyListeners();
  }



  Future<void> startRadio({String station = "user:onyourwave"}) async {
    List<Track> tracks = await client.radio.startRotorRadio();
    radio = true;
    loopStrategy = NoLoopStrategy();
    setTracksWithActiveTrack(client.radio.currentStation, QueueType.radio, tracks, 0, false);
  }

  Future<void> updateRadio({RadioDiversity radioDiversity = RadioDiversity.none, RadioMoodEnergy radioMoodEnergy = RadioMoodEnergy.none, RadioLanguage radioLanguage = RadioLanguage.none}) async {
    if(radioDiversity != RadioDiversity.none){
      this.radioDiversity = radioDiversity;
    }
    if(radioMoodEnergy != RadioMoodEnergy.none){
      this.radioMoodEnergy = radioMoodEnergy;
    }
    if(radioLanguage != RadioLanguage.none){
      this.radioLanguage = radioLanguage;
    }
    await client.radio.sendRotorStationSetting(radioDiversity: this.radioDiversity, radioMoodEnergy: this.radioMoodEnergy, radioLanguage: this.radioLanguage);
    List<Track> tracks = await client.radio.startRotorRadio();
    radio = true;
    loopStrategy = NoLoopStrategy();
    setTracksWithActiveTrack(client.radio.currentStation, QueueType.radio, tracks, 0, false);
    notifyListeners();
  }

  Future<void> setTracksWithActiveTrack(String id, QueueType type, List<Track?>? tracks, int index, bool stopRadio) async {
    if(stopRadio) {
      radio = false;
    }

    _tracks.clear();
    _tracks.addAll(tracks!);

    _loop.size = _tracks.length;

    currentTrackIndex = index;
    _indexing();

    // launch events
    if (radio) {
      _onTrackChangeController.add(RadioFeedback.getTracks);
    } else {
      _onTrackChangeController.add(null);
    }

    if(client.queue.currentQueueId != id) {
      client.queue.currentQueueId = id;
      await client.queue.postQueue(tracks, id, type.name, type.name, index);
    } else {
      await client.queue.updateQueue(_loop.currentIndex);
    }
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

  List<Track?> get tracks => _tracks; //endregion

  void nextTrack() {
    if (_loop.next() == false) {
      getRadioTrack();
      return;
    }

    if (radio) {
      _onTrackChangeController.add(RadioFeedback.skip);
    } else {
      _onTrackChangeController.add(null);
    }
    client.queue.updateQueue(_loop.currentIndex);
    notifyListeners();
  }

  void previousTrack() {
    if (_loop.previous() == false) {
      return;
    }

    if (radio) {
      _onTrackChangeController.add(RadioFeedback.skip);
    } else {
      _onTrackChangeController.add(null);
    }
    client.queue.updateQueue(_loop.currentIndex);
    notifyListeners();
  }

  void onTrackEnd() {
    if (_loop.endTrack() == false) {
      getRadioTrack();
      return;
    }

    if (radio) {
      _onTrackChangeController.add(RadioFeedback.trackFinished);
    } else {
      _onTrackChangeController.add(null);
    }
    client.queue.updateQueue(_loop.currentIndex);
    notifyListeners();
  }

  Future<void> getRadioTrack() async {
    if(radio) {
      List<Track> tracks = await client.radio.getRotorTracks();
      setTracksWithActiveTrack(client.radio.currentStation, QueueType.radio, tracks, 0, false);
    }
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

    if (_tracks.isNotEmpty && (_loop.currentIndex == _tracks.length || _tracks.isNotEmpty && index < _loop.currentIndex)) {
      _loop.currentIndex--;
    }

    if (currentTrack) _onTrackChangeController.add(null);
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

  void nextLoop() {
    _currentLoopI++;
    _currentLoopI %= _loops.length;

    loopStrategy = _loops[_currentLoopI];
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
