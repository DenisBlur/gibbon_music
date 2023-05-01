import 'dart:async';

import 'package:darq/darq.dart';
import 'package:gibbon_music/domain/models/playlist.dart';
import 'package:yam_api/enums.dart';
import 'package:yam_api/track/track.dart';

import '../main.dart';

class RadioProvider {
  final NewPlaylist _playlistProvider;

  bool isRadioPlaying = false;
  String batchId = "";
  String station = "";

  List<Track?> radioTracks = [];

  RadioProvider(this._playlistProvider) {
    initRadioModule();
  }

  initRadioModule() {}

  Future startRadio(station) async {
    isRadioPlaying = true;
    this.station = station;
    getRadioTracks(true);
    await radioFeedback(type: RotorFeedback.radioStarted);
  }

  Future radioFeedback({required RotorFeedback type, String trackId = "0", int totalPlayedSeconds = 0}) async {
    if (isRadioPlaying) {
      await client.rotorStationFeedback(type: type, batchId: batchId, trackId: trackId, station: station, totalPlayedSeconds: totalPlayedSeconds);
    }
  }

  Future getRadioTracks(bool isStarting) async {
    client.rotorStationTracks(station).then((value) async {
      batchId = value.batchId!;
      var retList = value.sequence!
          .select(
            (e, _) => e.track,
          )
          .toList();
      if (isStarting) {
        radioTracks = retList;
      } else {
        radioTracks += retList;
      }
      _playlistProvider.tracks = radioTracks;
      if (isStarting) {
        _playlistProvider.currentTrackIndex = 0;
        await client.createQueue(tracks: _playlistProvider.tracks, currentIndex: 0, type: ObjectType.track,id: batchId);
        await client.playAudio(_playlistProvider.currentTrack!.id.toString());
      }
    });
  }

  checkSize() {}
}
