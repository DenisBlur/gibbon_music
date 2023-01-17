import 'package:flutter/foundation.dart';

class YandexProvider extends ChangeNotifier {
  // MLikeTracks mLikeTracks = MLikeTracks();
  // List<int> _likesTracks;
  //
  // List<int> get likesTracks => _likesTracks;
  //
  // set likesTracks(List<int> value) {
  //   _likesTracks = value;
  //   notifyListeners();
  // }
  //
  // Future<void> init(String token) async {
  //
  // }
  //
  // Future<void> removeLike(dynamic id) async {
  //   await YamApi().removeLike(id, ActionType.track).then((value) {
  //     if (value) {
  //       likesTracks.remove(int.parse(id));
  //     } else {
  //       if (kDebugMode) {
  //         print("error");
  //       }
  //     }
  //   });
  //   notifyListeners();
  // }
  //
  // Future<void> addLike(dynamic id) async {
  //   await YamApi().setLike(id, ActionType.track).then((value) {
  //     if (value) {
  //       _likesTracks.add(int.parse(id));
  //     } else {
  //       if (kDebugMode) {
  //         print("error");
  //       }
  //     }
  //   });
  //   notifyListeners();
  // }
  //
  // bool checkLike(dynamic id) {
  //   if (_likesTracks.isNotEmpty && _likesTracks != null) {
  //     return _likesTracks.contains(int.parse(id));
  //   }
  //   return false;
  // }
}
