import 'dart:convert';

import 'package:darq/darq.dart';
import 'package:flutter/foundation.dart';
import '../api/mainYamFunction.dart';
import '../api/models/LikesModels/M_LikeTracks.dart';
import 'package:yam_api/yam_api.dart';

class YandexProvider extends ChangeNotifier {
  MLikeTracks mLikeTracks = MLikeTracks();
  List<int> _likesTracks;

  List<int> get likesTracks => _likesTracks;

  set likesTracks(List<int> value) {
    _likesTracks = value;
    notifyListeners();
  }

  Future<void> init(String token) async {
    await initYamApi(token);
    await YamApi().getLikes(ActionType.track).then((result) {
      var jsonResult = jsonDecode(result);
      mLikeTracks = MLikeTracks.fromJson(jsonResult["result"]);
      likesTracks = mLikeTracks.library.tracks.select((element, _) => int.parse(element.id)).toList();
    });
  }

  Future<void> removeLike(dynamic id) async {
    await YamApi().removeLike(id, ActionType.track).then((value) {
      if (value) {
        likesTracks.remove(int.parse(id));
      } else {
        if (kDebugMode) {
          print("error");
        }
      }
    });
    notifyListeners();
  }

  Future<void> addLike(dynamic id) async {
    await YamApi().setLike(id, ActionType.track).then((value) {
      if (value) {
        _likesTracks.add(int.parse(id));
      } else {
        if (kDebugMode) {
          print("error");
        }
      }
    });
    notifyListeners();
  }

  bool checkLike(dynamic id) {
    if (_likesTracks.isNotEmpty && _likesTracks != null) {
      return _likesTracks.contains(int.parse(id));
    }
    return false;
  }
}
