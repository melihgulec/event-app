import 'dart:convert';
import 'package:event_app/Constants/Texts.dart';
import 'package:event_app/Helpers/ToastHelper.dart';
import 'package:event_app/Models/EventType.dart';
import 'package:event_app/Models/ParticipationType.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:event_app/Constants/API.dart' as api;
import 'package:http/http.dart' as http;

Future<ParticipationTypeBase> GetRequestParticipationTypes(String requestUri) async{
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
    return ParticipationTypeBase.fromJson(jsonDecode(response.body));
  }else if(response.statusCode == 401){
    ToastHelper().makeToastMessage(Texts.notAuthorized);
  }else{
    print("EventTypeService, ${response.statusCode}");
  }
}

Future<ParticipationTypeBase> GetAllParticipationTypes() async{
  String requestUri = "${api.BaseURL}/participation-types";
  return GetRequestParticipationTypes(requestUri);
}

