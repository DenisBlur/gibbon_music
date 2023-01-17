class AdParams {
  AdParams({
    this.partnerId,
    this.categoryId,
    this.pageRef,
    this.targetRef,
    this.otherParams,
    this.adVolume,});

  AdParams.fromJson(dynamic json) {
    partnerId = json['partnerId'];
    categoryId = json['categoryId'];
    pageRef = json['pageRef'];
    targetRef = json['targetRef'];
    otherParams = json['otherParams'];
    adVolume = json['adVolume'];
  }
  String? partnerId;
  String? categoryId;
  String? pageRef;
  String? targetRef;
  String? otherParams;
  num? adVolume;
  AdParams copyWith({  String? partnerId,
    String? categoryId,
    String? pageRef,
    String? targetRef,
    String? otherParams,
    num? adVolume,
  }) => AdParams(  partnerId: partnerId ?? this.partnerId,
    categoryId: categoryId ?? this.categoryId,
    pageRef: pageRef ?? this.pageRef,
    targetRef: targetRef ?? this.targetRef,
    otherParams: otherParams ?? this.otherParams,
    adVolume: adVolume ?? this.adVolume,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['partnerId'] = partnerId;
    map['categoryId'] = categoryId;
    map['pageRef'] = pageRef;
    map['targetRef'] = targetRef;
    map['otherParams'] = otherParams;
    map['adVolume'] = adVolume;
    return map;
  }

}