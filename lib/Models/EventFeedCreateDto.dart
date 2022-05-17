// To parse this JSON data, do
//
//     final eventFeed = eventFeedFromJson(jsonString);

import 'dart:convert';

EventFeedCreateDto eventFeedFromJson(String str) => EventFeedCreateDto.fromJson(json.decode(str));

String eventFeedToJson(EventFeedCreateDto data) => json.encode(data.toJson());

class EventFeedCreateDto {
  EventFeedCreateDto({
    this.description,
    this.createdAt,
    this.userId,
  });

  String description;
  DateTime createdAt;
  int userId;

  factory EventFeedCreateDto.fromJson(Map<String, dynamic> json) => EventFeedCreateDto(
    description: json["description"],
    createdAt: DateTime.parse(json["createdAt"]),
    userId: json["userID"],
  );

  Map<String, dynamic> toJson() => {
    "description": description,
    "createdAt": createdAt.toIso8601String(),
    "userID": userId,
  };
}
