import 'package:yam_api/playlist/playlist.dart';

import 'menu.dart';

class Chart {
  Chart({
      this.id,
      this.type,
      this.typeForFrom,
      this.title,
      this.chartDescription,
      this.menu,
      this.chart,});

  Chart.fromJson(dynamic json) {
    id = json['id'];
    type = json['type'];
    typeForFrom = json['typeForFrom'];
    title = json['title'];
    chartDescription = json['chartDescription'];
    menu = json['menu'] != null ? Menu.fromJson(json['menu']) : null;
    chart = json['chart'] != null ? MPlaylist.fromJson(json['chart']) : null;
  }
  String? id;
  String? type;
  String? typeForFrom;
  String? title;
  String? chartDescription;
  Menu? menu;
  MPlaylist? chart;
Chart copyWith({  String? id,
  String? type,
  String? typeForFrom,
  String? title,
  String? chartDescription,
  Menu? menu,
  MPlaylist? chart,
}) => Chart(  id: id ?? this.id,
  type: type ?? this.type,
  typeForFrom: typeForFrom ?? this.typeForFrom,
  title: title ?? this.title,
  chartDescription: chartDescription ?? this.chartDescription,
  menu: menu ?? this.menu,
  chart: chart ?? this.chart,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['type'] = type;
    map['typeForFrom'] = typeForFrom;
    map['title'] = title;
    map['chartDescription'] = chartDescription;
    if (menu != null) {
      map['menu'] = menu?.toJson();
    }
    if (chart != null) {
      map['chart'] = chart?.toJson();
    }
    return map;
  }

}
