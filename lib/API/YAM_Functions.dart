import 'dart:convert';

import 'package:gibbon_music/API/Models/NewHomePage/MV_HomePage.dart';
import 'package:gibbon_music/API/Models/NewHomePage/MV_Promotion.dart';
import 'package:gibbon_music/API/Models/NewHomePage/MV_Track.dart';
// ignore: depend_on_referenced_packages
import 'package:yam_api/yam_api.dart';

import 'Models/ArtistPage/MV_ArtistPage.dart';
import 'Models/NewHomePage/MV_PlayContext.dart';

void initYamApi(String token) {
  YamApi.init(token);
}

Future<MvArtistPage> getYamApiArtist(int id) async {
  String result = await YamApi.getArtist(id);
  var jsonResult = jsonDecode(result);
  MvArtistPage artistPage = MvArtistPage.fromJson(jsonResult["result"]);
  return artistPage;
}

Future<MVHomePage> getYamApiHomePage(List<String> params) async {
  String result = await YamApi.promotions(params);
  var jsonResult = jsonDecode(result);
  List<dynamic> mp = jsonResult["result"]["blocks"];
  List<MvPromotion> promList = [];
  List<MvPlayContext> playContextList = [];
  List<MvTrack> chartList = [];

  for (int i = 0; i < mp.length; i++) {
    if (jsonResult["result"]["blocks"][i]["type"] == "play-contexts") {
      List<dynamic> list = jsonResult["result"]["blocks"][i]["entities"];
      for (int p = 0; p < list.length; p++) {
        var playContext = jsonResult["result"]["blocks"][i]["entities"][p];
        // MvPlayContext mvPlayContext = MvPlayContext.fromJson(payloadContext);
        print(playContext["data"]["context"]);
        // playContextList.add(mvPlayContext);
      }
    }
    if (jsonResult["result"]["blocks"][i]["type"] == "promotions") {
      List<dynamic> list = jsonResult["result"]["blocks"][i]["entities"];
      for (int p = 0; p < list.length; p++) {
        promList.add(MvPromotion.fromJson(
            jsonResult["result"]["blocks"][i]["entities"][p]));
      }
    }
    if (jsonResult["result"]["blocks"][i]["type"] == "chart") {
      List<dynamic> list = jsonResult["result"]["blocks"][i]["entities"];
      for (int p = 0; p < list.length; p++) {
        MvTrack track = MvTrack.fromJson(list[p]["data"]);
        chartList.add(track);
      }
    }
  }

  MVHomePage homePage = MVHomePage();
  homePage.listMVPromotion = promList;
  homePage.listMVPlayContext = playContextList;
  homePage.listMVTrack = chartList;

  return homePage;
}
