import 'dart:convert';
import 'package:event_app/Constants/Texts.dart';
import 'package:event_app/Helpers/ToastHelper.dart';
import 'package:event_app/Models/City.dart';
import 'package:event_app/Models/QuestionBase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:event_app/Constants/API.dart' as api;
import 'package:http/http.dart' as http;

Future<QuestionBase> GetRequestQuestions(String requestUri) async{
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
    return QuestionBase.fromJson(jsonDecode(response.body));
  }else if(response.statusCode == 401){
    ToastHelper().makeToastMessage(Texts.notAuthorized);
  }else{
    print("QuestionService, ${response.statusCode}");
  }
}

Future<QuestionBase> PostRequestQuestions(String requestUri, String body) async{
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
    print("QuestionService, ${response.statusCode}");
  }
}

Future<QuestionBase> PutRequestQuestions(String requestUri, String body) async{
  SharedPreferences _preferences = await SharedPreferences.getInstance();
  String token = _preferences.getString("apiToken");

  final response = await http.put(
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
    print("QuestionService, ${response.statusCode}");
  }
}

Future<QuestionBase> DeleteRequestQuestions(String requestUri) async{
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
    print("QuestionService, ${response.statusCode}");
  }
}


Future<QuestionBase> GetQuestionsByEventId(int eventId) async{
  String requestUri = "${api.BaseURL}/events/${eventId}/questions";
  return GetRequestQuestions(requestUri);
}

Future<QuestionBase> PostQuestionByEventId(int eventId, Question question) async{
  String requestUri = "${api.BaseURL}/events/${eventId}/questions";
  String encoded = jsonEncode({
    "description": question.description,
    "userID": question.user.id
  });

  return PostRequestQuestions(requestUri, encoded);
}

Future<QuestionBase> PutQuestionByEventId(int eventId, Question question) async{
  String requestUri = "${api.BaseURL}/events/${eventId}/questions/${question.id}";
  String encoded = jsonEncode({
    "description": question.description,
  });

  return PutRequestQuestions(requestUri, encoded);
}

Future<QuestionBase> DeleteQuestionByEventId(int eventId, Question question) async{
  String requestUri = "${api.BaseURL}/events/${eventId}/questions/${question.id}";

  return DeleteRequestQuestions(requestUri);
}