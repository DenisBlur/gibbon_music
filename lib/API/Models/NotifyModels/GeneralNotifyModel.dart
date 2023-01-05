import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/API/Models/NewHomePage/MV_Track.dart';

class GeneralNotifyModel extends ChangeNotifier {
  bool _backArrow = false;
  MvTrack _mTrack;
  List<MvTrack> _mPlaylist = [];

  List<MvTrack> get mPlaylist => _mPlaylist;

  MvTrack get mTrack => _mTrack;

  bool get backArrow => _backArrow;

  set backArrow(bool value) {
    _backArrow = value;
    notifyListeners();
  }

  set mPlaylist(List<MvTrack> value) {
    _mPlaylist = value;
    notifyListeners();
  }

  set mTrack(MvTrack value) {
    _mTrack = value;
    notifyListeners();
  }
}
