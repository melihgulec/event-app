// To parse this JSON data, do
//
//     final companySponsorshipsBase = companySponsorshipsBaseFromJson(jsonString);

import 'dart:convert';

import 'package:event_app/Models/City.dart';
import 'package:event_app/Models/Event.dart';

CompanySponsorshipsBase companySponsorshipsBaseFromJson(String str) => CompanySponsorshipsBase.fromJson(json.decode(str));

String companySponsorshipsBaseToJson(CompanySponsorshipsBase data) => json.encode(data.toJson());

class CompanySponsorshipsBase {
  CompanySponsorshipsBase({
    this.success,
    this.data,
  });

  bool success;
  List<Datum> data;

  factory CompanySponsorshipsBase.fromJson(Map<String, dynamic> json) => CompanySponsorshipsBase(
    success: json["success"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.event,
  });

  Event event;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    event: Event.fromJson(json["_event"]),
  );

  Map<String, dynamic> toJson() => {
    "_event": event.toJson(),
  };
}