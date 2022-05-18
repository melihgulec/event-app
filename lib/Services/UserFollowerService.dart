import 'dart:convert';
import 'package:event_app/Constants/Texts.dart';
import 'package:event_app/Helpers/ToastHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:event_app/Constants/API.dart' as api;

Future<void> DeleteRequestUserFollows(String requestUri) async{
  SharedPreferences _preferences = await SharedPreferences.getInstance();
  String token = _preferences.getString("apiToken");

  final response = await http.delete(
    Uri.parse(requestUri),
    headers: {
      "Content-Type": "application/json",
      "Authorization" : "Bearer $token"
    },
  );
  if(response.statusCode == 200){
    Map json = jsonDecode(response.body);
    ToastHelper().makeToastMessage(json["message"]);
  }else if(response.statusCode == 401){
    ToastHelper().makeToastMessage(Texts.notAuthorized);
  }else{
    print("CommunitiesService, ${response.statusCode}");
  }
}

Future<void> DeleteUserFollow(int followId) async{
  String requestUri = "${api.BaseURL}/user-followers/$followId";
  return DeleteRequestUserFollows(requestUri);
}