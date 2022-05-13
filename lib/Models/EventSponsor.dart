// To parse this JSON data, do
//
//     final eventSponsor = eventSponsorFromJson(jsonString);

import 'dart:convert';
import 'package:event_app/Models/Company.dart';

EventSponsorBase eventSponsorFromJson(String str) => EventSponsorBase.fromJson(json.decode(str));

String eventSponsorToJson(EventSponsorBase data) => json.encode(data.toJson());

class EventSponsorBase {
  EventSponsorBase({
    this.success,
    this.data,
  });

  bool success;
  List<EventSponsor> data;

  factory EventSponsorBase.fromJson(Map<String, dynamic> json) => EventSponsorBase(
    success: json["success"],
    data: List<EventSponsor>.from(json["data"].map((x) => EventSponsor.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class EventSponsor {
  EventSponsor({
    this.company,
  });

  Company company;

  factory EventSponsor.fromJson(Map<String, dynamic> json) => EventSponsor(
    company: Company.fromJson(json["company"]),
  );

  Map<String, dynamic> toJson() => {
    "company": company.toJson(),
  };
}