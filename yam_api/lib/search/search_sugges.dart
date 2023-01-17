import 'best.dart';

class SearchSuggest {
  SearchSuggest({
    this.best,
    this.suggestions,
  });

  SearchSuggest.fromJson(dynamic json) {
    best = json['best'] != null ? Best.fromJson(json['best']) : null;
    suggestions = json['suggestions'] != null ? json['suggestions'].cast<String>() : [];
  }

  Best? best;
  List<String>? suggestions;

  SearchSuggest copyWith({
    Best? best,
    List<String>? suggestions,
  }) =>
      SearchSuggest(
        best: best ?? this.best,
        suggestions: suggestions ?? this.suggestions,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (best != null) {
      map['best'] = best?.toJson();
    }
    map['suggestions'] = suggestions;
    return map;
  }
}
