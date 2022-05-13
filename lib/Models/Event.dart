// To parse this JSON data, do
//
//     final event = eventFromJson(jsonString);

import 'dart:convert';

EventBase eventFromJson(String str) => EventBase.fromJson(json.decode(str));

String eventToJson(EventBase data) => json.encode(data.toJson());

class EventBase {
  EventBase({
    this.success,
    this.data,
  });

  bool success;
  List<Event> data;

  factory EventBase.fromJson(Map<String, dynamic> json) => EventBase(
    success: json["success"],
    data: List<Event>.from(json["data"].map((x) => Event.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Event {
  Event({
    this.id,
    this.name,
    this.description,
    this.address,
    this.startDate,
    this.endDate,
    this.isOnline,
    this.onlineLink,
    this.isOver,
    this.imagePath,
    this.communityName,
    this.eventType,
    this.language,
    this.participationType,
    this.country,
    this.city,
  });

  int id;
  String name;
  String description;
  String address;
  DateTime startDate;
  DateTime endDate;
  bool isOnline;
  String onlineLink;
  bool isOver;
  String imagePath;
  String communityName;
  String eventType;
  String language;
  String participationType;
  String country;
  String city;

  factory Event.fromJson(Map<String, dynamic> json) => Event(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    address: json["address"],
    startDate: DateTime.parse(json["startDate"]),
    endDate: DateTime.parse(json["endDate"]),
    isOnline: json["isOnline"],
    onlineLink: json["onlineLink"],
    isOver: json["isOver"],
    imagePath: json["imagePath"],
    communityName: json["communityName"],
    eventType: json["eventType"],
    language: json["language"],
    participationType: json["participationType"],
    country: json["country"],
    city: json["city"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "address": address,
    "startDate": startDate.toIso8601String(),
    "endDate": endDate.toIso8601String(),
    "isOnline": isOnline,
    "onlineLink": onlineLink,
    "isOver": isOver,
    "imagePath": imagePath,
    "communityName": communityName,
    "eventType": eventType,
    "language": language,
    "participationType": participationType,
    "country": country,
    "city": city,
  };
}
