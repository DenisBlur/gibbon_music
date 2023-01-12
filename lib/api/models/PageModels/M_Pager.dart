class MPager {
  MPager({
    this.total,
    this.page,
    this.perPage,});

  MPager.fromJson(dynamic json) {
    total = json['total'];
    page = json['page'];
    perPage = json['perPage'];
  }
  num total;
  num page;
  num perPage;
  MPager copyWith({  num total,
    num page,
    num perPage,
  }) => MPager(  total: total ?? this.total,
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