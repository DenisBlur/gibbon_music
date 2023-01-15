class ErrorModel {
  ErrorModel({
    ErrorResult? error,
  }) {
    _error = error;
  }

  ErrorModel.fromJson(dynamic json) {
    _error = json['error'] != null ? ErrorResult.fromJson(json['error']) : null;
  }

  ErrorResult? _error;

  ErrorModel copyWith({
    ErrorResult? error,
  }) =>
      ErrorModel(
        error: error ?? _error,
      );

  ErrorResult? get error => _error;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_error != null) {
      map['error'] = _error?.toJson();
    }
    return map;
  }
}

class ErrorResult {
  ErrorResult({
    num? statusCode,
    String? result,
  }) {
    _statusCode = statusCode;
    _result = result;
  }

  ErrorResult.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    _result = json['result'];
  }

  num? _statusCode;
  String? _result;

  ErrorResult copyWith({
    num? statusCode,
    String? result,
  }) =>
      ErrorResult(
        statusCode: statusCode ?? _statusCode,
        result: result ?? _result,
      );

  num? get statusCode => _statusCode;

  String? get result => _result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusCode'] = _statusCode;
    map['result'] = _result;
    return map;
  }
}
