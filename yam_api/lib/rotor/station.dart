import 'icons.dart';
import 'restructions.dart';

class Station {
  Station({
    this.id,
    this.name,
    this.icon,
    this.mtsIcon,
    this.fullImageUrl,
    this.idForFrom,
    this.restrictions,
    this.restrictions2,});

  Station.fromJson(dynamic json) {
    id = json['id'] != null ? Id.fromJson(json['id']) : null;
    name = json['name'];
    icon = json['icon'] != null ? Icon.fromJson(json['icon']) : null;
    mtsIcon = json['mtsIcon'] != null ? MtsIcon.fromJson(json['mtsIcon']) : null;
    fullImageUrl = json['fullImageUrl'];
    idForFrom = json['idForFrom'];
    restrictions = json['restrictions'] != null ? Restrictions.fromJson(json['restrictions']) : null;
    restrictions2 = json['restrictions2'] != null ? Restrictions2.fromJson(json['restrictions2']) : null;
  }
  Id? id;
  String? name;
  Icon? icon;
  MtsIcon? mtsIcon;
  String? fullImageUrl;
  String? idForFrom;
  Restrictions? restrictions;
  Restrictions2? restrictions2;
  Station copyWith({  Id? id,
    String? name,
    Icon? icon,
    MtsIcon? mtsIcon,
    String? fullImageUrl,
    String? idForFrom,
    Restrictions? restrictions,
    Restrictions2? restrictions2,
  }) => Station(  id: id ?? this.id,
    name: name ?? this.name,
    icon: icon ?? this.icon,
    mtsIcon: mtsIcon ?? this.mtsIcon,
    fullImageUrl: fullImageUrl ?? this.fullImageUrl,
    idForFrom: idForFrom ?? this.idForFrom,
    restrictions: restrictions ?? this.restrictions,
    restrictions2: restrictions2 ?? this.restrictions2,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (id != null) {
      map['id'] = id?.toJson();
    }
    map['name'] = name;
    if (icon != null) {
      map['icon'] = icon?.toJson();
    }
    if (mtsIcon != null) {
      map['mtsIcon'] = mtsIcon?.toJson();
    }
    map['fullImageUrl'] = fullImageUrl;
    map['idForFrom'] = idForFrom;
    if (restrictions != null) {
      map['restrictions'] = restrictions?.toJson();
    }
    if (restrictions2 != null) {
      map['restrictions2'] = restrictions2?.toJson();
    }
    return map;
  }

}