// To parse this JSON data, do
//
//     final roleBase = roleBaseFromJson(jsonString);

import 'dart:convert';

RoleBase roleBaseFromJson(String str) => RoleBase.fromJson(json.decode(str));

String roleBaseToJson(RoleBase data) => json.encode(data.toJson());

class RoleBase {
  RoleBase({
    this.success,
    this.data,
  });

  bool success;
  List<Role> data;

  factory RoleBase.fromJson(Map<String, dynamic> json) => RoleBase(
    success: json["success"],
    data: List<Role>.from(json["data"].map((x) => Role.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Role {
  Role({
    this.id,
    this.description,
  });

  int id;
  String description;

  factory Role.fromJson(Map<String, dynamic> json) => Role(
    id: json["id"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "description": description,
  };
}
