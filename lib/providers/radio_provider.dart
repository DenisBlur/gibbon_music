import 'dart:async';

import 'package:yam_api/track/track.dart';

class RadioProvider {

  bool isRadioPlaying = false;
  String batchId = "";
  String station = "";

  List<Track?> radioTracks = [];

  initRadioModule() {}

  Future startRadio(station) async {
    isRadioPlaying = true;
    this.station = station;
  }


  checkSize() {}
}
