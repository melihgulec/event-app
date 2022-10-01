import 'dart:convert';
import 'package:event_app/Constants/Texts.dart';
import 'package:event_app/Helpers/ToastHelper.dart';
import 'package:event_app/Models/EventSchedule.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:event_app/Constants/API.dart' as api;
import 'package:http/http.dart' as http;

Future<EventScheduleBase> GetRequestEventSchedule(String requestUri) async{
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
    return EventScheduleBase.fromJson(jsonDecode(response.body));
  }else if(response.statusCode == 401){
    ToastHelper().makeToastMessage(Texts.notAuthorized);
  }else{
    print("EventScheduleService, ${response.statusCode}");
  }
}

Future<EventScheduleBase> PostRequestEventSchedule(String requestUri, String body) async{
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
  }
}

Future<EventScheduleBase> PutRequestEventSchedule(String requestUri, String body) async{
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
  }
}

Future<EventScheduleBase> DeleteRequestEventSchedule(String requestUri) async{
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
  }
}

Future<EventScheduleBase> GetEventSchedule(int eventId) async{
  String requestUri = "${api.BaseURL}/events/${eventId}/schedule";
  return GetRequestEventSchedule(requestUri);
}

Future<EventScheduleBase> PostEventSchedule(int eventId, List<EventSchedule> eventSchedules) async{
  String requestUri = "${api.BaseURL}/events/${eventId}/schedule";
  String encoded = jsonEncode(eventSchedules);

  return PostRequestEventSchedule(requestUri, encoded);
}

Future<EventScheduleBase> PutEventSchedule(int eventId, EventSchedule eventSchedule) async{
  String requestUri = "${api.BaseURL}/events/${eventId}/schedule/${eventSchedule.id}";
  String encoded = jsonEncode(eventSchedule);

  return PutRequestEventSchedule(requestUri, encoded);
}

Future<EventScheduleBase> DeleteEventSchedule(int eventId, EventSchedule eventSchedule) async{
  String requestUri = "${api.BaseURL}/events/${eventId}/schedule/${eventSchedule.id}";
  return DeleteRequestEventSchedule(requestUri);
}