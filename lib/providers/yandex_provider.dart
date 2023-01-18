import 'package:flutter/foundation.dart';
import 'package:gibbon_music/domain/models/like.dart';

class YandexProvider extends ChangeNotifier {
  Like like;

  YandexProvider({required this.like});

  bool trackIsLiked(String trackId) {
    return like.trackIsLiked(trackId: trackId);
  }

  bool playlistIsLiked(String playlistKind, String playlistId) {
    return like.playlistIsLiked(playlistKind: playlistKind, playlistId: playlistId);
  }

  bool albumIsLiked(String albumId) {
    return like.albumIsLiked(albumId: albumId);
  }

  bool artistIsLiked(String artistId) {
    return like.artistIsLiked(artistId: artistId);
  }

  Future trackActionLike(String? trackId) async {
    await like.trackActionLike(trackId: trackId);
    notifyListeners();
  }

  Future playlistActionLike(String? playlistId, String? playlistKind) async {
    await like.playlistActionLike(playlistId: playlistId, playlistKind: playlistKind);
    notifyListeners();
  }

  Future albumActionLike(String? albumId) async {
    await like.albumActionLike(albumId: albumId);
    notifyListeners();
  }

  Future artistActionLike(String? artistId) async {
    await like.artistActionLike(artistId: artistId);
    notifyListeners();
  }
}
