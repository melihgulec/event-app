// To parse this JSON data, do
//
//     final country = countryFromJson(jsonString);

import 'dart:convert';

CountryBase countryFromJson(String str) => CountryBase.fromJson(json.decode(str));

String countryToJson(CountryBase data) => json.encode(data.toJson());

class CountryBase {
  CountryBase({
    this.success,
    this.data,
  });

  bool success;
  List<Country> data;

  factory CountryBase.fromJson(Map<String, dynamic> json) => CountryBase(
    success: json["success"],
    data: List<Country>.from(json["data"].map((x) => Country.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Country {
  Country({
    this.id,
    this.shortName,
    this.name,
    this.phoneCode,
  });

  int id;
  String shortName;
  String name;
  int phoneCode;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    id: json["id"],
    shortName: json["shortName"],
    name: json["name"],
    phoneCode: json["phoneCode"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "shortName": shortName,
    "name": name,
    "phoneCode": phoneCode,
  };
}
