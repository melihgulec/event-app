// To parse this JSON data, do
//
//     final sharePost = sharePostFromJson(jsonString);

import 'dart:convert';

import 'package:event_app/Models/User.dart';

SharePostBase sharePostFromJson(String str) => SharePostBase.fromJson(json.decode(str));

String sharePostToJson(SharePostBase data) => json.encode(data.toJson());

class SharePostBase {
  SharePostBase({
    this.success,
    this.data,
  });

  bool success;
  List<SharePost> data;

  factory SharePostBase.fromJson(Map<String, dynamic> json) => SharePostBase(
    success: json["success"],
    data: List<SharePost>.from(json["data"].map((x) => SharePost.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class SharePost {
  SharePost({
    this.id,
    this.description,
    this.createdAt,
    this.user,
  });

  int id;
  String description;
  DateTime createdAt;
  User user;

  factory SharePost.fromJson(Map<String, dynamic> json) => SharePost(
    id: json["id"],
    description: json["description"],
    createdAt: DateTime.parse(json["createdAt"]),
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "description": description,
    "createdAt": createdAt.toIso8601String(),
    "user": user.toJson(),
  };
}
