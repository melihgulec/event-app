// To parse this JSON data, do
//
//     final userFollower = userFollowerFromJson(jsonString);

import 'dart:convert';

import 'package:event_app/Models/User.dart';

UserFollower userFollowerFromJson(String str) => UserFollower.fromJson(json.decode(str));

String userFollowerToJson(UserFollower data) => json.encode(data.toJson());

class UserFollower {
  UserFollower({
    this.success,
    this.count,
    this.data,
  });

  bool success;
  int count;
  List<User> data;

  factory UserFollower.fromJson(Map<String, dynamic> json) => UserFollower(
    success: json["success"],
    count: json["count"],
    data: List<User>.from(json["data"].map((x) => User.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "count": count,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}