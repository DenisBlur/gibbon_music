import 'package:yam_api/rotor/main_station.dart';

class ListStations {
  ListStations({
    this.result,
  });

  ListStations.fromJson(dynamic json) {
    if (json['result'] != null) {
      result = [];
      json['result'].forEach((v) {
        result?.add(MainStation.fromJson(v));
      });
    }
  }

  List<MainStation>? result;

  ListStations copyWith({
    List<MainStation>? result,
  }) =>
      ListStations(
        result: result ?? this.result,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (result != null) {
      map['result'] = result?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
