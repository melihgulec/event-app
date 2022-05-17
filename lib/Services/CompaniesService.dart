import 'dart:convert';

import 'package:event_app/Constants/Texts.dart';
import 'package:event_app/Helpers/ToastHelper.dart';
import 'package:event_app/Models/CompanySponsorships.dart';
import 'package:flutter/material.dart';
import 'package:event_app/Constants/API.dart' as api;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<CompanySponsorshipsBase> GetRequestCompanySponsorships(String requestUri) async{
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
    return CompanySponsorshipsBase.fromJson(jsonDecode(response.body));
  }else if(response.statusCode == 401){
    ToastHelper().makeToastMessage(Texts.notAuthorized);
  }else{
    print("CommunitiesService, ${response.statusCode}");
  }
}

Future<CompanySponsorshipsBase> GetCompanySponsorships(int companyId) async{
  String requestUri = "${api.BaseURL}/companies/$companyId/sponsored-events";
  return GetRequestCompanySponsorships(requestUri);
}

NetworkImage GetCompanyImage(int companyId){
  String requestUri = "${api.BaseURL}/companies/$companyId/image";
  return NetworkImage(requestUri);
}