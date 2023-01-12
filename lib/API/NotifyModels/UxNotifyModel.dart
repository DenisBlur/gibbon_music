import 'package:flutter/widgets.dart';
import 'package:gibbon_music/NewAPI/models/SearchModels/M_Search.dart';
import 'package:gibbon_music/NewAPI/models/SearchModels/M_SearchSuggest.dart';

class UxNotifyModel extends ChangeNotifier {

  bool _isOpenNavigationBar = false;
  bool _isOpenPlaylist = false;

  MSearchSuggest _mSearchSuggest;
  MSearch _mSearch;


  MSearch get mSearch => _mSearch;

  set mSearch(MSearch value) {
    _mSearch = value;
    notifyListeners();
  }

  MSearchSuggest get mSearchSuggest => _mSearchSuggest;

  set mSearchSuggest(MSearchSuggest value) {
    _mSearchSuggest = value;
    notifyListeners();
  }

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