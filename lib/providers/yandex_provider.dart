import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:gibbon_music/domain/models/like_model.dart';
import 'package:yam_api/enums.dart';
import 'package:yam_api/track/track.dart';

class YandexProvider extends ChangeNotifier {
  LikeModel likeModel;

  YandexProvider({required this.likeModel});

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

}
