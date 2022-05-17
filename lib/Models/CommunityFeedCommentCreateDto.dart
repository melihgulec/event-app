// To parse this JSON data, do
//
//     final communityFeedComment = communityFeedCommentFromJson(jsonString);

import 'dart:convert';

CommunityFeedCommentCreateDto communityFeedCommentFromJson(String str) => CommunityFeedCommentCreateDto.fromJson(json.decode(str));

String communityFeedCommentToJson(CommunityFeedCommentCreateDto data) => json.encode(data.toJson());

class CommunityFeedCommentCreateDto {
  CommunityFeedCommentCreateDto({
    this.description,
    this.createdAt,
    this.userId,
    this.communityId,
  });

  String description;
  DateTime createdAt;
  int userId;
  int communityId;

  factory CommunityFeedCommentCreateDto.fromJson(Map<String, dynamic> json) => CommunityFeedCommentCreateDto(
    description: json["description"],
    createdAt: DateTime.parse(json["createdAt"]),
    userId: json["userID"],
    communityId: json["communityID"],
  );

  Map<String, dynamic> toJson() => {
    "description": description,
    "createdAt": createdAt.toIso8601String(),
    "userID": userId,
    "communityID": communityId,
  };
}
