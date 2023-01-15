library yam_api;

import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';
import 'package:yam_api/models/error_model.dart';

import 'models/Download/DownloadInfo.dart';

enum QualityTrack { medium, high, low }

enum ActionType { playlist, artist, album, track }

class YamApi {
  static const String baseUrl = "https://api.music.yandex.net";
  static const String device = "os=Python; os_version=; manufacturer=Marshal; model=Yandex Music API; clid=; device_id=random; uuid=random";

  static String tokenMain = "";
  static String userId = "";

  YamApi();

  init(String token) async {
    tokenMain = token;
    var result = await accountStatusRequest();
    var jsonResult = jsonDecode(result);
    userId = jsonResult["result"]["account"]["uid"].toString();
  }

  Future<String> checkResponse(http.Response response) async {
    if (response.statusCode == 200) {
      if (kDebugMode) {
        print(response.body);
      }
      return response.body;
    } else {
      ErrorModel errorModel = ErrorModel(error: ErrorResult(result: response.body, statusCode: response.statusCode));
      if (kDebugMode) {
        print("Status Code: ${errorModel.error?.statusCode}");
        ///print(errorModel.toJson().toString());
      }
      return errorModel.toJson().toString();
    }
  }

  ///Start future like

  Future<bool> removeLike(String objectId, ActionType actionType) async {
    String action = "none";
    switch (actionType) {
      case ActionType.playlist:
        action = "playlist";
        break;
      case ActionType.artist:
        action = "artist";
        break;
      case ActionType.album:
        action = "album";
        break;
      case ActionType.track:
        action = "track";
        break;
    }
    String response = await actionLike(objectId, action, true);
    return response == "error" ? false : true;
  }

  Future<bool> setLike(String objectId, ActionType actionType) async {
    String action = "none";
    switch (actionType) {
      case ActionType.playlist:
        action = "playlist";
        break;
      case ActionType.artist:
        action = "artist";
        break;
      case ActionType.album:
        action = "album";
        break;
      case ActionType.track:
        action = "track";
        break;
    }
    String response = await actionLike(objectId, action, false);
    return response.contains("error") ? false : true;
  }

  Future<String> actionLike(String objectId, String type, bool remove) async {
    var action = remove ? "remove" : "add-multiple";
    var response = await http
        .post(Uri.parse("$baseUrl/users/$userId/likes/${type}s/$action?$type-ids=$objectId"), headers: {'Authorization': 'OAuth $tokenMain'});
    return checkResponse(response);
  }

  Future<String> getLikes(ActionType actionType) async {
    String action = "none";
    switch (actionType) {
      case ActionType.playlist:
        action = "playlist";
        break;
      case ActionType.artist:
        action = "artist";
        break;
      case ActionType.album:
        action = "album";
        break;
      case ActionType.track:
        action = "track";
        break;
    }
    return await getLike(action);
  }

  ///End future like

  Future<String> getLike(String type) async {
    var response = await http.get(Uri.parse("$baseUrl/users/$userId/likes/${type}s"), headers: {'Authorization': 'OAuth $tokenMain'});
    return checkResponse(response);
  }

  Future<String> accountStatusRequest() async {
    //Получение статуса аккаунта. Нет обязательных параметров.
    var response = await http.get(Uri.parse("$baseUrl/account/status"), headers: {'Authorization': 'OAuth $tokenMain'});
    return checkResponse(response);
  }

  Future<String> accountSettingRequest() async {
    var response = await http.get(Uri.parse("$baseUrl/account/settings"), headers: {'Authorization': 'OAuth $tokenMain'});
    return checkResponse(response);
  }

  Future<String> charts() async {
    var response = await http.get(Uri.parse("$baseUrl/landing3/chart"), headers: {'Authorization': 'OAuth $tokenMain'});
    return checkResponse(response);
  }

  Future<String> getAlbum(int albumId) async {
    var response = await http.get(Uri.parse("$baseUrl/albums/$albumId/with-tracks"), headers: {'Authorization': 'OAuth $tokenMain'});
    return checkResponse(response);
  }

  Future<String> getPlaylist(String user, String playlistId) async {
    var response = await http.get(Uri.parse("$baseUrl/users/$user/playlists/$playlistId"), headers: {'Authorization': 'OAuth $tokenMain'});
    return checkResponse(response);
  }

  Future<String> getUserPlaylist(int userId) async {
    var response = await http.get(Uri.parse("$baseUrl/users/$userId/playlists/list"), headers: {'Authorization': 'OAuth $tokenMain'});
    return checkResponse(response);
  }

  Future<String> getArtist(int artistId) async {
    var response = await http.get(Uri.parse("$baseUrl/artists/$artistId/brief-info"), headers: {'Authorization': 'OAuth $tokenMain'});
    return checkResponse(response);
  }

