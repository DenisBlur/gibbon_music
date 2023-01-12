import 'dart:convert';

import 'package:async/async.dart';
import 'package:gibbon_music/NewAPI/models/CombineModel/M_CombineChartTrack.dart';
import 'package:gibbon_music/NewAPI/models/M_Block.dart';
import 'package:gibbon_music/NewAPI/models/M_Entities.dart';
import 'package:gibbon_music/NewAPI/models/M_Promotion.dart';
import 'package:gibbon_music/NewAPI/models/PageModels/M_PageAlbum.dart';
import 'package:gibbon_music/NewAPI/models/PageModels/M_PageArtist.dart';
import 'package:gibbon_music/NewAPI/models/PageModels/M_PageHome.dart';
import 'package:gibbon_music/NewAPI/models/PageModels/M_PagePlaylist.dart';
import 'package:gibbon_music/NewAPI/models/SearchModels/M_SearchSuggest.dart';

// ignore: depend_on_referenced_packages
import 'package:yam_api/yam_api.dart';

import '../main.dart';
import 'models/SearchModels/M_Search.dart';

void initYamApi(String token) {
  YamApi.init(token);
}

Future<MSearch> getSearchResult(String text) async {
  String result = "";
  CancelableOperation<String> getTrackOperationAsync;
  getTrackOperationAsync?.cancel();
  getTrackOperationAsync = CancelableOperation.fromFuture(YamApi.getSearch(text));
  getTrackOperationAsync.then((value) {
    if(getTrackOperationAsync.isCanceled) {
      return null;
    } else {
      result = value;
      var jsonResult = jsonDecode(result);
      MSearch mSearch = MSearch.fromJson(jsonResult["result"]);
      uxNotifyModel.mSearch = mSearch;
      return mSearch;
    }
  });
  return null;
}

Future<MSearchSuggest> getSearchSuggest(String text) async {
  String result = "";
  CancelableOperation<String> getTrackOperationAsync;
  getTrackOperationAsync?.cancel();
  getTrackOperationAsync = CancelableOperation.fromFuture(YamApi.getSearchSuggest(text));
  getTrackOperationAsync.then((value) {
    if(getTrackOperationAsync.isCanceled) {
      return null;
    } else {
      result = value;
      var jsonResult = jsonDecode(result);
      MSearchSuggest mSearchSuggest = MSearchSuggest.fromJson(jsonResult["result"]);
      uxNotifyModel.mSearchSuggest = mSearchSuggest;
      return mSearchSuggest;
    }
  });
  return null;
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
