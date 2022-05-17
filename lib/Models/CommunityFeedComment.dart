// To parse this JSON data, do
//
//     final communityFeedComment = communityFeedCommentFromJson(jsonString);

import 'dart:convert';

import 'package:event_app/Models/User.dart';

CommunityFeedCommentBase communityFeedCommentFromJson(String str) => CommunityFeedCommentBase.fromJson(json.decode(str));

String communityFeedCommentToJson(CommunityFeedCommentBase data) => json.encode(data.toJson());

class CommunityFeedCommentBase {
  CommunityFeedCommentBase({
    this.success,
    this.data,
  });

  bool success;
  List<CommunityFeedComment> data;

  factory CommunityFeedCommentBase.fromJson(Map<String, dynamic> json) => CommunityFeedCommentBase(
    success: json["success"],
    data: List<CommunityFeedComment>.from(json["data"].map((x) => CommunityFeedComment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class CommunityFeedComment {
  CommunityFeedComment({
    this.id,
    this.description,
    this.createdAt,
    this.user,
  });

  int id;
  String description;
  DateTime createdAt;
  User user;

  factory CommunityFeedComment.fromJson(Map<String, dynamic> json) => CommunityFeedComment(
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