import 'dart:convert';

import 'package:event_app/Constants/Texts.dart';
import 'package:event_app/Helpers/ToastHelper.dart';
import 'package:event_app/Models/User.dart';
import 'package:event_app/Models/UserFollower.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:event_app/Constants/API.dart' as api;

Future<UserBase> GetRequestUsers(String requestUri) async{
  SharedPreferences _preferences = await SharedPreferences.getInstance();
  String token = _preferences.getString("apiToken");

  final response = await http.get(
      Uri.parse(requestUri),
      headers: {
        "Content-Type": "application/json",
        "Authorization" : "Bearer $token"
      }
  );

  print("STATÜ KODU : ${response.statusCode}");

  if(response.statusCode == 200){
    return UserBase.fromJson(jsonDecode(response.body));
  }else if(response.statusCode == 401){
    ToastHelper().makeToastMessage(Texts.notAuthorized);
  }else{
    print("UserService, ${response.statusCode}");
  }
}

Future<UserFollower> GetRequestUserFollowers(String requestUri) async{
  SharedPreferences _preferences = await SharedPreferences.getInstance();
  String token = _preferences.getString("apiToken");

  final response = await http.get(
      Uri.parse(requestUri),
      headers: {
        "Content-Type": "application/json",
        "Authorization" : "Bearer $token"
      }
  );
  if(response.statusCode == 200){
    return UserFollower.fromJson(jsonDecode(response.body));
  }else if(response.statusCode == 401){
    ToastHelper().makeToastMessage(Texts.notAuthorized);
  }else{
    print("UserService, ${response.statusCode}");
  }
}

Future<UserFollower> GetUserFollowers(int userId) async{
  String requestUri = "${api.BaseURL}/users/$userId/followers";
  return GetRequestUserFollowers(requestUri);
}

Future<UserFollower> GetUserFollows(int userId) async{
  String requestUri = "${api.BaseURL}/users/$userId/follows";
  return GetRequestUserFollowers(requestUri);
}

NetworkImage GetUserImage(int userId){
  String requestUri = "${api.BaseURL}/users/$userId/image";
  return NetworkImage(requestUri);
}