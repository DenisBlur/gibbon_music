import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:yam_api/track/track.dart';

class TrackSign {

  final String _signKey = 'p93jhgh689SBReK6ghtw62';

  Future<Sign> sign(Track track) async {


    var trackId = int.parse(track.id!);

    int timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    String message = '${trackId}${timestamp}';

    List<int> keyBytes = utf8.encode(_signKey);
    List<int> msgBytes = utf8.encode(message);

    List<int> hmacSign = Hmac(sha256, keyBytes).convert(msgBytes).bytes;
    String signature = base64Encode(hmacSign);

    print(signature);

    return Sign(signature, timestamp);
  }
}

class Sign {

  String signature;
  int timestamp;

  Sign(this.signature, this.timestamp);
}