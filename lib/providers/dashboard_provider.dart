import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/api/mainYamFunction.dart';
import 'package:gibbon_music/api/models/PageModels/M_PageDashboard.dart';

class DashboardProvider extends ChangeNotifier {
  DashboardProvider();

  Future<void> init() async {

    initYamApi("AQAAAAAV_ACCAAG8XkFW219h4UiInu2aEV4ZGL4");
    mPageDashboard  = await getPageDashboard(["play_contexts", "chart", "promotions", "mixes"]);

  }

  MPageDashboard _mPageDashboard;

  MPageDashboard get mPageDashboard {
    return _mPageDashboard;
  }

  set mPageDashboard(MPageDashboard value) {
    _mPageDashboard = value;
    notifyListeners();
  }
}
