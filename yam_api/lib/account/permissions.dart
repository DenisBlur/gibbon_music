class Permissions {
  Permissions({
    String? until,
    List<String>? values,
    List<String>? def,
  }) {
    _until = until;
    _values = values;
    _default = def;
  }

  Permissions.fromJson(dynamic json) {
    _until = json['until'];
    _values = json['values'] != null ? json['values'].cast<String>() : [];
    _default = json['default'] != null ? json['default'].cast<String>() : [];
  }

  String? _until;
  List<String>? _values;
  List<String>? _default;

  Permissions copyWith({
    String? until,
    List<String>? values,
    List<String>? def,
  }) =>
      Permissions(
        until: until ?? _until,
        values: values ?? _values,
        def: def ?? _default,
      );

  String? get until => _until;

  List<String>? get values => _values;

  List<String>? get def => _default;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['until'] = _until;
    map['values'] = _values;
    map['default'] = _default;
    return map;
  }
}
