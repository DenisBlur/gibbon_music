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

  // StreamSubscription? _onPlaylistChangeSubscribe;

  StreamSubscription? _onPlayerStateChangedSubscribe;

  CancelableOperation? _setTrackOP;

  Future<void> init() async {
    _player = AudioPlayer();

    // preloadTrack
    // setTrack

    _onTrackChangeSubscribe = _playlistProvider.onTrackChange.listen((event) {
      pause();
      if (_playlistProvider.currentTrack != null) {
        _setTrackOP?.cancel();
        _setTrackOP = CancelableOperation.fromFuture(_setTrack(_playlistProvider.currentTrack!));
        _setTrackOP!.then((_) async {
          resume();
          await _cacheNextTrack();
        });
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

  void setOneTrack(Track track) {
    _playlistProvider.tracks = ([track]);
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

  Future _toCache(Track? track) async {
    if (track == null) return;
    var id = track.id.toString();
    if (_player.audioCache.loadedFiles.containsKey(id) == false) {
      var uri = await client.downloadTrack(trackId: track.id, quality: QualityTrack.low);
      _player.audioCache.loadedFiles.addAll({id: Uri.parse(uri)});
    }
  }

  Future _cacheNextTrack() async {
    if (_playlistProvider.canNext()) {
      await _toCache(_playlistProvider.nextInQueue());
      print("next track cached!");
    }
  }

  Future _setTrack(Track track) async {
    await _toCache(track);
    var uri = await _player.audioCache.load(track.id.toString());
    await _player.setSourceUrl(uri.toString());
    notifyListeners();
  }

  @override
  Future<void> dispose() async {
    await _onTrackChangeSubscribe?.cancel();
    await _onPlayerStateChangedSubscribe?.cancel();
    super.dispose();
    await _player.dispose();
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
