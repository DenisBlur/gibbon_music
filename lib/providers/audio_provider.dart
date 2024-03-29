import 'dart:async';

import 'package:async/async.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as m;
import 'package:gibbon_music/domain/models/playlist.dart';
import 'package:gibbon_music/main.dart';
import 'package:yam_api/enums.dart';
import 'package:yam_api/track/track.dart';
import 'package:yam_api/track/track_lyric.dart';

class AudioProvider extends ChangeNotifier {
  AudioProvider(this._playlistProvider) {
    init();
  }

  final NewPlaylist _playlistProvider;

  late AudioPlayer _player;

  TrackLyric _lyric = TrackLyric();

  TrackLyric get lyric => _lyric;

  set lyric(TrackLyric value) {
    _lyric = value;
    notifyListeners();
  }

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

    _onTrackChangeSubscribe = _playlistProvider.onTrackChange.listen((event) async {
      if (event is RadioFeedback) {
        await client.radio.sendRotorRadioFeedback(
            feedback: RadioFeedback.trackStarted,
            trackId: _playlistProvider.currentTrack!.id.toString(),
            albumId: _playlistProvider.currentTrack!.albums![0].id.toString());
        switch (event) {
          case RadioFeedback.trackStarted:
            break;
          case RadioFeedback.trackFinished:
            await client.radio.sendRotorRadioFeedback(
                feedback: event,
                trackId: _playlistProvider.currentTrack!.id.toString(),
                albumId: _playlistProvider.currentTrack!.albums![0].id.toString(),
                seconds: 0.1);
            break;
          case RadioFeedback.skip:
            await client.radio.sendRotorRadioFeedback(
                feedback: event,
                trackId: _playlistProvider.currentTrack!.id.toString(),
                albumId: _playlistProvider.currentTrack!.albums![0].id.toString(),
                seconds: await getDuration());
            break;
          case RadioFeedback.getTracks:
            await client.radio.sendRotorRadioFeedback(
                feedback: RadioFeedback.trackStarted,
                trackId: _playlistProvider.currentTrack!.id.toString(),
                albumId: _playlistProvider.currentTrack!.albums![0].id.toString());
            break;
          case RadioFeedback.radioStarted:
          case RadioFeedback.off:
          case RadioFeedback.on:
            break;
        }
      }

      if (_playlistProvider.currentTrack == null) {
        pause();
      } else {
        preloadTrack(_playlistProvider.currentTrack!);
      }

      notifyListeners();
    });

    _onPlayerStateChangedSubscribe = onPlayerStateChanged.listen((event) {
      if (event == PlayerState.completed) {
        _playlistProvider.onTrackEnd();
        notifyListeners();
      }
    });
  }

  void preloadTrack(Track track) async {
    await _player.pause();
    setSeek(0);
    if(_playlistProvider.currentTrack!.albums!.isNotEmpty) {
      client.queue.playAudio(_playlistProvider.currentTrack!.id!, _playlistProvider.currentTrack!.albums![0].id.toString(),
          _playlistProvider.currentTrack!.durationMs!.toDouble());
    }
    client.getTrackLyric(_playlistProvider.currentTrack!).then((value) {
      lyric = value;
    });
    await _getTrackURLAsyncOperation?.cancel();
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
    await _player.setSourceUrl(url);
    resume();
    notifyListeners();
  }

  Future<double> getDuration() async {
    var position = await _player.getCurrentPosition();
    return position!.inSeconds.toDouble();
  }

  @override
  Future<void> dispose() async {
    // _playlistProvider.onTrackChange.
    // _playlistProvider.onNextTrackPlay.unsubscribeAll();
    // _playlistProvider.onCurrentTrackUpdated.unsubscribeAll();
    await _onTrackChangeSubscribe?.cancel();
    await _onPlayerStateChangedSubscribe?.cancel();
    super.dispose();
    await _player.dispose();
  }

  ///Удалить если чего
  IconData icon() {
    switch (playerState) {
      case PlayerState.playing:
        return m.Icons.pause;
      case PlayerState.paused:
        return m.Icons.play_arrow;
      default:
        return m.Icons.not_interested;
    }
  }
}
