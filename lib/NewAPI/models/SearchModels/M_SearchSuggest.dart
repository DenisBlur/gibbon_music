import 'package:gibbon_music/NewAPI/models/M_Artist.dart';

class MSearchSuggest {
  MSearchSuggest({
    this.best,
    this.suggestions,
  });

  MSearchSuggest.fromJson(dynamic json) {
    best = json['best'] != null ? Best.fromJson(json['best']) : null;
    suggestions = json['suggestions'] != null ? json['suggestions'].cast<String>() : [];
  }

  Best best;
  List<String> suggestions;

  MSearchSuggest copyWith({
    Best best,
    List<String> suggestions,
  }) =>
      MSearchSuggest(
        best: best ?? this.best,
        suggestions: suggestions ?? this.suggestions,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (best != null) {
      map['best'] = best.toJson();
    }
    map['suggestions'] = suggestions;
    return map;
  }
}

class Best {
  Best({
    this.type,
    this.text,
    this.result,
  });

  Best.fromJson(dynamic json) {
    type = json['type'];
    text = json['text'];
    result = json['result'] != null ? MArtist.fromJson(json['result']) : null;
  }

  String type;
  String text;
  MArtist result;

  Best copyWith({
    String type,
    String text,
    MArtist result,
  }) =>
      Best(
        type: type ?? this.type,
        text: text ?? this.text,
        result: result ?? this.result,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['text'] = text;
    if (result != null) {
      map['result'] = result.toJson();
    }
    return map;
  }
}
