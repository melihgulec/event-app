// To parse this JSON data, do
//
//     final userFollowerBase = userFollowerBaseFromJson(jsonString);

import 'dart:convert';

import 'package:event_app/Models/User.dart';

UserFollowerBase userFollowerBaseFromJson(String str) => UserFollowerBase.fromJson(json.decode(str));

String userFollowerBaseToJson(UserFollowerBase data) => json.encode(data.toJson());

class UserFollowerBase {
  UserFollowerBase({
    this.success,
    this.count,
    this.data,
  });

  bool success;
  int count;
  List<UserFollower> data;

  factory UserFollowerBase.fromJson(Map<String, dynamic> json) => UserFollowerBase(
    success: json["success"],
    count: json["count"],
    data: List<UserFollower>.from(json["data"].map((x) => UserFollower.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "count": count,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class UserFollower {
  UserFollower({
    this.id,
    this.user,
  });

  int id;
  User user;

  factory UserFollower.fromJson(Map<String, dynamic> json) => UserFollower(
    id: json["id"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user": user.toJson(),
  };
}