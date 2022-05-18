// To parse this JSON data, do
//
//     final participationTypeBase = participationTypeBaseFromJson(jsonString);

import 'dart:convert';

ParticipationTypeBase participationTypeBaseFromJson(String str) => ParticipationTypeBase.fromJson(json.decode(str));

String participationTypeBaseToJson(ParticipationTypeBase data) => json.encode(data.toJson());

class ParticipationTypeBase {
  ParticipationTypeBase({
    this.success,
    this.data,
  });

  bool success;
  List<ParticipationType> data;

  factory ParticipationTypeBase.fromJson(Map<String, dynamic> json) => ParticipationTypeBase(
    success: json["success"],
    data: List<ParticipationType>.from(json["data"].map((x) => ParticipationType.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class ParticipationType {
  ParticipationType({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory ParticipationType.fromJson(Map<String, dynamic> json) => ParticipationType(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
