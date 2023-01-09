class MChartPosition {
  MChartPosition({
      this.position, 
      this.progress, 
      this.listeners, 
      this.shift,});

  MChartPosition.fromJson(dynamic json) {
    position = json['position'];
    progress = json['progress'];
    listeners = json['listeners'];
    shift = json['shift'];
  }
  int position;
  String progress;
  int listeners;
  int shift;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['position'] = position;
    map['progress'] = progress;
    map['listeners'] = listeners;
    map['shift'] = shift;
    return map;
  }

}