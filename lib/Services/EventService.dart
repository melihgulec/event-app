import 'dart:convert';
import 'package:event_app/Constants/Texts.dart';
import 'package:event_app/Helpers/ToastHelper.dart';
import 'package:event_app/Models/EventSponsor.dart';
import 'package:event_app/Screens/SponsorsService.dart';
import 'package:http/http.dart' as http;
import 'package:event_app/Models/Event.dart';
import 'package:event_app/Constants/API.dart' as api;
import 'package:shared_preferences/shared_preferences.dart';

Future<EventBase> GetRequestEvents(String requestUri) async{
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
    return EventBase.fromJson(jsonDecode(response.body));
  }else if(response.statusCode == 401){
    ToastHelper().makeToastMessage(Texts.notAuthorized);
  }else{
    print("EventService, ${response.statusCode}");
  }
}

Future<EventBase> GetAllEvents() async{
  String requestUri = "${api.BaseURL}/events/";
  return GetRequestEvents(requestUri);
}

Future<EventBase> GetEvent(String eventId) async{
  String requestUri = "${api.BaseURL}/events/$eventId";
  return GetRequestEvents(requestUri);
}

Future<EventSponsorBase> GetEventSponsors(int eventId) async{
  String requestUri = "${api.BaseURL}/events/$eventId/sponsors";
  return GetRequestSponsors(requestUri);
}

Future<EventBase> GetEventsByInterest(String interestId) async{
  String requestUri = "${api.BaseURL}/events/interests/$interestId";
  return GetRequestEvents(requestUri);
}