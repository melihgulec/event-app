import 'dart:convert';

import 'package:event_app/Models/Community.dart';
import 'package:event_app/Models/Role.dart';
import 'package:event_app/Models/User.dart';

UserCommunityRoleBase userCommunityRoleBaseFromJson(String str) => UserCommunityRoleBase.fromJson(json.decode(str));

String userCommunityRoleBaseToJson(UserCommunityRoleBase data) => json.encode(data.toJson());

class UserCommunityRoleBase {
  UserCommunityRoleBase({
    this.data,
    this.success,
    this.message,
  });

  List<UserCommunityRole> data;
  bool success;
  dynamic message;

  factory UserCommunityRoleBase.fromJson(Map<String, dynamic> json) => UserCommunityRoleBase(
    data: List<UserCommunityRole>.from(json["data"].map((x) => UserCommunityRole.fromJson(x))),
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "success": success,
    "message": message,
  };
}

class UserCommunityRole {
  UserCommunityRole({
    this.id,
    this.user,
    this.role,
    this.community,
  });

  int id;
  User user;
  Role role;
  Community community;

  factory UserCommunityRole.fromJson(Map<String, dynamic> json) => UserCommunityRole(
    id: json["id"],
    user: User.fromJson(json["user"]),
    role: Role.fromJson(json["role"]),
    community: Community.fromJson(json["community"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user": user.toJson(),
    "role": role.toJson(),
    "community": community.toJson(),
  };
}