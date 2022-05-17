// To parse this JSON data, do
//
//     final city = cityFromJson(jsonString);

import 'dart:convert';

import 'package:event_app/Models/Country.dart';

CityBase cityFromJson(String str) => CityBase.fromJson(json.decode(str));

String cityToJson(CityBase data) => json.encode(data.toJson());

class CityBase {
  CityBase({
    this.data,
    this.success,
    this.message,
  });

  List<City> data;
  bool success;
  dynamic message;

  factory CityBase.fromJson(Map<String, dynamic> json) => CityBase(
    data: List<City>.from(json["data"].map((x) => City.fromJson(x))),
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "success": success,
    "message": message,
  };
}

class City {
  City({
    this.id,
    this.name,
    this.country,
  });

  int id;
  String name;
  Country country;

  factory City.fromJson(Map<String, dynamic> json) => City(
    id: json["id"],
    name: json["name"],
    country: Country.fromJson(json["country"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "country": country.toJson(),
  };
}