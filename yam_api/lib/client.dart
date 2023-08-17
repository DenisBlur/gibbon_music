import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import 'package:xml/xml.dart';
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
import 'package:yam_api/radio.dart';
import 'package:yam_api/request_client.dart';
import 'package:yam_api/search/search_sugges.dart';
import 'package:yam_api/settings.dart';
import 'package:yam_api/supplement/supplement.dart';
import 'package:yam_api/track/track_lyric.dart';

import 'account/status.dart';
import 'account/user_settings.dart';
import 'download_info/download_info.dart';
import 'genres/genres.dart';
import 'landing/chart.dart';
import 'permission_alerts.dart';
import 'search/search.dart';
import 'track/track.dart';
import 'track/track_similar.dart';

class Client {

  Radio radio = Radio();

  String token = "";
  String language = "ru";

  String? userId = "";
  String? device = "";

  Map<String, String> headers = {};
  Map<String, String> deviceHeaders = {};

  bool hqEnable = false;

  Status account = Status();

  Future<bool> init({required String token}) async {
    if (token.isEmpty) {
      return false;
    }
    this.token = token;
    device = await _device();
    headers = {'Authorization': 'OAuth $token'};
    await accountStatus().then((value) async {
      account = value;
      userId = value.account?.uid.toString();
    });
    deviceHeaders = {'Authorization': 'OAuth $token', 'X-Yandex-Music-Device': '$device'};

    radio.init(headers, device!);

    return account.account != null;
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
    return result.contains("error") ? Status() : Status.fromJson(jsonDecode(result)["result"]);
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
    String _blocks = blocks.join(",");
    var result = await RequestClient(headers: headers).requestGet("/landing3?blocks=$_blocks");
    return Landing.fromJson(jsonDecode(result)["result"]);
  }

  Future<Chart> chart({ChartSelect chartSelect = ChartSelect.russia}) async {
    ///Получение чарта
    var result = await RequestClient(headers: headers).requestGet("/landing3/chart/${chartSelect.name}");
    return Chart.fromJson(jsonDecode(result)["result"]);
  }

  Future<List<Genres>> genres() async {
    var result = await RequestClient(headers: headers).requestGet("/genres");
    var jsonResult = jsonDecode(result);
    List<dynamic> jsonList = jsonResult["result"];
    List<Genres> returnList = [];
    for (var e in jsonList) {
      returnList.add(Genres.fromJson(e));
    }
    return returnList;
  }

  Future<List<Album>> newReleases() async {
    ///Получение полного списка всех новых релизов (альбомов)
    List<String> uidList = [];
    var result = await RequestClient(headers: headers).requestGet("/landing3/new-releases");
    var jsonResult = NewReleases.fromJson(jsonDecode(result)["result"]);
    for (var e in jsonResult.newReleases!) {
      uidList.add(e.toString());
    }
    return await getList(type: ObjectType.album, list: uidList) as List<Album>;
  }

  Future<List<MPlaylist>> newPlaylists() async {
    ///Получение полного списка всех новых релизов (альбомов)
    List<String> uidList = [];
    var result = await RequestClient(headers: headers).requestGet("/landing3/new-playlists");
    var jsonResult = NewPlaylists.fromJson(jsonDecode(result)["result"]);
    for (var e in jsonResult.playlistIds!) {
      uidList.add("${e.uid}:${e.kind}");
    }
    var f = await getList(type: ObjectType.playlist, list: uidList) as List<MPlaylist>;
    return f;
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
  return "";
//     var duration = date.timeZoneOffset;
//     if (duration.isNegative) {
//       return (DateFormat("yyyy-MM-ddTHH:mm:ss.mmm").format(date) +
//           "-${duration.inHours.toString().padLeft(2, '0')}${(duration.inMinutes - (duration.inHours * 60)).toString().padLeft(2, '0')}");
//     } else {
//       return (DateFormat("yyyy-MM-ddTHH:mm:ss.mmm").format(date) +
//           "+${duration.inHours.toString().padLeft(2, '0')}${(duration.inMinutes - (duration.inHours * 60)).toString().padLeft(2, '0')}");
//     }
  }

