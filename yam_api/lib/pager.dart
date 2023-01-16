class Pager {
  Pager({
    this.total,
    this.page,
    this.perPage,});

  Pager.fromJson(dynamic json) {
    total = json['total'];
    page = json['page'];
    perPage = json['perPage'];
  }
  num? total;
  num? page;
  num? perPage;
  Pager copyWith({  num? total,
    num? page,
    num? perPage,
  }) => Pager(  total: total ?? this.total,
    page: page ?? this.page,
    perPage: perPage ?? this.perPage,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total'] = total;
    map['page'] = page;
    map['perPage'] = perPage;
    return map;
  }

}