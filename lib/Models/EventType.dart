// To parse this JSON data, do
//
//     final eventType = eventTypeFromJson(jsonString);

import 'dart:convert';

EventTypeBase eventTypeFromJson(String str) => EventTypeBase.fromJson(json.decode(str));

String eventTypeToJson(EventTypeBase data) => json.encode(data.toJson());

class EventTypeBase {
  EventTypeBase({
    this.success,
    this.data,
  });

  bool success;
  List<EventType> data;

  factory EventTypeBase.fromJson(Map<String, dynamic> json) => EventTypeBase(
    success: json["success"],
    data: List<EventType>.from(json["data"].map((x) => EventType.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class EventType {
  EventType({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory EventType.fromJson(Map<String, dynamic> json) => EventType(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
