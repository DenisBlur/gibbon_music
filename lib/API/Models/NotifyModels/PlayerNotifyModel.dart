import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/API/Models/NewHomePage/MV_Track.dart';

class PlayerNotifyModel extends ChangeNotifier {
  MvTrack _mTrack;
  List<MvTrack> _mPlaylist;


  List<MvTrack> get mPlaylist => _mPlaylist;
  MvTrack get mTrack => _mTrack;


  set mPlaylist(List<MvTrack> value) {
    _mPlaylist = value;
    notifyListeners();
  }
  set mTrack(MvTrack value) {
    _mTrack = value;
    notifyListeners();
  }
}
