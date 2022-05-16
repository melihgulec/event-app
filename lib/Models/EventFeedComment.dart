// To parse this JSON data, do
//
//     final eventFeedComment = eventFeedCommentFromJson(jsonString);

import 'dart:convert';

import 'package:event_app/Models/User.dart';

EventFeedCommentBase eventFeedCommentFromJson(String str) => EventFeedCommentBase.fromJson(json.decode(str));

String eventFeedCommentToJson(EventFeedCommentBase data) => json.encode(data.toJson());

class EventFeedCommentBase {
  EventFeedCommentBase({
    this.success,
    this.data,
  });

  bool success;
  List<EventFeedComment> data;

  factory EventFeedCommentBase.fromJson(Map<String, dynamic> json) => EventFeedCommentBase(
    success: json["success"],
    data: List<EventFeedComment>.from(json["data"].map((x) => EventFeedComment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class EventFeedComment {
  EventFeedComment({
    this.id,
    this.description,
    this.createdAt,
    this.user,
  });

  int id;
  String description;
  DateTime createdAt;
  User user;

  factory EventFeedComment.fromJson(Map<String, dynamic> json) => EventFeedComment(
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