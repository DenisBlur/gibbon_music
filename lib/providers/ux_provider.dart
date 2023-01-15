import 'package:fluent_ui/fluent_ui.dart';

class UxProvider extends ChangeNotifier {

  bool _isOpenDrawer = false;

  bool get isOpenDrawer => _isOpenDrawer;

  set isOpenDrawer(bool value) {
    _isOpenDrawer = value;
    notifyListeners();
  }

  changeDrawerState() {
    isOpenDrawer = !isOpenDrawer;
  }

}