class PermissionAlerts {
  PermissionAlerts({
    List<String>? alerts,
  }) {
    _alerts = alerts;
  }

  PermissionAlerts.fromJson(dynamic json) {
    if (json['alerts'] != null) {
      _alerts = [];
      json['alerts'].forEach((v) {
        _alerts?.add(v);
      });
    }
  }

  List<String>? _alerts;

  PermissionAlerts copyWith({
    List<String>? alerts,
  }) =>
      PermissionAlerts(
        alerts: alerts ?? _alerts,
      );

  List<String>? get alerts => _alerts;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_alerts != null) {
      map['alerts'] = _alerts?.map((v) => v).toList();
    }
    return map;
  }
}
