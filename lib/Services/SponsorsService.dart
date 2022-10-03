import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:event_app/Constants/Texts.dart';
import 'package:event_app/Helpers/ToastHelper.dart';
import 'package:event_app/Models/EventSponsor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:event_app/Constants/API.dart' as api;

Future<EventSponsorBase> GetRequestSponsors(String requestUri) async{
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
    return EventSponsorBase.fromJson(jsonDecode(response.body));
  }else if(response.statusCode == 401){
    ToastHelper().makeToastMessage(Texts.notAuthorized);
  }else{
    print("Sponsor service, ${response.statusCode}");
  }
}

Future<EventSponsorBase> PostRequestSponsors(String requestUri, String body) async{
  SharedPreferences _preferences = await SharedPreferences.getInstance();
  String token = _preferences.getString("apiToken");

  final response = await http.post(
      Uri.parse(requestUri),
      headers: {
        "Content-Type": "application/json",
        "Authorization" : "Bearer $token",
      },
    body: body
  );
  if(response.statusCode == 200){
    Map json = jsonDecode(response.body);
    ToastHelper().makeToastMessage(json["message"]);
  }else if(response.statusCode == 401){
    ToastHelper().makeToastMessage(Texts.notAuthorized);
  }else{
    Map json = jsonDecode(response.body);
    ToastHelper().makeToastMessage(json["message"]);
    print("Sponsor service, ${response.statusCode}");
  }
}

Future<EventSponsorBase> CreateSponsor(int eventId, int companyID){
  String requestUri = "${api.BaseURL}/events/${eventId}/sponsors";
  print(requestUri);

  String body = jsonEncode({
    'companyID': companyID
  });

  return PostRequestSponsors(requestUri, body);
}