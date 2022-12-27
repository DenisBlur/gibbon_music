import '../InvocationInfoBean.dart';

class LandingModel {
  final InvocationInfoBeanStr? invocationInfo;
  final ResultBean? result;

  LandingModel(this.invocationInfo, this.result);

  static LandingModel fromMap(Map<String, dynamic> map) {
    LandingModel promotionsBean = LandingModel(
      map['invocationInfo'] != null
          ? InvocationInfoBeanStr.fromMap(map['invocationInfo'])
          : null,
      map['result'] != null ? ResultBean.fromMap(map['result']) : null,
    );
    return promotionsBean;
  }

  Map<String, dynamic> toJson() => {
        "invocationInfo": invocationInfo?.toJson(),
        "result": result?.toJson(),
      }..removeWhere((k, v) => v == null);
}

class ResultBean {
  final bool? pumpkin;
  final String? contentId;
  final List<BlocksBean>? blocks;

  ResultBean(this.pumpkin, this.contentId, this.blocks);

  static ResultBean fromMap(Map<String, dynamic> map) {
    ResultBean resultBean = ResultBean(
      map['pumpkin'],
      map['contentId'],
      map['blocks'] != null
          ? ([...(map['blocks'] as List).map((o) => BlocksBean.fromMap(o))]
            )
          : null,
    );
    return resultBean;
  }

  Map toJson() => {
        "pumpkin": pumpkin,
        "contentId": contentId,
        "blocks": blocks?.map((o) => o.toJson()).toList(growable: false),
      }..removeWhere((k, v) => v == null);
}

class BlocksBean {
  final String? id;
  final String? type;
  final String? typeForFrom;
  final String? title;
  final String? description;
  final List<EntitiesBean>? entities;

  BlocksBean(this.id, this.type, this.typeForFrom, this.title, this.description,
      this.entities);

  static BlocksBean fromMap(Map<String, dynamic> map) {
    BlocksBean blocksBean = BlocksBean(
      map['id'],
      map['type'],
      map['typeForFrom'],
      map['title'],
      map['description'],
      map['entities'] != null
          ? ([...(map['entities'] as List).map((o) => EntitiesBean.fromMap(o))])
          : null,
    );
    return blocksBean;
  }

  Map toJson() => {
        "id": id,
        "type": type,
        "typeForFrom": typeForFrom,
        "title": title,
        "description": description,
        "entities": entities?.map((o) => o.toJson()).toList(growable: false),
      }..removeWhere((k, v) => v == null);
}

class EntitiesBean {
  final String? id;
  final String? type;
  final Map<String, dynamic> data;

  EntitiesBean(this.id, this.type, this.data);

  static EntitiesBean fromMap(Map<String, dynamic> map) {
    EntitiesBean entitiesBean = EntitiesBean(
      map['id'],
      map['type'],
      map['data'],
    );
    return entitiesBean;
  }

  Map toJson() => {
        "id": id,
        "type": type,
        "data": data,
      }..removeWhere((k, v) => v == null);
}
