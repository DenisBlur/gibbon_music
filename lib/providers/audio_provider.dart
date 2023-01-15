import 'package:darq/darq.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:gibbon_music/api/models/LikesModels/M_LikeTracks.dart';
import 'package:gibbon_music/api/models/M_Track.dart';
import 'package:gibbon_music/domain/interfaces/iplaylist_loop_strategy.dart';
import 'package:gibbon_music/domain/models/playlist.dart';
import 'package:yam_api/yam_api.dart';
import 'package:flutter/material.dart' as m;

import '../api/mainYamFunction.dart';

class AudioProvider extends ChangeNotifier {
  AudioProvider();

  MLikeTracks mLikeTracks = MLikeTracks();
  List<int> _likesTracks;


  List<int> get likesTracks => _likesTracks;

  set likesTracks(List<int> value) {
    _likesTracks = value;
    notifyListeners();
  }

  removeLike(int value) {
    likesTracks.remove(value);
    notifyListeners();
  }

  addLike(int value) {
    _likesTracks.add(value);
    notifyListeners();
  }

  AudioPlayer _player;
  Playlist _playlist = Playlist();

  Playlist get playlist => _playlist;

  Stream<PlayerState> get onPlayerStateChanged => _player.onPlayerStateChanged;

  Stream<Duration> get onPositionChanged => _player.onPositionChanged;

  Stream<Duration> get onDurationChanged => _player.onDurationChanged;

  PlayerState get playerState => _player.state;

  set playlist(Playlist value) {
    _playlist = value;
  }

  Future<void> init() async {
    _player ??= AudioPlayer();
    mLikeTracks = await getLikeTracks();
    likesTracks = mLikeTracks.library.tracks.select((element, _) => int.parse(element.id)).toList();
  }

  void setPlaylist(List<MTrack> tracks) {
    _playlist.tracks = tracks;
  }

  void playTrack(int index) async {
    _playlist.currentTrackIndex = index;
    var trackUrl = await YamApi().downloadTrack(_playlist.currentTrack.id, QualityTrack.low);
    await _player.setSourceUrl(trackUrl);
    resume();
    notifyListeners();
  }

  @override
  Future<void> dispose() async {
    super.dispose();
    _player?.dispose();
    _player = null;
  }

  void addTrackAfterCurrent(MTrack track) {
    _playlist.addTrackAfterCurrent(track);
    notifyListeners();
  }

  void addTrackToEnd(MTrack track) {
    _playlist.addTrackToEnd(track);
    notifyListeners();
  }

  int afterTrackEnd() {
    _playlist.afterTrackEnd();
    notifyListeners();
  }

  bool canNext() => _playlist.canNext();

  bool canPrevious() => _playlist.canPrevious();

  set loopStrategy(IPlaylistLoopStrategy value) {
    _playlist.loopStrategy = value;
    notifyListeners();
  }

  void reorder(int oldIndex, int newIndex) {
    _playlist.reorder(oldIndex, newIndex);
    notifyListeners();
  }

  void shuffle(bool value) {
    _playlist.shuffle(value);
    notifyListeners();
  }

  void setSeek(double ms) async {
    await _player.seek(Duration(milliseconds: ms.toInt()));
    notifyListeners();
  }

  void resume() async {
    await _player.resume();
    notifyListeners();
  }

  void pause() async {
    await _player.pause();
    notifyListeners();
  }

  ///Удалить если чего
  IconData icon() {
    switch (playerState) {
      case PlayerState.stopped:
        return m.Icons.stop_rounded;
        break;
      case PlayerState.playing:
        return m.Icons.pause;
        break;
      case PlayerState.paused:
        return m.Icons.play_arrow;
        break;
      case PlayerState.completed:
        return m.Icons.not_interested;
        break;
    }
    return m.Icons.not_interested;
  }
}
