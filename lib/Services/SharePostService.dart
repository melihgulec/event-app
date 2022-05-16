import 'dart:convert';

import 'package:event_app/Constants/Texts.dart';
import 'package:event_app/Helpers/ToastHelper.dart';
import 'package:event_app/Models/SharePost.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<SharePostBase> GetRequestSharePost(String requestUri) async{
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
    return SharePostBase.fromJson(jsonDecode(response.body));
  }else if(response.statusCode == 401){
    ToastHelper().makeToastMessage(Texts.notAuthorized);
  }else{
    print("SharePostService, ${response.statusCode}");
  }
}