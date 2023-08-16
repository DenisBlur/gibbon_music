import 'package:fluent_ui/fluent_ui.dart';
import 'package:yam_api/track/track.dart';

import '../constants/app_consts.dart';
import '../domain/models/data_model.dart';

class UxProvider extends ChangeNotifier {

  UxProvider() {
    init();
  }

  init() async {
    DataModel dataModel = DataModel();
    bool? hasSmoothScroll = await dataModel.findKey(AppConsts.smoothScrollKey);
    if(hasSmoothScroll!) {
      smoothScroll = (await dataModel.readBoolData(AppConsts.smoothScrollKey))!;
    }
  }

  bool _isOpenPlaylist = false;
  bool _isFullscreen = false;
  bool _smoothScroll = false;
  bool _orientationLandscape = false;
  double _playerVolume = 1.0;
  String _currentPlaylist = "";
  String currentAlbum = "";
  String currentArtist = "";


  bool get orientationLandscape => _orientationLandscape;

  bool get smoothScroll => _smoothScroll;

  String get currentPlaylist => _currentPlaylist;

  double get playerVolume => _playerVolume;

  bool get isOpenPlaylist => _isOpenPlaylist;

  bool get isFullscreen => _isFullscreen;

  set orientationLandscape(bool value) {
    _orientationLandscape = value;
    notifyListeners();
  }

  set isFullscreen(bool value) {
    _isFullscreen = value;
    notifyListeners();
  }

  set playerVolume(double value) {
    _playerVolume = value;
    notifyListeners();
  }

  set isOpenPlaylist(bool value) {
    _isOpenPlaylist = value;
    notifyListeners();
  }

  set currentPlaylist(String value) {
    _currentPlaylist = value;
    notifyListeners();
  }

  set smoothScroll(bool value) {
    _smoothScroll = value;
    notifyListeners();
  }

  changePlaylistState() {
    isOpenPlaylist = !isOpenPlaylist;
  }

  changeSmoothScrollState() {
    smoothScroll = !smoothScroll;
    notifyListeners();
  }

}

class TrackContextDetail {

  TapUpDetails details;
  Track track;

  TrackContextDetail({required this.details, required this.track});
}
