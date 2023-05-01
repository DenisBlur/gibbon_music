import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:yam_api/track/track.dart';

class TrackSign {

  final String _signKey = 'p93jhgh689SBReK6ghtw62';

  Future<Sign> sign(Track track) async {

    var trackId = track.id!;
    var timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    var message = '$trackId$timestamp';
    var key = _signKey;
    var hmacSign = Hmac(sha256, utf8.encode(key)).convert(utf8.encode(message)).bytes;
    var signature = utf8.decode(base64.encode(hmacSign).codeUnits);

    Sign sign = Sign(signature, timestamp);

    return sign;
  }
}

class Sign {

  String signature;
  int timestamp;

  Sign(this.signature, this.timestamp);
}