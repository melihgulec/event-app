// To parse this JSON data, do
//
//     final communityBase = communityBaseFromJson(jsonString);

import 'dart:convert';

import 'package:event_app/Models/City.dart';
import 'package:event_app/Models/Country.dart';
import 'package:event_app/Models/Interest.dart';

CommunityBase communityBaseFromJson(String str) => CommunityBase.fromJson(json.decode(str));

String communityBaseToJson(CommunityBase data) => json.encode(data.toJson());

class CommunityBase {
  CommunityBase({
    this.success,
    this.data,
  });

  bool success;
  List<Community> data;

  factory CommunityBase.fromJson(Map<String, dynamic> json) => CommunityBase(
    success: json["success"],
    data: List<Community>.from(json["data"].map((x) => Community.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Community {
  Community({
    this.id,
    this.name,
    this.description,
    this.createdAt,
    this.imagePath,
    this.country,
    this.city,
    this.interest,
  });

  int id;
  String name;
  String description;
  DateTime createdAt;
  String imagePath;
  Country country;
  City city;
  List<Interest> interest;

  factory Community.fromJson(Map<String, dynamic> json) => Community(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    createdAt: DateTime.parse(json["createdAt"]),
    imagePath: json["imagePath"],
    country: Country.fromJson(json["country"]),
    city: City.fromJson(json["city"]),
    interest: List<Interest>.from(json["interest"].map((x) => Interest.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "createdAt": createdAt.toIso8601String(),
    "imagePath": imagePath,
    "country": country.toJson(),
    "city": city.toJson(),
    "interest": List<dynamic>.from(interest.map((x) => x.toJson())),
  };
}