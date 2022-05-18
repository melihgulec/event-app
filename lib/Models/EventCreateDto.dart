// To parse this JSON data, do
//
//     final eventCreateDto = eventCreateDtoFromJson(jsonString);

import 'dart:convert';

EventCreateDto eventCreateDtoFromJson(String str) => EventCreateDto.fromJson(json.decode(str));

String eventCreateDtoToJson(EventCreateDto data) => json.encode(data.toJson());

class EventCreateDto {
  EventCreateDto({
    this.name,
    this.description,
    this.address,
    this.startDate,
    this.endDate,
    this.isOnline,
    this.onlineLink,
    this.isOver,
    this.imagePath,
    this.communityId,
    this.eventTypeId,
    this.languageId,
    this.participationTypeId,
    this.countryId,
    this.cityId,
    this.interestId,
  });

  String name;
  String description;
  String address;
  DateTime startDate;
  DateTime endDate;
  bool isOnline;
  String onlineLink;
  bool isOver;
  String imagePath;
  int communityId;
  int eventTypeId;
  int languageId;
  int participationTypeId;
  int countryId;
  int cityId;
  int interestId;

  factory EventCreateDto.fromJson(Map<String, dynamic> json) => EventCreateDto(
    name: json["name"],
    description: json["description"],
    address: json["address"],
    startDate: DateTime.parse(json["startDate"]),
    endDate: DateTime.parse(json["endDate"]),
    isOnline: json["isOnline"],
    onlineLink: json["onlineLink"],
    isOver: json["isOver"],
    imagePath: json["imagePath"],
    communityId: json["communityID"],
    eventTypeId: json["eventTypeID"],
    languageId: json["languageID"],
    participationTypeId: json["participationTypeID"],
    countryId: json["countryID"],
    cityId: json["cityID"],
    interestId: json["interestID"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "description": description,
    "address": address,
    "startDate": startDate.toIso8601String(),
    "endDate": endDate.toIso8601String(),
    "isOnline": isOnline,
    "onlineLink": onlineLink,
    "isOver": isOver,
    "imagePath": imagePath,
    "communityID": communityId,
    "eventTypeID": eventTypeId,
    "languageID": languageId,
    "participationTypeID": participationTypeId,
    "countryID": countryId,
    "cityID": cityId,
    "interestID": interestId,
  };
}
