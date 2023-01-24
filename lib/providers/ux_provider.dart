import 'dart:async';

import 'package:fluent_ui/fluent_ui.dart';

class UxProvider extends ChangeNotifier {
  bool _isOpenDrawer = false;
  bool _isOpenPlaylist = false;
  bool _isContextMenu = false;
  double _playerVolume = 1.0;
  String _currentPlaylist = "";
  String currentAlbum = "";
  String currentArtist = "";

  StreamController<TapUpDetails> onChangeDetails = StreamController.broadcast();

  String get currentPlaylist => _currentPlaylist;

  double get playerVolume => _playerVolume;

  bool get isOpenDrawer => _isOpenDrawer;

  bool get isOpenPlaylist => _isOpenPlaylist;

  bool get isContextMenu => _isContextMenu;

  set isContextMenu(bool value) {
    _isContextMenu = value;
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

  set isOpenDrawer(bool value) {
    _isOpenDrawer = value;
    notifyListeners();
  }

  set currentPlaylist(String value) {
    _currentPlaylist = value;
    notifyListeners();
  }

  changeDrawerState() {
    isOpenDrawer = !isOpenDrawer;
  }

  changePlaylistState() {
    isOpenPlaylist = !isOpenPlaylist;
  }

}
