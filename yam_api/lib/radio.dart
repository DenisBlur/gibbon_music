import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:yam_api/radio/Session.dart';
import 'package:yam_api/track/track.dart';

import 'enums.dart';

class Radio {
  String baseUrl = "https://api.music.yandex.net";

  String batchId = "";
  String radioSessionId = "";

  Map<String, String> headers = {};
  String device = "";

  List<Track> sequence = [];

  void init(Map<String, String> headers, String device) {
    this.headers = headers;
    this.device = device;
  }

  Future<List<Track>> createRadioSession() async {
    DateTime times = DateTime.now();
    String timestamp = "${times.year}-${times.month}-${times.day}T${times.hour}:${times.minute}:${times.second}.${times.millisecond}-04:00";

    var createSession = await http.post(Uri.parse("$baseUrl/rotor/session/new"),
        headers: headers, body: '{"seeds": ["user:onyourwave"],"includeTracksInResponse": true}');
    Session session = Session.fromJson(jsonDecode(createSession.body));
    batchId = session.result!.batchId!;
    radioSessionId = session.result!.radioSessionId!;

    sequence = session.result!.sequence!;

    var radioStartFeedback = await http.post(Uri.parse("$baseUrl/rotor/session/$radioSessionId/feedback"),
        headers: headers,
        body: '{"event":{"type":"radioStarted","from":"radio-mobile-user-onyourwave-default","timestamp":"$timestamp"},"batchId":"$batchId"}');

    if (radioStartFeedback.statusCode == 200) {
      await sendRadioFeedback(RadioFeedback.trackStarted, sequence[0].id.toString(), 0);
      return sequence;
    }

    return [];
  }

  Future<void> sendRadioFeedback(RadioFeedback feedback, String trackId, double seconds) async {
    DateTime times = DateTime.now();
    String timestamp = "${times.year}-${times.month}-${times.day}T${times.hour}:${times.minute}:${times.second}.${times.millisecond}-04:00";

    String bodySkip =
        '{"event":{"type":"${feedback.name}","timestamp":"$timestamp","trackId":"$trackId", "totalPlayedSeconds": $seconds},"batchId":"$batchId"}';
    String bodyStart = '{"event":{"type":"${feedback.name}","timestamp":"$timestamp","trackId":"$trackId"},"batchId":"$batchId"}';

    var trackFeedback = await http.post(Uri.parse("$baseUrl/rotor/session/$radioSessionId/feedback"),
        headers: headers, body: feedback == RadioFeedback.trackStarted ? bodyStart : bodySkip);
  }

  Future<List<Track>> getRadioTracks() async {
    var radioTracks = await http.post(Uri.parse("$baseUrl/rotor/session/$radioSessionId/tracks"),
        headers: headers, body: '{"queue":[${sequence[0].id}]}');
    Session session = Session.fromJson(jsonDecode(radioTracks.body));
    sequence = session.result!.sequence!;
    return sequence;
  }

}
