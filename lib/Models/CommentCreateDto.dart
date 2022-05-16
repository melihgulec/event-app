// To parse this JSON data, do
//
//     final commentCreateDto = commentCreateDtoFromJson(jsonString);

import 'dart:convert';

CommentCreateDto commentCreateDtoFromJson(String str) => CommentCreateDto.fromJson(json.decode(str));

String commentCreateDtoToJson(CommentCreateDto data) => json.encode(data.toJson());

class CommentCreateDto {
  CommentCreateDto({
    this.description,
    this.createdAt,
    this.userId,
  });

  String description;
  DateTime createdAt;
  int userId;

  factory CommentCreateDto.fromJson(Map<String, dynamic> json) => CommentCreateDto(
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
