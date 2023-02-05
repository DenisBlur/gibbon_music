import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:gibbon_music/domain/models/like_model.dart';
import 'package:gibbon_music/main.dart';
import 'package:yam_api/enums.dart';
import 'package:yam_api/track/track.dart';

import '../domain/models/queue_model.dart';

class YandexProvider extends ChangeNotifier {
  LikeModel likeModel;
  QueueModel queueModel;

  bool isRadioPlaying = false;
  String batchId = "";
  String station = "";

  YandexProvider({required this.likeModel, required this.queueModel});

  bool trackIsLiked(String trackId) {
    return likeModel.trackIsLiked(trackId: trackId);
  }

  bool playlistIsLiked(String playlistKind, String playlistId) {
    return likeModel.playlistIsLiked(playlistKind: playlistKind, playlistId: playlistId);
  }

  bool albumIsLiked(String albumId) {
    return likeModel.albumIsLiked(albumId: albumId);
  }

  bool artistIsLiked(String artistId) {
    return likeModel.artistIsLiked(artistId: artistId);
  }

  Future trackActionLike(String? trackId) async {
    await likeModel.trackActionLike(trackId: trackId);
    notifyListeners();
  }

  Future playlistActionLike(String? playlistId, String? playlistKind) async {
    await likeModel.playlistActionLike(playlistId: playlistId, playlistKind: playlistKind);
    notifyListeners();
  }

  Future albumActionLike(String? albumId) async {
    await likeModel.albumActionLike(albumId: albumId);
    notifyListeners();
  }

  Future artistActionLike(String? artistId) async {
    await likeModel.artistActionLike(artistId: artistId);
    notifyListeners();
  }

  Future createQueue(List<Track?>? tracks, int currentIndex, String objectId, ObjectType type) async {
    await queueModel.createQueue(tracks, currentIndex, objectId, type);
  }

  updateQueuePosition() {}

  Future startRadio(bool isRadio, String batchId, station) async {
    isRadioPlaying = isRadio;
    this.batchId = batchId;
    this.station = station;
    radioFeedback(type: RotorFeedback.radioStarted);
  }

  Future radioFeedback({required RotorFeedback type, String trackId = "0", int totalPlayedSeconds = 0}) async {
    if(isRadioPlaying) {
      await client.rotorStationFeedback(type: type, batchId: batchId, trackId: trackId, station: station, totalPlayedSeconds: totalPlayedSeconds);
    }
  }
}
