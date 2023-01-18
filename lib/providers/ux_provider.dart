import 'package:fluent_ui/fluent_ui.dart';

class UxProvider extends ChangeNotifier {

  bool _isOpenDrawer = false;

  double _playerVolume = 1.0;

  double get playerVolume => _playerVolume;

  bool get isOpenDrawer => _isOpenDrawer;

  set playerVolume(double value) {
    _playerVolume = value;
    notifyListeners();
  }

  set isOpenDrawer(bool value) {
    _isOpenDrawer = value;
    notifyListeners();
  }

  changeDrawerState() {
    isOpenDrawer = !isOpenDrawer;
  }

}