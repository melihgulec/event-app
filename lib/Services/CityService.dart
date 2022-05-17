import 'dart:convert';
import 'package:event_app/Constants/Texts.dart';
import 'package:event_app/Helpers/ToastHelper.dart';
import 'package:event_app/Models/City.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:event_app/Constants/API.dart' as api;
import 'package:http/http.dart' as http;

Future<CityBase> GetRequestCities(String requestUri) async{
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
    return CityBase.fromJson(jsonDecode(response.body));
  }else if(response.statusCode == 401){
    ToastHelper().makeToastMessage(Texts.notAuthorized);
  }else{
    print("CityService, ${response.statusCode}");
  }
}

Future<CityBase> GetAllCitiesByCountryId(int countryId) async{
  String requestUri = "${api.BaseURL}/countries/$countryId/cities";
  return GetRequestCities(requestUri);
}

