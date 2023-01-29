import 'dart:async';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:yam_api/track/track.dart';

class UxProvider extends ChangeNotifier {
  bool _isOpenDrawer = false;
  bool _isOpenPlaylist = false;
  bool _isContextMenu = false;
  Offset _contextMenuOffset = Offset(0, 0);
  double _playerVolume = 1.0;
  String _currentPlaylist = "";
  String currentAlbum = "";
  String currentArtist = "";
  StreamController<TrackContextDetail> onChangeDetails = StreamController.broadcast();

  Offset get contextMenuOffset => _contextMenuOffset;

  set contextMenuOffset(Offset value) {
    _contextMenuOffset = value;
    notifyListeners();
  }

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

  showToast(BuildContext context) async {
    OverlayState? overlayState = Overlay.of(context);
    OverlayEntry overlayEntry = OverlayEntry(
      opaque: false,
      maintainState: true,
      builder: (context) {
        Future.delayed(Duration(seconds: 2)).then((value) {
          overlayState?.dispose();
        });
        return Positioned(left: 0, bottom: 0, right: 0, child: Text("HELLLOOOOO!!!!!!"));
      },
    );
    overlayState?.insert(overlayEntry);
  }

}

class TrackContextDetail {

  TapUpDetails details;
  Track track;

  TrackContextDetail({required this.details, required this.track});
}
