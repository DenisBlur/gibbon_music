import 'dart:convert';

import 'package:async/async.dart';
import 'package:darq/darq.dart';
import 'package:gibbon_music/api/models/CombineModel/M_CombineChartTrack.dart';
import 'package:gibbon_music/api/models/M_Block.dart';
import 'package:gibbon_music/api/models/M_Entities.dart';
import 'package:gibbon_music/api/models/M_Promotion.dart';
import 'package:gibbon_music/api/models/M_Track.dart';
import 'package:gibbon_music/api/models/PageModels/M_PageAlbum.dart';
import 'package:gibbon_music/api/models/PageModels/M_PageArtist.dart';
import 'package:gibbon_music/api/models/PageModels/M_PageDashboard.dart';
import 'package:gibbon_music/api/models/PageModels/M_PagePlaylist.dart';
import 'package:gibbon_music/api/models/QueueModel/M_Queue.dart';
import 'package:gibbon_music/api/models/QueueModel/M_Queues.dart';
import 'package:gibbon_music/api/models/SearchModels/M_SearchSuggest.dart';

// ignore: depend_on_referenced_packages
import 'package:yam_api/yam_api.dart';

import 'models/LikesModels/M_LikeTracks.dart';
import 'models/SearchModels/M_Search.dart';

Future<void> initYamApi(String token) async {
  await YamApi().init(token);
}

Future<MSearch> getSearchResult(String text) async {
  String result = "";
  CancelableOperation<String> getTrackOperationAsync;
  getTrackOperationAsync?.cancel();
  getTrackOperationAsync = CancelableOperation.fromFuture(YamApi().getSearch(text));
  getTrackOperationAsync.then((value) {
    if (getTrackOperationAsync.isCanceled) {
      return null;
    } else {
      result = value;
      var jsonResult = jsonDecode(result);
      MSearch mSearch = MSearch.fromJson(jsonResult["result"]);
      // uxNotifyModel.mSearch = mSearch;
      return mSearch;
    }
  });
  return null;
}

Future<MSearchSuggest> getSearchSuggest(String text) async {
  String result = "";
  CancelableOperation<String> getTrackOperationAsync;
  getTrackOperationAsync?.cancel();
  getTrackOperationAsync = CancelableOperation.fromFuture(YamApi().getSearchSuggest(text));
  getTrackOperationAsync.then((value) {
    if (getTrackOperationAsync.isCanceled) {
      return null;
    } else {
      result = value;
      var jsonResult = jsonDecode(result);
      MSearchSuggest mSearchSuggest = MSearchSuggest.fromJson(jsonResult["result"]);
      // uxNotifyModel.mSearchSuggest = mSearchSuggest;
      return mSearchSuggest;
    }
  });
  return null;
}

Future<List<dynamic>> syncDevices() async {
  String resultQueues = await YamApi().getQueues();
  var jsonResultQueues = jsonDecode(resultQueues);
  MQueues mQueues = MQueues.fromJson(jsonResultQueues["result"]);

  String resultQueue = await YamApi().getQueue(mQueues.queues[0].id);
  var jsonResultQueue = jsonDecode(resultQueue);
  MQueue mQueue = MQueue.fromJson(jsonResultQueue["result"]);

  String resultTrack = await YamApi().getTrack(mQueue.tracks[mQueue.currentIndex].trackId);
  var jsonResultTrack = jsonDecode(resultTrack);
  MTrack mTrack = MTrack.fromJson(jsonResultTrack["result"][0]);

  List<MTrack> mTrackLists = [];

  if (mQueue.initialContext?.type != null) {
    if (mQueue.initialContext.type == "playlist") {
      var splitDate = mQueue.initialContext.id.split(":");
      MPagePlaylist mPagePlaylist = await getPlaylist(splitDate[0], splitDate[1]);
      mTrackLists = mPagePlaylist.tracks
          .select(
            (e, index) => e.track,
          )
          .toList();
    } else if (mQueue.initialContext.type == "album") {
      int id = int.parse(mQueue.initialContext.id);
      MPageAlbum mPageAlbum = await getAlbum(id);
      mTrackLists = mPageAlbum.volumes;
    }
  } else {
    mTrackLists.add(mTrack);
  }

  List<dynamic> returnList = [mTrack, mTrackLists];

  return returnList;
}

Future<MPagePlaylist> getPlaylist(String uid, String kind) async {
  String result = await YamApi().getPlaylist(uid, kind);
  var jsonResult = jsonDecode(result);
  MPagePlaylist mPagePlaylist = MPagePlaylist.fromJson(jsonResult["result"]);
  return mPagePlaylist;
}

Future<MPageAlbum> getAlbum(int albumId) async {
  String result = await YamApi().getAlbum(albumId);
  var jsonResult = jsonDecode(result);
  MPageAlbum mPageAlbum = MPageAlbum.fromJson(jsonResult["result"]);
  return mPageAlbum;
}

Future<MPageArtist> getArtist(int id) async {
  String result = await YamApi().getArtist(id);
  var jsonResult = jsonDecode(result);
  MPageArtist mPageArtist = MPageArtist.fromJson(jsonResult["result"]);
  return mPageArtist;
}

Future<MPageDashboard> getPageDashboard(List<String> params) async {
  String result = await YamApi().promotions(params);
  var jsonResult = jsonDecode(result);

  MPageDashboard mPageHome = MPageDashboard();

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
