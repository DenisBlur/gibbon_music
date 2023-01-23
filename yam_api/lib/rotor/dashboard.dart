import 'package:yam_api/rotor/main_station.dart';

class Dashboard {
  Dashboard({
    this.dashboardId,
    this.stations,
    this.pumpkin,
  });

  Dashboard.fromJson(dynamic json) {
    dashboardId = json['dashboardId'];
    if (json['stations'] != null) {
      stations = [];
      json['stations'].forEach((v) {
        stations?.add(MainStation.fromJson(v));
      });
    }
    pumpkin = json['pumpkin'];
  }

  String? dashboardId;
  List<MainStation>? stations;
  bool? pumpkin;

  Dashboard copyWith({
    String? dashboardId,
    List<MainStation>? stations,
    bool? pumpkin,
  }) =>
      Dashboard(
        dashboardId: dashboardId ?? this.dashboardId,
        stations: stations ?? this.stations,
        pumpkin: pumpkin ?? this.pumpkin,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['dashboardId'] = dashboardId;
    if (stations != null) {
      map['stations'] = stations?.map((v) => v.toJson()).toList();
    }
    map['pumpkin'] = pumpkin;
    return map;
  }
}
