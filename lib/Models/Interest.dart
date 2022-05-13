// To parse this JSON data, do
//
//     final interest = interestFromJson(jsonString);

import 'dart:convert';

InterestBase interestFromJson(String str) => InterestBase.fromJson(json.decode(str));

String interestToJson(InterestBase data) => json.encode(data.toJson());

class InterestBase {
  InterestBase({
    this.success,
    this.data,
  });

  bool success;
  List<Interest> data;

  factory InterestBase.fromJson(Map<String, dynamic> json) => InterestBase(
    success: json["success"],
    data: List<Interest>.from(json["data"].map((x) => Interest.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Interest {
  Interest({
    this.id,
    this.name,
    this.color,
    this.icon,
  });

  int id;
  String name;
  dynamic color;
  String icon;

  factory Interest.fromJson(Map<String, dynamic> json) => Interest(
    id: json["id"],
    name: json["name"],
    color: json["color"],
    icon: json["icon"] == null ? null : json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "color": color,
    "icon": icon == null ? null : icon,
  };
}
