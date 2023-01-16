import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:yam_api/album/album.dart';
import 'package:yam_api/enums.dart';
import 'package:yam_api/feed/feed.dart';
import 'package:yam_api/landing/landing.dart';
import 'package:yam_api/landing/new_playlists.dart';
import 'package:yam_api/landing/new_releases.dart';
import 'package:yam_api/request_client.dart';
import 'package:yam_api/settings.dart';
import 'package:yam_api/supplement/supplement.dart';

import 'account/status.dart';
import 'account/user_settings.dart';
import 'landing/chart.dart';
import 'models/error_model.dart';
import 'permission_alerts.dart';
import 'track/track_similar.dart';

class Client {
  String token = "";
  String language = "ru";

  String? userId = "";
  String? device = "";

  Map<String, String> headers = {};
  Map<String, String> deviceHeaders = {};

  Future init({required String token}) async {
    this.token = token;
    headers = {'Authorization': 'OAuth $token'};
    device = await _device();
    await accountStatus().then((value) {
      userId = value.account?.uid.toString()!;
    });
  }

  Future<String?> _device() async {
    // ignore: prefer_const_constructors
    String uuid = Uuid().v1();
    // ignore: prefer_const_constructors
    String clientId = Uuid().v1();

    final deviceInfoPlugin = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidDeviceInfo = await deviceInfoPlugin.androidInfo;
      return "os=${androidDeviceInfo.version.baseOS};"
          "os_version=${androidDeviceInfo.version.sdkInt};"
          "manufacturer=${androidDeviceInfo.manufacturer};"
          "model=${androidDeviceInfo.model};"
          "clid= $clientId;"
          "device_id=${androidDeviceInfo.device};"
          "uuid=$uuid";
    } else {
      WindowsDeviceInfo windowsDeviceInfo = await deviceInfoPlugin.windowsInfo;
      return "os=${windowsDeviceInfo.productName};"
          "os_version=${windowsDeviceInfo.buildNumber};"
          "manufacturer=${windowsDeviceInfo.userName};"
          "model=${windowsDeviceInfo.computerName};"
          "clid= $clientId;"
          "device_id=${windowsDeviceInfo.deviceId};"
          "uuid=$uuid";
    }
  }

  Future<Status> accountStatus() async {
    ///получение статуса аккаунта. Нет обязательных параметров.
    var result = await RequestClient(headers: headers).requestGet("/account/status");
    return Status.fromJson(jsonDecode(result)["result"]);
  }

  Future<UserSettings> accountSettings() async {
    ///Получение настроек текущего пользователя.
    var result = await RequestClient(headers: headers).requestGet("/account/settings");
    return UserSettings.fromJson(jsonDecode(result)["result"]);
  }

  Future accountSettingsSet(String param, value) async {
    ///Изменение настроек текущего пользователя.
    var data = {param: value};
    var result = await RequestClient(headers: headers).requestPost(url: "/account/settings", body: data);
    return UserSettings.fromJson(jsonDecode(result)["result"]);
  }

  Future<Settings> settings() async {
    ///Получение предложений по покупке
    var result = await RequestClient(headers: headers).requestGet("/settings");
    return Settings.fromJson(jsonDecode(result)["result"]);
  }

  Future<PermissionAlerts> permissionAlerts() async {
    ///Получение оповещений
    var result = await RequestClient(headers: headers).requestGet("/permission-alerts");
    return PermissionAlerts.fromJson(jsonDecode(result)["result"]);
  }

  Future<Feed> feed() async {
    ///Получение потока информации (фида) подобранного под пользователя. Содержит умные плейлисты.
    var result = await RequestClient(headers: headers).requestGet("/feed");
    return Feed.fromJson(jsonDecode(result)["result"]);
  }

  Future<Landing> landing({required List<String> blocks}) async {
    ///Получение лендинг-страницы содержащий блоки с новыми релизами, чартами, плейлистами с новинками и т.д.
    ///Поддерживаемые типы блоков: `personalplaylists`, `promotions`, `new-releases`, `new-playlists`, `mixes`,`chart`, `artists`, `albums`, `playlists`, `play_contexts`.
    String _blocks = "";
    for (String bl in blocks) {
      _blocks = _blocks + "$bl,";
    }
    var result = await RequestClient(headers: headers).requestGet("/landing3?blocks=$_blocks");
    return Landing.fromJson(jsonDecode(result)["result"]);
  }

  Future<Chart> chart({ChartSelect chartSelect = ChartSelect.russia}) async {
    ///Получение чарта
    var result = await RequestClient(headers: headers).requestGet("/landing3/chart/${chartSelect.name}");
    return Chart.fromJson(jsonDecode(result)["result"]);
  }

  Future<NewReleases> newReleases() async {
    ///Получение полного списка всех новых релизов (альбомов)
    var result = await RequestClient(headers: headers).requestGet("/landing3/new-releases");
    return NewReleases.fromJson(jsonDecode(result)["result"]);
  }

  Future<NewPlaylists> newPlaylists() async {
    ///Получение полного списка всех новых релизов (альбомов)
    var result = await RequestClient(headers: headers).requestGet("/landing3/new-playlists");
    return NewPlaylists.fromJson(jsonDecode(result)["result"]);
  }

  Future<Supplement> trackSupplement(String trackId) async {
    ///Получение дополнительной информации о треке.
    var result = await RequestClient(headers: headers).requestGet("/tracks/$trackId/supplement");
    return Supplement.fromJson(jsonDecode(result)["result"]);
  }

  Future<TrackSimilar> tracksSimilar(String trackId) async {
    ///Получение похожих треков.
    var result = await RequestClient(headers: headers).requestGet("/tracks/$trackId/similar");
    return TrackSimilar.fromJson(jsonDecode(result)["result"]);
  }

  String formatISOTime(DateTime date) {
    //converts date into the following format:
// or 2019-06-04T12:08:56.235-0700
    var duration = date.timeZoneOffset;
    if (duration.isNegative) {
      return (DateFormat("yyyy-MM-ddTHH:mm:ss.mmm").format(date) +
          "-${duration.inHours.toString().padLeft(2, '0')}${(duration.inMinutes - (duration.inHours * 60)).toString().padLeft(2, '0')}");
    } else {
      return (DateFormat("yyyy-MM-ddTHH:mm:ss.mmm").format(date) +
          "+${duration.inHours.toString().padLeft(2, '0')}${(duration.inMinutes - (duration.inHours * 60)).toString().padLeft(2, '0')}");
    }
  }

  Future<String> playAudio(String trackId) async {
    ///Отправка трека на сервер
    String currentTime = "${DateTime.now().toIso8601String()}Z";
    String data =
        "?track-id=$trackId"
        "&from=$device"
        "&play-id=,"
        "&uid=$userId"
        "&timestamp=$currentTime"
        "&client-now=$currentTime";

    var result = await RequestClient(headers: headers).requestPost(url: "/play-audio$data");
    return result;
  }

  Future<Album> getAlbumWithTracks(num albumId) async {
    ///Получение альбома по его уникальному идентификатору вместе с треками.
    var result = await RequestClient(headers: headers).requestGet("/albums/$albumId/with-tracks");
    return Album.fromJson(jsonDecode(result)["result"]
    );
  }
// Future<> name() async {
//   ///Получение полного списка всех новых релизов (альбомов)
//   var result = await RequestClient(headers: headers).requestGet("/landing3/new-playlists");
//   return .fromJson(jsonDecode(result)["result"]);
// }
// Future<> name() async {
//   ///Получение полного списка всех новых релизов (альбомов)
//   var result = await RequestClient(headers: headers).requestGet("/landing3/new-playlists");
//   return .fromJson(jsonDecode(result)["result"]);
// }
// Future<> name() async {
//   ///Получение полного списка всех новых релизов (альбомов)
//   var result = await RequestClient(headers: headers).requestGet("/landing3/new-playlists");
//   return .fromJson(jsonDecode(result)["result"]);
// }
// Future<> name() async {
//   ///Получение полного списка всех новых релизов (альбомов)
//   var result = await RequestClient(headers: headers).requestGet("/landing3/new-playlists");
//   return .fromJson(jsonDecode(result)["result"]);
// }

}
