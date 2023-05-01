import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'models/error_model.dart';

class RequestClient {
  Map<String, String> headers;

  RequestClient({required this.headers});

  String baseUrl = "https://api.music.yandex.net";

  String _checkResponse(http.Response response) {
    if (response.statusCode == 200) {
      return response.body;
    } else {
      ErrorModel errorModel = ErrorModel(error: ErrorResult(result: response.body, statusCode: response.statusCode));
      if (kDebugMode) {
        print("Status Code: ${errorModel.error?.statusCode}");
        print(errorModel.toJson().toString());
      }
      return errorModel.toJson().toString();
    }
  }

  Future<String> requestGet(String url) async {
    var response = await http.get(Uri.parse("$baseUrl$url"), headers: headers);
    return _checkResponse(response);
  }

  Future<String> requestPost({required String url, required Map<String, dynamic> body}) async {
    if (kDebugMode) {
      print(jsonEncode(body));
    }
    var response = await http.post(Uri.parse("$baseUrl$url"), headers: headers, body: jsonEncode(body));
    return _checkResponse(response);
  }
}
