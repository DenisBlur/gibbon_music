import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/api/mainYamFunction.dart';
import 'package:gibbon_music/api/models/PageModels/M_PageDashboard.dart';
import 'package:yam_api/yam_api.dart';

class DashboardProvider {
  DashboardProvider();

  MPageDashboard _mPageDashboard;

  MPageDashboard get mPageDashboard => _mPageDashboard;

  set mPageDashboard(MPageDashboard value) {
    _mPageDashboard = value;
  }

  Future<void> init() async {
    mPageDashboard ??= await getPageDashboard(["play_contexts", "chart", "promotions", "mixes"]);
  }

  Future<void> dispose() async {
    mPageDashboard = null;
  }
}
