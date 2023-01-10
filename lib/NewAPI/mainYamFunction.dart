import 'dart:convert';

import 'package:gibbon_music/NewAPI/models/CombineModel/M_CombineChartTrack.dart';
import 'package:gibbon_music/NewAPI/models/M_Block.dart';
import 'package:gibbon_music/NewAPI/models/M_Entities.dart';
import 'package:gibbon_music/NewAPI/models/M_Promotion.dart';
import 'package:gibbon_music/NewAPI/models/PageModels/M_PageAlbum.dart';
import 'package:gibbon_music/NewAPI/models/PageModels/M_PageArtist.dart';
import 'package:gibbon_music/NewAPI/models/PageModels/M_PageHome.dart';
import 'package:gibbon_music/NewAPI/models/PageModels/M_PagePlaylist.dart';
// ignore: depend_on_referenced_packages
import 'package:yam_api/yam_api.dart';

void initYamApi(String token) {
  YamApi.init(token);
}

Future<MPagePlaylist> getPlaylist(String uid, int kind) async {
  String result = await YamApi.getPlaylist(uid, kind);
  var jsonResult = jsonDecode(result);
  MPagePlaylist mPagePlaylist = MPagePlaylist.fromJson(jsonResult["result"]);
  return mPagePlaylist;
}

Future<MPageAlbum> getAlbum(int albumId) async {
  String result = await YamApi.getAlbum(albumId);
  var jsonResult = jsonDecode(result);
  MPageAlbum mPageAlbum = MPageAlbum.fromJson(jsonResult["result"]);
  return mPageAlbum;
}

Future<MPageArtist> getArtist(int id) async {
  String result = await YamApi.getArtist(id);
  var jsonResult = jsonDecode(result);
  MPageArtist mPageArtist = MPageArtist.fromJson(jsonResult["result"]);
  return mPageArtist;
}

Future<MPageHome> getHomePage(List<String> params) async {
  String result = await YamApi.promotions(params);
  var jsonResult = jsonDecode(result);

  MPageHome mPageHome = MPageHome();

  List<MPromotion> promotionList = [];
  List<MCombineChartTrack> combineChartTrackList = [];
  List<MEntities> playContextList = [];

  MBlock promotionBlock = MBlock.fromJson(jsonResult["result"]["blocks"][0]);
  MBlock chartBlock = MBlock.fromJson(jsonResult["result"]["blocks"][1]);
  MBlock playContextBlock = MBlock.fromJson(jsonResult["result"]["blocks"][2]);

  for (var element in promotionBlock.entities) {
    promotionList.add(MPromotion.fromJson(element.data));
  }

  for (var element in chartBlock.entities) {
    combineChartTrackList.add(MCombineChartTrack.fromJson(element.data));
  }

  for (var element in playContextBlock.entities) {
    playContextList.add(element);
  }

  mPageHome.promotionList = promotionList;
  mPageHome.chartList = combineChartTrackList;
  mPageHome.playContextList = playContextList;

  return mPageHome;

}
