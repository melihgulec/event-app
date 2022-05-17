// To parse this JSON data, do
//
//     final communityFeedCreateDto = communityFeedCreateDtoFromJson(jsonString);

import 'dart:convert';

CommunityFeedCreateDto communityFeedCreateDtoFromJson(String str) => CommunityFeedCreateDto.fromJson(json.decode(str));

String communityFeedCreateDtoToJson(CommunityFeedCreateDto data) => json.encode(data.toJson());

class CommunityFeedCreateDto {
  CommunityFeedCreateDto({
    this.description,
    this.createdAt,
  });

  String description;
  DateTime createdAt;

  factory CommunityFeedCreateDto.fromJson(Map<String, dynamic> json) => CommunityFeedCreateDto(
    description: json["description"],
    createdAt: DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "description": description,
    "createdAt": createdAt.toIso8601String(),
  };
}
