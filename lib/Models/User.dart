// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

import 'package:event_app/Models/Country.dart';

UserBase userFromJson(String str) => UserBase.fromJson(json.decode(str));

String userToJson(UserBase data) => json.encode(data.toJson());

class UserBase {
  UserBase({
    this.success,
    this.message,
    this.data,
  });

  bool success;
  String message;
  List<User> data;

  factory UserBase.fromJson(Map<String, dynamic> json) => UserBase(
    success: json["success"],
    message: json["message"],
    data: List<User>.from(json["data"].map((x) => User.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class User {
  User({
    this.id,
    this.name,
    this.surname,
    this.dateOfBirth,
    this.email,
    this.createdAt,
    this.imagePath,
    this.country,
    this.profileDescription,
  });

  int id;
  String name;
  String surname;
  DateTime dateOfBirth;
  String email;
  DateTime createdAt;
  String imagePath;
  Country country;
  String profileDescription;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    surname: json["surname"],
    dateOfBirth:json["dateOfBirth"] == null ? null : DateTime.parse(json["dateOfBirth"] ),
    email: json["email"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    imagePath: json["imagePath"],
    country:json["country"] == null ? null : Country.fromJson(json["country"]),
    profileDescription: json["profileDescription"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "surname": surname,
    "dateOfBirth": dateOfBirth.toIso8601String(),
    "email": email,
    "createdAt": createdAt.toIso8601String(),
    "imagePath": imagePath,
    "country": country.toJson(),
    "profileDescription": profileDescription
  };
}