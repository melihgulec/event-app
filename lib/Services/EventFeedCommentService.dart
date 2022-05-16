import 'dart:convert';

import 'package:event_app/Constants/Texts.dart';
import 'package:event_app/Helpers/ToastHelper.dart';
import 'package:event_app/Models/EventFeedComment.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<EventFeedCommentBase> GetRequestEventFeedComment(String requestUri) async{
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
    return EventFeedCommentBase.fromJson(jsonDecode(response.body));
  }else if(response.statusCode == 401){
    ToastHelper().makeToastMessage(Texts.notAuthorized);
  }else{
    print("EventFeedCommentService, ${response.statusCode}");
  }
}