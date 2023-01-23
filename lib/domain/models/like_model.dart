import 'dart:convert';

import 'package:darq/darq.dart';
import 'package:gibbon_music/main.dart';
import 'package:yam_api/enums.dart';

class LikeModel {
  LikeModel() {
    init();
  }

  List<String>? trackLikesList;
  List<String>? playlistLikesList;
  List<String>? albumLikesList;
  List<String>? artistLikesList;

  init() async {
    trackLikesList = await getLike(type: ObjectType.track);
    playlistLikesList = await getLike(type: ObjectType.playlist);
    albumLikesList = await getLike(type: ObjectType.album);
    artistLikesList = await getLike(type: ObjectType.artist);
  }

  Future<List<String>> getLike({required ObjectType type}) async {
    String result = await client.likeGet(objectType: type);
    var jsonResult = jsonDecode(result);
    if(type == ObjectType.track) {
      List<dynamic> list = jsonResult["result"]["library"]["tracks"];
      List<String>? returnList = list.select((e, _) => e["id"].toString()).toList();
      return returnList;
    }
    if(type == ObjectType.playlist) {
      List<dynamic> list = jsonResult["result"];
      List<String>? returnList = list.select((e, _) {
        String uid = e["playlist"]["uid"].toString();
        String kind = e["playlist"]["kind"].toString();
        return "$uid:$kind";
      }).cast<String>().toList();
      return returnList;
    }
    if(type == ObjectType.album) {
      List<dynamic> list = jsonResult["result"];
      List<String>? returnList = list.select((e, _) => e["id"].toString()).toList();
      return returnList;
    }
    if(type == ObjectType.artist) {
      List<dynamic> list = jsonResult["result"];
      List<String>? returnList = list.select((e, _) => e["id"].toString()).toList();
      return returnList;
    }
    return [];
  }

  bool trackIsLiked({required String? trackId}) {
    return trackLikesList!.contains(trackId);
  }
  bool playlistIsLiked({required String? playlistId, required String? playlistKind}) {
    return playlistLikesList!.contains("$playlistId:$playlistKind");
  }
  bool albumIsLiked({required String? albumId}) {
    return albumLikesList!.contains(albumId);
  }
  bool artistIsLiked({required String? artistId}) {
    return artistLikesList!.contains(artistId);
  }

  Future trackActionLike({required String? trackId}) async {
    bool remove = trackIsLiked(trackId: trackId);
    String result = await client.likeAction(objectId: trackId.toString(), objectType: ObjectType.track, remove: remove);
    if(!result.contains("error"))
    {
      if(remove)
      {
        trackLikesList!.remove(trackId);
      }
      else
      {
        trackLikesList!.add(trackId!);
      }
    }
  }
  Future playlistActionLike({required String? playlistId, required String? playlistKind}) async {
    bool remove = playlistIsLiked(playlistId: playlistId, playlistKind: playlistKind);
    String result = await client.likeAction(objectId: "$playlistId:$playlistKind", objectType: ObjectType.playlist, remove: remove);
    if(!result.contains("error"))
    {
      if(remove)
      {
        playlistLikesList!.remove("$playlistId:$playlistKind");
      }
      else
      {
        playlistLikesList!.add("$playlistId:$playlistKind");
      }
    }
  }
  Future albumActionLike({required String? albumId}) async {
    bool remove = albumIsLiked(albumId: albumId);
    String result = await client.likeAction(objectId: albumId.toString(), objectType: ObjectType.album, remove: remove);
    if(!result.contains("error"))
    {
      if(remove)
      {
        albumLikesList!.remove(albumId);
      }
      else
      {
        albumLikesList!.add(albumId!);
      }
    }
  }
  Future artistActionLike({required String? artistId}) async {
    bool remove = artistIsLiked(artistId: artistId);
    String result = await client.likeAction(objectId: artistId.toString(), objectType: ObjectType.artist, remove: remove);
    if(!result.contains("error"))
    {
      if(remove)
      {
        artistLikesList!.remove(artistId);
      }
      else
      {
        artistLikesList!.add(artistId!);
      }
    }
  }
}