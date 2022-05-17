// To parse this JSON data, do
//
//     final communityCreateDto = communityCreateDtoFromJson(jsonString);

import 'dart:convert';

CommunityCreateDto communityCreateDtoFromJson(String str) => CommunityCreateDto.fromJson(json.decode(str));

String communityCreateDtoToJson(CommunityCreateDto data) => json.encode(data.toJson());

class CommunityCreateDto {
  CommunityCreateDto({
    this.name,
    this.description,
    this.imagePath,
    this.countryId,
    this.cityId,
  });

  String name;
  String description;
  String imagePath;
  int countryId;
  int cityId;

  factory CommunityCreateDto.fromJson(Map<String, dynamic> json) => CommunityCreateDto(
    name: json["name"],
    description: json["description"],
    imagePath: json["imagePath"],
    countryId: json["countryID"],
    cityId: json["cityID"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "description": description,
    "imagePath": imagePath,
    "countryID": countryId,
    "cityID": cityId,
  };
}
