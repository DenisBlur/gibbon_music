import 'block.dart';

class Landing {
  Landing({
    this.pumpkin,
    this.contentId,
    this.blocks,
  });

  Landing.fromJson(dynamic json) {
    pumpkin = json['pumpkin'];
    contentId = json['contentId'];
    if (json['blocks'] != null) {
      blocks = [];
      json['blocks'].forEach((v) {
        blocks?.add(Block.fromJson(v));
      });
    }
  }

  bool? pumpkin;
  String? contentId;
  List<Block>? blocks;

  Landing copyWith({
    bool? pumpkin,
    String? contentId,
    List<Block>? blocks,
  }) =>
      Landing(
        pumpkin: pumpkin ?? this.pumpkin,
        contentId: contentId ?? this.contentId,
        blocks: blocks ?? this.blocks,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['pumpkin'] = pumpkin;
    map['contentId'] = contentId;
    if (blocks != null) {
      map['blocks'] = blocks?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
