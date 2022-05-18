// To parse this JSON data, do
//
//     final eventBase = eventBaseFromJson(jsonString);

import 'dart:convert';

import 'package:event_app/Models/City.dart';
import 'package:event_app/Models/Community.dart';
import 'package:event_app/Models/Country.dart';
import 'package:event_app/Models/EventType.dart';
import 'package:event_app/Models/Interest.dart';
import 'package:event_app/Models/Language.dart';
import 'package:event_app/Models/ParticipationType.dart';

EventBase eventBaseFromJson(String str) => EventBase.fromJson(json.decode(str));

String eventBaseToJson(EventBase data) => json.encode(data.toJson());

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
    this.interest,
    this.community,
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
  Interest interest;
  Community community;
  EventType eventType;
  Language language;
  ParticipationType participationType;
  Country country;
  City city;

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
    interest: Interest.fromJson(json["interest"]),
    community: Community.fromJson(json["community"]),
    eventType: EventType.fromJson(json["eventType"]),
    language: Language.fromJson(json["language"]),
    participationType: ParticipationType.fromJson(json["participationType"]),
    country: Country.fromJson(json["country"]),
    city: City.fromJson(json["city"]),
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
    "interest": interest.toJson(),
    "community": community.toJson(),
    "eventType": eventType.toJson(),
    "language": language.toJson(),
    "participationType": participationType.toJson(),
    "country": country.toJson(),
    "city": city.toJson(),
  };
}