import 'package:yam_api/track/track.dart';

class Session {
  Session({
      this.invocationInfo, 
      this.result,});

  Session.fromJson(dynamic json) {
    invocationInfo = json['invocationInfo'] != null ? InvocationInfo.fromJson(json['invocationInfo']) : null;
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }
  InvocationInfo? invocationInfo;
  Result? result;
Session copyWith({  InvocationInfo? invocationInfo,
  Result? result,
}) => Session(  invocationInfo: invocationInfo ?? this.invocationInfo,
  result: result ?? this.result,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (invocationInfo != null) {
      map['invocationInfo'] = invocationInfo?.toJson();
    }
    if (result != null) {
      map['result'] = result?.toJson();
    }
    return map;
  }

}

class Result {
  Result({
      this.radioSessionId, 
      this.sequence, 
      this.batchId, 
      this.pumpkin, 
      this.descriptionSeed, 
      this.acceptedSeeds,});

  Result.fromJson(dynamic json) {
    radioSessionId = json['radioSessionId'];
    if (json['sequence'] != null) {
      sequence = [];
      json['sequence'].forEach((v) {
        sequence?.add(Track.fromJson(v["track"]));
      });
    }
    batchId = json['batchId'];
    pumpkin = json['pumpkin'];
    descriptionSeed = json['descriptionSeed'] != null ? DescriptionSeed.fromJson(json['descriptionSeed']) : null;
    if (json['acceptedSeeds'] != null) {
      acceptedSeeds = [];
      json['acceptedSeeds'].forEach((v) {
        acceptedSeeds?.add(AcceptedSeeds.fromJson(v));
      });
    }
  }
  String? radioSessionId;
  List<Track>? sequence;
  String? batchId;
  bool? pumpkin;
  DescriptionSeed? descriptionSeed;
  List<AcceptedSeeds>? acceptedSeeds;
Result copyWith({  String? radioSessionId,
  List<Track>? sequence,
  String? batchId,
  bool? pumpkin,
  DescriptionSeed? descriptionSeed,
  List<AcceptedSeeds>? acceptedSeeds,
}) => Result(  radioSessionId: radioSessionId ?? this.radioSessionId,
  sequence: sequence ?? this.sequence,
  batchId: batchId ?? this.batchId,
  pumpkin: pumpkin ?? this.pumpkin,
  descriptionSeed: descriptionSeed ?? this.descriptionSeed,
  acceptedSeeds: acceptedSeeds ?? this.acceptedSeeds,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['radioSessionId'] = radioSessionId;
    if (sequence != null) {
      map['sequence'] = sequence?.map((v) => v.toJson()).toList();
    }
    map['batchId'] = batchId;
    map['pumpkin'] = pumpkin;
    if (descriptionSeed != null) {
      map['descriptionSeed'] = descriptionSeed?.toJson();
    }
    if (acceptedSeeds != null) {
      map['acceptedSeeds'] = acceptedSeeds?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class AcceptedSeeds {
  AcceptedSeeds({
      this.value, 
      this.tag, 
      this.type,});

  AcceptedSeeds.fromJson(dynamic json) {
    value = json['value'];
    tag = json['tag'];
    type = json['type'];
  }
  String? value;
  String? tag;
  String? type;
AcceptedSeeds copyWith({  String? value,
  String? tag,
  String? type,
}) => AcceptedSeeds(  value: value ?? this.value,
  tag: tag ?? this.tag,
  type: type ?? this.type,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['value'] = value;
    map['tag'] = tag;
    map['type'] = type;
    return map;
  }

}

class DescriptionSeed {
  DescriptionSeed({
      this.value, 
      this.tag, 
      this.type,});

  DescriptionSeed.fromJson(dynamic json) {
    value = json['value'];
    tag = json['tag'];
    type = json['type'];
  }
  String? value;
  String? tag;
  String? type;
DescriptionSeed copyWith({  String? value,
  String? tag,
  String? type,
}) => DescriptionSeed(  value: value ?? this.value,
  tag: tag ?? this.tag,
  type: type ?? this.type,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['value'] = value;
    map['tag'] = tag;
    map['type'] = type;
    return map;
  }

}

class InvocationInfo {
  InvocationInfo({
      this.reqid, 
      this.hostname, 
      this.execdurationmillis,});

  InvocationInfo.fromJson(dynamic json) {
    reqid = json['req-id'];
    hostname = json['hostname'];
    execdurationmillis = json['exec-duration-millis'];
  }
  String? reqid;
  String? hostname;
  num? execdurationmillis;
InvocationInfo copyWith({  String? reqid,
  String? hostname,
  num? execdurationmillis,
}) => InvocationInfo(  reqid: reqid ?? this.reqid,
  hostname: hostname ?? this.hostname,
  execdurationmillis: execdurationmillis ?? this.execdurationmillis,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['req-id'] = reqid;
    map['hostname'] = hostname;
    map['exec-duration-millis'] = execdurationmillis;
    return map;
  }

}