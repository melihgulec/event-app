import 'dart:convert';

import 'package:event_app/Models/Role.dart';
import 'package:event_app/Models/User.dart';

UserEventRoleBase userEventRoleBaseFromJson(String str) => UserEventRoleBase.fromJson(json.decode(str));

String userEventRoleBaseToJson(UserEventRoleBase data) => json.encode(data.toJson());

class UserEventRoleBase {
  UserEventRoleBase({
    this.data,
    this.success,
    this.message,
  });

  List<UserEventRole> data;
  bool success;
  dynamic message;

  factory UserEventRoleBase.fromJson(Map<String, dynamic> json) => UserEventRoleBase(
    data: List<UserEventRole>.from(json["data"].map((x) => UserEventRole.fromJson(x))),
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "success": success,
    "message": message,
  };
}

class UserEventRole {
  UserEventRole({
    this.id,
    this.role,
    this.user,
  });

  int id;
  Role role;
  User user;

  factory UserEventRole.fromJson(Map<String, dynamic> json) => UserEventRole(
    id: json["id"],
    role: Role.fromJson(json["role"]),
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "role": role.toJson(),
    "user": user.toJson(),
  };
}