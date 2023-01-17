import 'package:yam_api/rotor/station_data.dart';

import 'setting.dart';
import 'station.dart';
import 'ad_params.dart';

class MainStation {
  MainStation({
    this.station,
    this.data,
    this.settings,
    this.settings2,
    this.adParams,
    this.explanation,
    this.rupTitle,
    this.rupDescription,
  });

  MainStation.fromJson(dynamic json) {
    station = json['station'] != null ? Station.fromJson(json['station']) : null;
    data = json['data'] != null ? StationData.fromJson(json['data']) : null;
    settings = json['settings'] != null ? Settings.fromJson(json['settings']) : null;
    settings2 = json['settings2'] != null ? Settings2.fromJson(json['settings2']) : null;
    adParams = json['adParams'] != null ? AdParams.fromJson(json['adParams']) : null;
    explanation = json['explanation'];
    rupTitle = json['rupTitle'];
    rupDescription = json['rupDescription'];
  }

  Station? station;
  StationData? data;
  Settings? settings;
  Settings2? settings2;
  AdParams? adParams;
  String? explanation;
  String? rupTitle;
  String? rupDescription;

  MainStation copyWith({
    Station? station,
    StationData? data,
    Settings? settings,
    Settings2? settings2,
    AdParams? adParams,
    String? explanation,
    String? rupTitle,
    String? rupDescription,
  }) =>
      MainStation(
        station: station ?? this.station,
        data: data ?? this.data,
        settings: settings ?? this.settings,
        settings2: settings2 ?? this.settings2,
        adParams: adParams ?? this.adParams,
        explanation: explanation ?? this.explanation,
        rupTitle: rupTitle ?? this.rupTitle,
        rupDescription: rupDescription ?? this.rupDescription,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (station != null) {
      map['station'] = station?.toJson();
    }
    if (data != null) {
      map['station'] = data?.toJson();
    }
    if (settings != null) {
      map['settings'] = settings?.toJson();
    }
    if (settings2 != null) {
      map['settings2'] = settings2?.toJson();
    }
    if (adParams != null) {
      map['adParams'] = adParams?.toJson();
    }
    map['explanation'] = explanation;
    map['rupTitle'] = rupTitle;
    map['rupDescription'] = rupDescription;
    return map;
  }
}