  Future<String> playAudio(String trackId) async {
    ///Отправка трека на сервер
    String currentTime = "${DateTime.now().toIso8601String()}Z";
    String data = "?track-id=$trackId"
        "&from=$device"
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


  Future<MPlaylist> playlist(String uid, String playlistKind) async {
    var result = await RequestClient(headers: headers).requestGet("/users/$uid/playlists/$playlistKind");
    return MPlaylist.fromJson(jsonDecode(result)["result"]);
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

  Future<List<dynamic>?> getArtistAlbums(String artistId) async {
    ///Получение альбомов артиста
    var result = await RequestClient(headers: headers).requestGet("/artists/$artistId/direct-albums");
    return ArtistAlbums.fromJson(jsonDecode(result)["result"]).albums;
  }

  Future<String> likeAction({required String objectId, required ObjectType objectType, required bool remove}) async {
    ///Действия с отметкой "мне нравится"

    var action = remove ? 'remove' : 'add-multiple';
    var result = await RequestClient(headers: headers)
        .requestPost(url: "/users/$userId/likes/${objectType.name}s/$action?${objectType.name}-ids=$objectId", body: {});
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

  Future<List<MPlaylist>> userPlaylists() async {
    ///Получает плейлисты пользователя
    List<MPlaylist> userPlaylists = [];
    var result = await RequestClient(headers: headers).requestGet("/users/$userId/playlists/list");
    var jsonResult = jsonDecode(result);
    jsonResult['result'].forEach((v) {
      userPlaylists.add(MPlaylist.fromJson(v));
    });
    return userPlaylists;
  }

  Future<List<Track>> usersPlaylistsRecommendations(String kind) async {
    ///Получение рекомендаций для плейлиста.
    List<Track> returnList = [];
    var result = await RequestClient(headers: headers).requestGet("/users/$userId/playlists/$kind/recommendations");
    List<dynamic> jsonResult = jsonDecode(result)['result']['tracks'];
    for (var v in jsonResult) {
      returnList.add(Track.fromJson(v));
    }
    return returnList;
  }

  Future<QueuesList> getQueuesList() async {
    ///Получение всех очередей треков с разных устройств для синхронизации между ними
    var result = await RequestClient(headers: deviceHeaders).requestGet("/queues");
    return QueuesList.fromJson(jsonDecode(result)["result"]);
  }

  Future<QueueItem> getQueue({required String queueId}) async {
    ///Получение информации об очереди треков и самих треков в ней
    var result = await RequestClient(headers: deviceHeaders).requestGet("/queues/$queueId");
    return QueueItem.fromJson(jsonDecode(result)["result"]);
  }

  Future<String> queueUpdatePosition({required String queueId, required int index}) async {
    ///Установка текущего индекса проигрываемого трека в очереди треков
    var result = await RequestClient(headers: deviceHeaders)
        .requestPost(url: "/queues/$queueId/update-position?isInteractive=false&currentIndex=$index", body: {});
    return result;
  }

  Future<String> createQueue(
      {String id = "", required List<Track?>? tracks, required int currentIndex, String objectId = "", required ObjectType type}) async {
    ///Создание новой очереди треков
    List<Tracks> queueTracks = [];
    for (var element in tracks!) {
      queueTracks.add(Tracks(
        albumId: element!.albums!.isEmpty ? "" : element.albums!.first.id.toString(),
        trackId: element.id,
      ));
    }
    var data = QueueItem(
            id: id.isNotEmpty ? id : const Uuid().v1(),
            initialContext: MainContext(id: userId, description: const Uuid().v1().toString(), login: "tokar-denis2017", type: type.name),
            currentIndex: currentIndex,
            modified: formatISOTime(DateTime.now()),
            tracks: queueTracks)
        .toJson();
    var result = await RequestClient(headers: deviceHeaders).requestPost(url: "/queues", body: data);
    return result;
  }

  Future<List<dynamic>> getList({required ObjectType type, required List<String?>? list}) async {
    String params = list!.join(',');
    String add = type == ObjectType.playlist ? "/list" : "";
    String url = "/${type.name}s$add?${type.name}-ids=$params";
    var result = await RequestClient(headers: headers).requestGet(url);
    var jsonResult = jsonDecode(result);
    List<dynamic> mapResult = jsonResult["result"];

    switch (type) {
      case ObjectType.playlist:
        List<MPlaylist>? returnList = [];
        for (var playlist in mapResult) {
          returnList.add(MPlaylist.fromJson(playlist));
        }
        return returnList;
      case ObjectType.artist:
        List<Artist>? returnList = [];
        for (var artist in mapResult) {
          returnList.add(Artist.fromJson(artist));
        }
        return returnList;
      case ObjectType.album:
        List<Album>? returnList = [];
        for (var album in mapResult) {
          returnList.add(Album.fromJson(album));
        }
        return returnList;
      case ObjectType.track:
        List<Track?>? returnList = [];
        for (var track in mapResult) {
          returnList.add(Track.fromJson(track));
        }
        return returnList;
    }
  }

  Future<String> downloadTrack({required String? trackId, QualityTrack quality = QualityTrack.low}) async {
    var responseInfo = await RequestClient(headers: deviceHeaders).requestGet("/tracks/$trackId/download-info");
    if (!responseInfo.contains("error")) {
      var jsonResult = jsonDecode(responseInfo);
      var trackInfo = DownloadInfo.fromMap(jsonResult);

      int downloadIndex = 0;

      for (int i = 0; i < trackInfo.result!.length; i++) {
        if (trackInfo.result![i].bitrateInKbps == 320) {
          downloadIndex = i;
          break;
        } else {
          downloadIndex = i;
        }
      }

      var response = await http.get(Uri.parse(trackInfo.result![downloadIndex].downloadInfoUrl.toString()), headers: headers);
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

  Future<List<dynamic>?> getUserPlaylists() async {
    ///Получение списка плейлистов пользователя
    List<MPlaylist> returnList = [];
    var result = await RequestClient(headers: headers).requestGet("/users/$userId/playlists/list");
    List<dynamic> resultList = jsonDecode(result)["result"];
    for (var element in resultList) {
      returnList.add(MPlaylist.fromJson(element));
    }
    return returnList;
  }

  Future<TrackLyric> getTrackLyric(Track track) async {
    ///Получение текста песни
    var response = await http.get(Uri.parse("http://176.9.7.93:4000/lyrics/${track.id}"), headers: headers);
    if(response.body == '{"error":"400"}') {
      return TrackLyric();
    } else {
      return TrackLyric.fromJson(jsonDecode(response.body));
    }
  }

// Future<> name() async {
//   ///Получение полного списка всех новых релизов (альбомов)
//   var result = await RequestClient(headers: headers).requestGet("/landing3/new-playlists");
//   return .fromJson(jsonDecode(result)["result"]);
// }
}
