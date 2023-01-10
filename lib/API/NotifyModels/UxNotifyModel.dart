import 'package:flutter/widgets.dart';

class UxNotifyModel extends ChangeNotifier {

  bool _isOpenNavigationBar = false;
  bool _isOpenPlaylist = false;


  bool get isOpenPlaylist => _isOpenPlaylist;
  bool get isOpenNavigationBar => _isOpenNavigationBar;

  set isOpenPlaylist(bool value) {
    _isOpenPlaylist = value;
    notifyListeners();
  }

  set isOpenNavigationBar(bool value) {
    _isOpenNavigationBar = value;
    notifyListeners();
  }

  changeNavigationBarState() {
    isOpenNavigationBar = !isOpenNavigationBar;
  }
  changePlaylistState() {
    isOpenPlaylist = !isOpenPlaylist;
  }

}