  Future<String> promotions(List<String> blocks) async {
    String _blocks = "";
    for (String bl in blocks) {
      _blocks = _blocks + "$bl,";
    }
    var response = await http.get(Uri.parse("$baseUrl/landing3?blocks=$_blocks"), headers: {'Authorization': 'OAuth $tokenMain'});
    return checkResponse(response);
  }

  Future<String> downloadTrack(String trackId, QualityTrack quality) async {
    var responseInfo = await http.get(Uri.parse("$baseUrl/tracks/$trackId/download-info"), headers: {'Authorization': 'OAuth $tokenMain'});
    if (responseInfo.statusCode == 200) {
      var jsonResult = jsonDecode(responseInfo.body);
      var trackInfo = DownloadInfoModel.fromMap(jsonResult);
      var response =
          await http.get(Uri.parse(trackInfo.result![quality.index].downloadInfoUrl.toString()), headers: {'Authorization': 'OAuth $tokenMain'});

      if (response.statusCode == 200) {
        final document = XmlDocument.parse(response.body);
        String host = document.findAllElements("host").first.innerText;
        String path = document.findAllElements("path").first.innerText;
        String ts = document.findAllElements("ts").first.innerText;
        String s = document.findAllElements("s").first.innerText;
        var sign = md5.convert(utf8.encode("XGRlBW9FXlekgbPrRHuSiA${path.substring(1, path.length - 1)}$s"));
        return "https://$host/get-mp3/$sign/$ts$path";
      } else {
        return "error";
      }
    } else {
      return "error";
    }
  }

  Stream<String> downloadMoreTrack(List<String> listTracks) async* {
    List<String> returnList = [];

    for (int i = 0; i < listTracks.length; i++) {
      var responseInfo = await http.get(Uri.parse("$baseUrl/tracks/${listTracks[i]}/download-info"), headers: {'Authorization': 'OAuth $tokenMain'});
      if (responseInfo.statusCode == 200) {
        var trackInfo = DownloadInfoModel.fromMap(jsonDecode(responseInfo.body));

        var response = await http.get(Uri.parse(trackInfo.result![1].downloadInfoUrl.toString()), headers: {'Authorization': 'OAuth $tokenMain'});

        if (response.statusCode == 200) {
          final document = XmlDocument.parse(response.body);
          String host = document.findAllElements("host").first.innerText;
          String path = document.findAllElements("path").first.innerText;
          String ts = document.findAllElements("ts").first.innerText;
          String s = document.findAllElements("s").first.innerText;
          var sign = md5.convert(utf8.encode("XGRlBW9FXlekgbPrRHuSiA${path.substring(1, path.length - 1)}$s"));
          returnList.add("https://$host/get-mp3/$sign/$ts$path");
          yield "https://$host/get-mp3/$sign/$ts$path";
        }
      }
      sleep(const Duration(milliseconds: 350));
    }
  }

  Future<String> getRadio() async {
    var response = await http.get(Uri.parse("$baseUrl/rotor/stations/list"), headers: {'Authorization': 'OAuth $tokenMain'});
    return checkResponse(response);
  }

  Future<String> getStation(String genre, String tag) async {
    var response = await http.get(Uri.parse("$baseUrl/rotor/station/$genre:$tag/tracks"), headers: {'Authorization': 'OAuth $tokenMain'});
    return checkResponse(response);
  }

// Post запросы
  Future<String> postStationFeedback(String genre, String tag) async {
    var response = await http.post(Uri.parse("$baseUrl/rotor/station/$genre:$tag/feedback"), headers: {'Authorization': 'OAuth $tokenMain'});
    return checkResponse(response);
  }

  Future<String> postPlayAudio(
      int trackId, String albumId, playlistId, uId, int trackLengthSeconds, totalPlayedSeconds, endPositionSeconds) async {
    var timeStamp = "${DateTime.now().toIso8601String()}Z";
    String params =
        "?track-id=$trackId&from-cache=none&from=client$uId&play-id=none&uid=$uId&timestamp=$timeStamp&track-length-seconds=$trackLengthSeconds&total-played-seconds=$totalPlayedSeconds&end-position-seconds=$endPositionSeconds&album-id=$albumId&playlist-id=$playlistId&client-now=$timeStamp";

    var response = await http.post(Uri.parse("$baseUrl/play-audio$params"), headers: {'Authorization': 'OAuth $tokenMain'});
    return checkResponse(response);
  }

  Future<String> getSearchSuggest(String text) async {
    String params = "?part=$text";
    var response = await http.get(Uri.parse("$baseUrl/search/suggest$params"), headers: {'Authorization': 'OAuth $tokenMain'});
    return checkResponse(response);
  }

  Future<String> getSearch(String text) async {
    String params = "?text=$text&nocorrect=false&type=all&page=0&playlist-in-best=false";
    var response = await http.get(Uri.parse("$baseUrl/search/$params"), headers: {'Authorization': 'OAuth $tokenMain'});
    return checkResponse(response);
  }
}
