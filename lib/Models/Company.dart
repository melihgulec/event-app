// To parse this JSON data, do
//
//     final company = companyFromJson(jsonString);

import 'dart:convert';

import 'package:event_app/Models/City.dart';

CompanyBase companyFromJson(String str) => CompanyBase.fromJson(json.decode(str));

String companyToJson(CompanyBase data) => json.encode(data.toJson());

class CompanyBase {
  CompanyBase({
    this.success,
    this.data,
  });

  bool success;
  List<Company> data;

  factory CompanyBase.fromJson(Map<String, dynamic> json) => CompanyBase(
    success: json["success"],
    data: List<Company>.from(json["data"].map((x) => Company.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Company {
  Company({
    this.id,
    this.companyName,
    this.description,
    this.city,
  });

  int id;
  String companyName;
  String description;
  City city;

  factory Company.fromJson(Map<String, dynamic> json) => Company(
    id: json["id"],
    companyName: json["companyName"],
    description: json["description"],
    city: City.fromJson(json["city"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "companyName": companyName,
    "description": description,
    "city": city.toJson(),
  };
}