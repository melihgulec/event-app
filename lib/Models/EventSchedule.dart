// To parse this JSON data, do
//
//     final eventScheduleBase = eventScheduleBaseFromJson(jsonString);

import 'dart:convert';

EventScheduleBase eventScheduleBaseFromJson(String str) => EventScheduleBase.fromJson(json.decode(str));

String eventScheduleBaseToJson(EventScheduleBase data) => json.encode(data.toJson());

class EventScheduleBase {
  EventScheduleBase({
    this.success,
    this.data,
  });

  bool success;
  List<EventSchedule> data;

  factory EventScheduleBase.fromJson(Map<String, dynamic> json) => EventScheduleBase(
    success: json["success"],
    data: List<EventSchedule>.from(json["data"].map((x) => EventSchedule.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class EventSchedule {
  EventSchedule({
    this.id,
    this.description,
    this.startDate,
    this.endDate,
  });

  int id;
  String description;
  String startDate;
  String endDate;

  factory EventSchedule.fromJson(Map<String, dynamic> json) => EventSchedule(
    id: json["id"],
    description: json["description"],
    startDate: json["startDate"],
    endDate: json["endDate"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "description": description,
    "startDate": startDate,
    "endDate": endDate,
  };
}
