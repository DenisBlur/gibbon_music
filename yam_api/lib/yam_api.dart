library yam_api;

import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';
import 'package:yam_api/models/Landing/Charts.dart';

import 'models/Account/account_settings.dart';
import 'models/Account/account_status.dart';
import 'models/Download/DownloadInfo.dart';

class YamApi {
  static String tokenMain = "AQAAAAAV_ACCAAG8XkFW219h4UiInu2aEV4ZGL4";
  static String baseUrl = "https://api.music.yandex.net";
  static String device = "os=Python; os_version=; manufacturer=Marshal; model=Yandex Music API; clid=; device_id=random; uuid=random";

  static void init(String token) {
    tokenMain = token;
  }

  static Future<AccountStatusModel> accountStatusRequest() async {
    //Получение статуса аккаунта. Нет обязательных параметров.
    var response = await http.get(Uri.parse("$baseUrl/account/status"), headers: {'Authorization': 'OAuth $tokenMain'});
    if (response.statusCode == 200) {
      return AccountStatusModel.fromMap(jsonDecode(response.body));
    } else {
      return AccountStatusModel.fromMap(jsonDecode(response.body));
    }
  }

  static Future<AccountSettingsModel> accountSettingRequest() async {
    var response = await http.get(Uri.parse("$baseUrl/account/settings"), headers: {'Authorization': 'OAuth $tokenMain'});
    if (response.statusCode == 200) {
      return AccountSettingsModel.fromMap(jsonDecode(response.body));
    } else {
      return AccountSettingsModel.fromMap(jsonDecode(response.body));
    }
  }

  static Future<Charts> charts() async {
    var response = await http.get(Uri.parse("$baseUrl/landing3/chart"), headers: {'Authorization': 'OAuth $tokenMain'});
    if (response.statusCode == 200) {
      return Charts.fromMap(jsonDecode(response.body));
    } else {
      return Charts.fromMap(jsonDecode(response.body));
    }
  }

  static Future<String> getAlbum(int albumId) async {
    var response = await http.get(Uri.parse("$baseUrl/albums/$albumId/with-tracks"), headers: {'Authorization': 'OAuth $tokenMain'});
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return response.body;
    }
  }

  static Future<String> getPlaylist(String user, int playlistId) async {
    var response = await http.get(Uri.parse("$baseUrl/users/$user/playlists/$playlistId"), headers: {'Authorization': 'OAuth $tokenMain'});
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return response.body;
    }
  }

  static Future<String> getUserPlaylist(int userId) async {
    var response = await http.get(Uri.parse("$baseUrl/users/$userId/playlists/list"), headers: {'Authorization': 'OAuth $tokenMain'});
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return response.body;
    }
  }

  static Future<String> getArtist(int artistId) async {
    var response = await http.get(Uri.parse("$baseUrl/artists/$artistId/brief-info"), headers: {'Authorization': 'OAuth $tokenMain'});
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return response.body;
    }
  }

  static Future<String> promotions(List<String> blocks) async {
    String _blocks = "";
    for (String bl in blocks) {
      _blocks = _blocks + "$bl,";
    }
    var response = await http.get(Uri.parse("$baseUrl/landing3?blocks=$_blocks"), headers: {'Authorization': 'OAuth $tokenMain'});
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return response.body;
    }
  }

  static Future<String> downloadTrack(String trackId) async {
    var responseInfo = await http.get(Uri.parse("$baseUrl/tracks/$trackId/download-info"), headers: {'Authorization': 'OAuth $tokenMain'});
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
        return "https://$host/get-mp3/$sign/$ts$path";
      } else {
        return "error";
      }
    } else {
      return "error";
    }
  }

  static Stream<String> downloadMoreTrack(List<String> listTracks) async* {
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

  static Future<String> getRadio() async {
    var response = await http.get(Uri.parse("$baseUrl/rotor/stations/list"), headers: {'Authorization': 'OAuth $tokenMain'});
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return response.body;
    }
  }

  static Future<String> getStation(String genre, String tag) async {
    var response = await http.get(Uri.parse("$baseUrl/rotor/station/$genre:$tag/tracks"), headers: {'Authorization': 'OAuth $tokenMain'});
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return response.body;
    }
  }

// Post запросы
  static Future<String> postStationFeedback(String genre, String tag) async {
    var response = await http.post(Uri.parse("$baseUrl/rotor/station/$genre:$tag/feedback"), headers: {'Authorization': 'OAuth $tokenMain'});
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return response.body;
    }
  }

  static Future<String> postPlayAudio(
      int trackId, String albumId, playlistId, uId, int trackLengthSeconds, totalPlayedSeconds, endPositionSeconds) async {
    var timeStamp = "${DateTime.now().toIso8601String()}Z";
    String params =
        "?track-id=$trackId&from-cache=none&from=client$uId&play-id=none&uid=$uId&timestamp=$timeStamp&track-length-seconds=$trackLengthSeconds&total-played-seconds=$totalPlayedSeconds&end-position-seconds=$endPositionSeconds&album-id=$albumId&playlist-id=$playlistId&client-now=$timeStamp";

    var response = await http.post(Uri.parse("$baseUrl/play-audio$params"), headers: {'Authorization': 'OAuth $tokenMain'});
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return response.body;
    }
  }

  static Future<String> getSearchSuggest(String text) async {
    String params = "?part=$text";
    var response = await http.get(Uri.parse("$baseUrl/search/suggest$params"), headers: {'Authorization': 'OAuth $tokenMain'});
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return response.body;
    }
  }

  static Future<String> getSearch(String text) async {
    String params = "?text=$text&nocorrect=false&type=all&page=0&playlist-in-best=false";
    var response = await http.get(Uri.parse("$baseUrl/search/$params"), headers: {'Authorization': 'OAuth $tokenMain'});
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return response.body;
    }
  }
}
