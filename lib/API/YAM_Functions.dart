import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:gibbon_telegram/API/Models/HomePage/M_Chart.dart';
import 'package:gibbon_telegram/API/Models/NewHomePage/MV_HomePage.dart';
import 'package:gibbon_telegram/API/Models/NewHomePage/MV_Promotion.dart';

import 'Models/HomePage/M_HomePage.dart';
import 'Models/HomePage/M_Promotion.dart';
import 'Models/HomePage/M_PlayContext.dart';

// ignore: depend_on_referenced_packages
import 'package:yam_api/yam_api.dart';

import 'Models/NewHomePage/MV_PlayContext.dart';

void initYamApi(String token) {
  YamApi.init(token);
}

Future<MVHomePage> getYamApiHomePage(List<String> params) async {
  String result = await YamApi.promotions(params);

  var jsonResult = jsonDecode(result);
  List<dynamic> mp = jsonResult["result"]["blocks"];
  List<MvPromotion> promList = [];
  List<MvPlayContext> playContextList = [];

  for (int i = 0; i < mp.length; i++) {
    if (jsonResult["result"]["blocks"][i]["type"] == "play-contexts") {
      List<dynamic> list = jsonResult["result"]["blocks"][i]["entities"];
      for (int p = 0; p < list.length; p++) {
        var playContext = jsonResult["result"]["blocks"][i]["entities"][p];
        var payloadContext = playContext["data"]["payload"];

        MvPlayContext mvPlayContext = MvPlayContext();
        mvPlayContext.id = playContext["id"];
        mvPlayContext.type = playContext["type"];

        mvPlayContext.client = playContext["data"]["client"];
        mvPlayContext.context = playContext["data"]["context"];
        mvPlayContext.contextItem = playContext["data"]["contextItem"];

        mvPlayContext.payloadId = mvPlayContext.context == "playlist"
            ? payloadContext["uid"].toString()
            : payloadContext["id"].toString();

        mvPlayContext.title = mvPlayContext.context == "artist"
            ? payloadContext["name"].toString()
            : payloadContext["title"].toString();

        mvPlayContext.coverUri = mvPlayContext.context == "album"
            ? payloadContext["coverUri"].toString()
            : payloadContext["cover"]["uri"].toString();

        mvPlayContext.kind = mvPlayContext.context == "playlist"
            ? payloadContext["kind"].toString()
            : "not_playlist";

        mvPlayContext.counts = mvPlayContext.context == "artist"
            ? payloadContext["counts"]["tracks"].toString()
            : payloadContext["trackCount"].toString();

        mvPlayContext.description = payloadContext["description"].toString();

        mvPlayContext.likesCount = payloadContext["likesCount"].toString();
        mvPlayContext.year = payloadContext["year"].toString();

        if (payloadContext["artists"] != null) {
          List<dynamic> artists = payloadContext["artists"];
          if (artists.isNotEmpty) {
            for (var object in artists) {
              MvArtist artist = MvArtist();
              artist.id = object["id"].toString();
              artist.name = object["name"].toString();
              artist.cover = object["cover"]["uri"].toString();
              mvPlayContext.artists.add(artist);
            }
          }
        }

        print(mvPlayContext.description);
        playContextList.add(mvPlayContext);
      }
    }
    if (jsonResult["result"]["blocks"][i]["type"] == "promotions") {
      List<dynamic> list = jsonResult["result"]["blocks"][i]["entities"];
      for (int p = 0; p < list.length; p++) {
        promList.add(MvPromotion.fromJson(
            jsonResult["result"]["blocks"][i]["entities"][p]));
      }
    }
    if (jsonResult["result"]["blocks"][i]["type"] == "chart") {}
  }

  MVHomePage homePage = MVHomePage();
  homePage.listMVPromotion = promList;
  homePage.listMVPlayContext = playContextList;

  return homePage;
}
