import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:gibbon_music/api/models/M_Track.dart';
import 'package:gibbon_music/domain/interfaces/iplaylist_loop_strategy.dart';
import 'package:gibbon_music/domain/models/playlist.dart';
import 'package:yam_api/yam_api.dart';

class AudioProvider extends ChangeNotifier {
  AudioProvider();

  AudioPlayer _player;
  Playlist _playlist = Playlist();

  Playlist get playlist => _playlist;

  set playlist(Playlist value) {
    _playlist = value;
  }

  Future<void> init() async {
    _player ??= AudioPlayer();
  }

  void setPlaylist(List<MTrack> tracks) {
    _playlist.tracks = tracks;
  }

  void playTrack(int index) async {
    _playlist.currentTrackIndex = index;
    var trackUrl = await YamApi.downloadTrack(_playlist.currentTrack.id);
    await _player.setSourceUrl(trackUrl);
    await _player.resume();
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
}
