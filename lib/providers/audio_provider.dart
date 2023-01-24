import 'dart:async';

import 'package:async/async.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as m;
import 'package:gibbon_music/domain/models/playlist.dart';
import 'package:gibbon_music/main.dart';
import 'package:gibbon_music/providers/playlist_provider.dart';
import 'package:yam_api/enums.dart';
import 'package:yam_api/track/track.dart';

class AudioProvider extends ChangeNotifier {
  AudioProvider(this._playlistProvider) {
    init();
  }

  final NewPlaylist _playlistProvider;

  late AudioPlayer _player;

  Stream<PlayerState> get onPlayerStateChanged => _player.onPlayerStateChanged;

  Stream<Duration> get onPositionChanged => _player.onPositionChanged;

  Stream<Duration> get onDurationChanged => _player.onDurationChanged;

  CancelableOperation<String>? _getTrackURLAsyncOperation;

  PlayerState get playerState => _player.state;

  Track? get currentTrack => _playlistProvider.currentTrack;

  StreamSubscription? _onTrackChangeSubscribe;

  StreamSubscription? _onPlayerStateChangedSubscribe;

  Future<void> init() async {
    _player = AudioPlayer();
    //
    // _playlistProvider.onNextTrackPlay.subscribe((args) => _changeTrack());

    _onTrackChangeSubscribe = _playlistProvider.onTrackChange.listen((event) {
      preloadTrack(_playlistProvider.currentTrack!);
      notifyListeners();
    });

    // _playlistProvider.onCurrentTrackUpdated.subscribe((args) {
    //   preloadTrack(_playlistProvider.currentTrack!);
    //   notifyListeners();
    // });
    //

    _onPlayerStateChangedSubscribe =  onPlayerStateChanged.listen((event) {
      if (event == PlayerState.completed) {
        _playlistProvider.onTrackEnd();
        notifyListeners();
      }
    });
  }

  // void _getTrackAsyncOperation(MTrack track) {
  //   _getTrackURLAsyncOperation?.cancel();
  //   _getTrackURLAsyncOperation = CancelableOperation.fromFuture(YamApi().downloadTrack(track.id, QualityTrack.low));
  //   _getTrackURLAsyncOperation.then((trackURL) => _playTrack(trackURL));
  // }

  void preloadTrack(Track track) {
    _player.pause();
    setSeek(0);

    _getTrackURLAsyncOperation?.cancel();
    _getTrackURLAsyncOperation = CancelableOperation.fromFuture(client.downloadTrack(trackId: track.id, quality: QualityTrack.low));
    _getTrackURLAsyncOperation?.then((trackURL) => _playTrack(trackURL));
  }

  void setOneTrack(Track track) {
    _playlistProvider.tracks = ([track]);
  }

  void playTrack() {
    preloadTrack(_playlistProvider.currentTrack!);
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

  void setSeek(double ms) async {
    await _player.seek(Duration(milliseconds: ms.toInt()));
    notifyListeners();
  }

  void setVolume(double volume) async {
    await _player.setVolume(volume);
  }

  void _playTrack(String url) async {
    _player.setSourceUrl(url);
    resume();
    notifyListeners();
  }

  @override
  Future<void> dispose() async {
    // _playlistProvider.onTrackChange.
    // _playlistProvider.onNextTrackPlay.unsubscribeAll();
    // _playlistProvider.onCurrentTrackUpdated.unsubscribeAll();
    _onTrackChangeSubscribe?.cancel();
    _onPlayerStateChangedSubscribe?.cancel();
    super.dispose();
    _player.dispose();
  }

  ///Удалить если чего
  IconData icon() {
    switch (playerState) {
      // case PlayerState.stopped:
      //   return m.Icons.stop_rounded;
      //   break;
      case PlayerState.playing:
        return m.Icons.pause;
        break;
      case PlayerState.paused:
        return m.Icons.play_arrow;
        break;
      // case PlayerState.completed:
      //   return m.Icons.not_interested;
      //   break;
      default:
        return m.Icons.not_interested;
    }
  }
}
