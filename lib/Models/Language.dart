// To parse this JSON data, do
//
//     final languageBase = languageBaseFromJson(jsonString);

import 'dart:convert';

LanguageBase languageBaseFromJson(String str) => LanguageBase.fromJson(json.decode(str));

String languageBaseToJson(LanguageBase data) => json.encode(data.toJson());

class LanguageBase {
  LanguageBase({
    this.success,
    this.data,
  });

  bool success;
  List<Language> data;

  factory LanguageBase.fromJson(Map<String, dynamic> json) => LanguageBase(
    success: json["success"],
    data: List<Language>.from(json["data"].map((x) => Language.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Language {
  Language({
    this.id,
    this.name,
    this.countryId,
  });

  int id;
  String name;
  int countryId;

  factory Language.fromJson(Map<String, dynamic> json) => Language(
    id: json["id"],
    name: json["name"],
    countryId: json["countryID"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "countryID": countryId,
  };
}
