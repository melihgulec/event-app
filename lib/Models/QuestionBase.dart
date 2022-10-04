// To parse this JSON data, do
//
//     final questionBase = questionBaseFromJson(jsonString);

import 'dart:convert';

import 'package:event_app/Models/User.dart';

QuestionBase questionBaseFromJson(String str) => QuestionBase.fromJson(json.decode(str));

String questionBaseToJson(QuestionBase data) => json.encode(data.toJson());

class QuestionBase {
  QuestionBase({
    this.success,
    this.data,
  });

  bool success;
  List<Question> data;

  factory QuestionBase.fromJson(Map<String, dynamic> json) => QuestionBase(
    success: json["success"],
    data: List<Question>.from(json["data"].map((x) => Question.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Question {
  Question({
    this.id,
    this.description,
    this.user,
  });

  int id;
  String description;
  User user;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    id: json["id"],
    description: json["description"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "description": description,
    "user": user.toJson(),
  };
}