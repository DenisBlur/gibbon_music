import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:yam_api/album/album.dart';
import 'package:yam_api/artist/artist.dart';
import 'package:yam_api/artist/artist_albums.dart';
import 'package:yam_api/artist/artist_tracks.dart';
import 'package:yam_api/enums.dart';
import 'package:yam_api/feed/feed.dart';
import 'package:yam_api/landing/landing.dart';
import 'package:yam_api/landing/new_playlists.dart';
import 'package:yam_api/landing/new_releases.dart';
import 'package:yam_api/playlist/playlist.dart';
import 'package:yam_api/queue/queue_item.dart';
import 'package:yam_api/queue/queues_list.dart';
import 'package:yam_api/request_client.dart';
import 'package:yam_api/rotor/dashboard.dart';
import 'package:yam_api/rotor/list_stations.dart';
import 'package:yam_api/search/search_sugges.dart';
import 'package:yam_api/settings.dart';
import 'package:yam_api/supplement/supplement.dart';

import 'account/status.dart';
import 'account/user_settings.dart';
import 'landing/chart.dart';
import 'models/error_model.dart';
import 'permission_alerts.dart';
import 'search/search.dart';
import 'track/track.dart';
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
    device = await _device();
    headers = {'Authorization': 'OAuth $token'};
    await accountStatus().then((value) async {
      userId = value.account?.uid.toString();
      print(userId);
    });
    deviceHeaders = {'Authorization': 'OAuth $token', 'X-Yandex-Music-Device': '$device'};
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
    String data = "?track-id=$trackId"
        "&from=$device"
        "&play-id=,"
        "&uid=$userId"
        "&timestamp=$currentTime"
        "&client-now=$currentTime";

    var result = await RequestClient(headers: headers).requestPost(url: "/play-audio$data", body: {});
    return result;
  }

  Future<Album> getAlbumWithTracks(num albumId) async {
    ///Получение альбома по его уникальному идентификатору вместе с треками.
    var result = await RequestClient(headers: headers).requestGet("/albums/$albumId/with-tracks");
    return Album.fromJson(jsonDecode(result)["result"]);
  }

  Future<Search> search({
    required String text,
    SearchType type = SearchType.all,
    int page = 0,
  }) async {
    ///Подробный поиск
    String data = "?text=$text"
        "&nocorrect=true"
        "&type=${type.name}"
        "&page=$page";

    var result = await RequestClient(headers: headers).requestGet("/search$data");
    return Search.fromJson(jsonDecode(result)["result"]);
  }

  Future<SearchSuggest> searchSuggest({
    required String text,
  }) async {
    ///Получение подсказок по введенной части поискового запроса
    var result = await RequestClient(headers: headers).requestGet("/search/suggest?part=$text");
    return SearchSuggest.fromJson(jsonDecode(result)["result"]);
  }

  Future<Dashboard> rotorStationsDashboard() async {
    ///Получение рекомендованных станций текущего пользователя
    var result = await RequestClient(headers: headers).requestGet("/rotor/stations/dashboard");
    return Dashboard.fromJson(jsonDecode(result)["result"]);
  }

  Future<ListStations> rotorStationsList() async {
    ///Получение всех радиостанций с настройками пользователя
    var result = await RequestClient(headers: headers).requestGet("/rotor/stations/list");
    return ListStations.fromJson(jsonDecode(result));
  }

  Future<Artist> getArtistPage(String artistId) async {
    ///Получение информации об артисте
    var result = await RequestClient(headers: headers).requestGet("/artists/$artistId/brief-info");
    return Artist.fromJson(jsonDecode(result)["result"]);
  }

  Future<ArtistTracks> getArtistTracks(String artistId) async {
    ///Получение треков артиста
    var result = await RequestClient(headers: headers).requestGet("/artists/$artistId/tracks");
    return ArtistTracks.fromJson(jsonDecode(result)["result"]);
  }

  Future<ArtistAlbums> getArtistAlbums(String artistId) async {
    ///Получение альбомов артиста
    var result = await RequestClient(headers: headers).requestGet("/artists/$artistId/direct-albums");
    return ArtistAlbums.fromJson(jsonDecode(result)["result"]);
  }

  Future<String> likeAction({required String objectId, required ObjectType objectType, required bool remove}) async {
    ///Действия с отметкой "мне нравится"

    var action = remove ? 'remove' : 'add-multiple';
    var result =
        await RequestClient(headers: headers).requestPost(url: "/users/$userId/likes/${objectType.name}s/$action?${objectType.name}-ids=$objectId", body: {});
    return result;
  }

  Future<String> dislikeAction({required String trackId, required bool remove}) async {
    ///Действия с отметкой "Не рекомендовать"
    var action = remove ? 'remove' : 'add-multiple';
    var result = await RequestClient(headers: headers).requestPost(url: "/users/$userId/dislikes/tracks/$action?track-ids=$trackId", body: {});
    return result;
  }

  Future<String> likeGet({required ObjectType objectType}) async {
    ///Получить объекты с отметкой "мне нравится"
    var result = await RequestClient(headers: headers).requestGet("/users/$userId/likes/${objectType.name}s");
    return result;
  }

  Future<List<Playlist>> userPlaylists() async {
    ///Получает плейлисты пользователя
    List<Playlist> userPlaylists = [];
    var result = await RequestClient(headers: headers).requestGet("/users/$userId/playlists/list");
    var jsonResult = jsonDecode(result);
    jsonResult['result'].forEach((v) {
      userPlaylists.add(Playlist.fromJson(v));
    });
    return userPlaylists;
  }

  Future<QueuesList> getQueuesList() async {
    ///Получение информации об артисте
    var result = await RequestClient(headers: deviceHeaders).requestGet("/queues");
    return QueuesList.fromJson(jsonDecode(result)["result"]);
  }

  Future<QueueItem> getQueue({required String queueId}) async {
    ///Получение информации об артисте
    var result = await RequestClient(headers: deviceHeaders).requestGet("/queues/$queueId");
    return QueueItem.fromJson(jsonDecode(result)["result"]);
  }

  Future<String> createQueue(List<Track> tracks, int currentIndex) async {
    ///Получение информации об артисте

    List<Tracks> queueTracks = [];

    for (var element in tracks) {

      var track = Tracks(
        trackId: element.id,
        albumId: element.albums!.first.id.toString(),
        from: "mobile-own_tracks-playlist-default",
      );

      queueTracks.add(track);

    }

    var data = QueueItem(
      id: const Uuid().v1(),
      context: MainContext(id: "368836738:1001", description: "Hello", login: "tokar-denis2017", type: "playlist"),
      initialContext: MainContext(id: "368836738:1001", description: "Hello", login: "tokar-denis2017", type: "playlist"),
      currentIndex: currentIndex,
      modified: formatISOTime(DateTime.now()),
      tracks: queueTracks
    ).toJson();
    var result = await RequestClient(headers: deviceHeaders).requestPost(url: "/queues", body: data);
    return result;
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

}

