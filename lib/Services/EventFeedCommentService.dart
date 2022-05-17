import 'dart:convert';
import 'package:event_app/Constants/Texts.dart';
import 'package:event_app/Helpers/ToastHelper.dart';
import 'package:event_app/Models/CommentCreateDto.dart';
import 'package:event_app/Models/EventFeedComment.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:event_app/Constants/API.dart' as api;

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

Future<void> PostRequestEventFeedComment(String requestUri, String body) async{
  SharedPreferences _preferences = await SharedPreferences.getInstance();
  String token = _preferences.getString("apiToken");

  final response = await http.post(
      Uri.parse(requestUri),
      headers: {
        "Content-Type": "application/json",
        "Authorization" : "Bearer $token"
      },
    body: body
  );
  if(response.statusCode == 200){
    Map json = jsonDecode(response.body);
    ToastHelper().makeToastMessage(json["message"]);
  }else if(response.statusCode == 401){
    ToastHelper().makeToastMessage(Texts.notAuthorized);
  }else{
    print("EventFeedCommentService, ${response.statusCode}");
  }
}

Future<void> DeleteRequestEventFeedComment(String requestUri, String body) async{
  SharedPreferences _preferences = await SharedPreferences.getInstance();
  String token = _preferences.getString("apiToken");

  final response = await http.delete(
      Uri.parse(requestUri),
      headers: {
        "Content-Type": "application/json",
        "Authorization" : "Bearer $token"
      },
      body: body
  );
  if(response.statusCode == 200){
    Map json = jsonDecode(response.body);
    ToastHelper().makeToastMessage(json["message"]);
  }else if(response.statusCode == 401){
    ToastHelper().makeToastMessage(Texts.notAuthorized);
  }else{
    print("EventFeedCommentService, ${response.statusCode}");
  }
}

void CreateComment(int eventId, int postId, CommentCreateDto commentCreateDto){
  String requestUri = "${api.BaseURL}/events/$eventId/feed/$postId/comments";
  String encoded = jsonEncode(commentCreateDto);
  PostRequestEventFeedComment(requestUri, encoded);
}

void DeleteComment(int eventId, int postId, int commentId){
  String requestUri = "${api.BaseURL}/events/$eventId/feed/$postId/comments/${commentId}";
  DeleteRequestEventFeedComment(requestUri, null);
}