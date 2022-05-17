import 'dart:convert';
import 'dart:io';
import 'package:event_app/Constants/Texts.dart';
import 'package:event_app/Helpers/ToastHelper.dart';
import 'package:event_app/Models/Community.dart';
import 'package:event_app/Models/CommunityCreateDto.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:event_app/Constants/API.dart' as api;
import 'package:shared_preferences/shared_preferences.dart';

Future<CommunityBase> GetRequestCommunities(String requestUri) async{
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
    return CommunityBase.fromJson(jsonDecode(response.body));
  }else if(response.statusCode == 401){
    ToastHelper().makeToastMessage(Texts.notAuthorized);
  }else{
    print("CommunitiesService, ${response.statusCode}");
  }
}

Future<void> MultiPartRequestCommunities(String requestUri, Map<String, String> body, String imagePath) async{
  SharedPreferences _preferences = await SharedPreferences.getInstance();
  String token = _preferences.getString("apiToken");

  Map<String, String> headers = {
    'Content-Type': 'multipart/form-data',
    'Authorization' : 'Bearer $token'
  };

  print(body);
  print(requestUri);

  final request = await http.MultipartRequest(
    'POST',
    Uri.parse(requestUri)
   )
    ..headers.addAll(headers)
    ..files.add(await http.MultipartFile.fromPath('files', imagePath));

  var response = await request.send();

  if(response.statusCode == 200){
    ToastHelper().makeToastMessage("Başarılı");
  }else if(response.statusCode == 401){
    ToastHelper().makeToastMessage(Texts.notAuthorized);
  }else{
    var responseString = await response.stream.bytesToString();
    final decodedMap = json.decode(responseString);
    print(decodedMap);

    print("CommunitiesService, ${response.statusCode}");
  }
}

Future<void> PostRequestCommunities(String requestUri, String body) async{
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
    print("CommunitiesService, ${response.statusCode}");
  }
}

Future<CommunityBase> GetAllCommunities() async{
  String requestUri = "${api.BaseURL}/communities/";
  return GetRequestCommunities(requestUri);
}

Future<CommunityBase> GetCommunity(String communityId) async{
  String requestUri = "${api.BaseURL}/communities/$communityId";
  return GetRequestCommunities(requestUri);
}

void CreateCommunity(CommunityCreateDto communityCreateDto, File image) async{
  String requestUri = "${api.BaseURL}/communities?name=${communityCreateDto.name}&cityId=${communityCreateDto.cityId}&countryId=${communityCreateDto.countryId}&description=${communityCreateDto.description}&imagePath=${communityCreateDto.imagePath}";
  //Map<String, dynamic> body = jsonDecode(jsonEncode(communityCreateDto));

  Map<String, String> body = {
    "name" : communityCreateDto.name.toString(),
    "description": communityCreateDto.description.toString(),
    "imagePath": communityCreateDto.imagePath.toString(),
    "countryId": communityCreateDto.countryId.toString(),
    "cityId": communityCreateDto.cityId.toString()
  };

  return MultiPartRequestCommunities(requestUri, body, image.path);
}

NetworkImage GetCommunityImage(int comunityId){
  String requestUri = "${api.BaseURL}/communities/$comunityId/image";
  return NetworkImage(requestUri);
}