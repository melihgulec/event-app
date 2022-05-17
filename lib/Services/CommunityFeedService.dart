import 'dart:convert';
import 'package:event_app/Constants/Texts.dart';
import 'package:event_app/Helpers/ToastHelper.dart';
import 'package:event_app/Models/CommunityFeedCreateDto.dart';
import 'package:event_app/Models/SharePost.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:event_app/Constants/API.dart' as api;



Future<SharePostBase> GetCommunityFeed(communityId) async{
  String requestUri = "${api.BaseURL}/communities-feed/community/$communityId";
  return GetRequestCommunityFeed(requestUri);
}

Future<SharePostBase> GetRequestCommunityFeed(String requestUri) async{
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
    return SharePostBase.fromJson(jsonDecode(response.body));
  }else if(response.statusCode == 401){
    ToastHelper().makeToastMessage(Texts.notAuthorized);
  }else{
    print("CommunitiesService, ${response.statusCode}");

  }
}

Future<void> PostRequestCommunityFeed(String requestUri, String body) async{
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

Future<void> DeleteRequestCommunityFeed(String requestUri, String body) async{
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
    print("CommunitiesService, ${response.statusCode}");
  }
}

void CreatePost(int communityId, int userId, CommunityFeedCreateDto communityFeedCreateDto){
  String requestUri = "${api.BaseURL}/communities-feed/community/$communityId/user/$userId";
  String encoded = jsonEncode(communityFeedCreateDto);
  PostRequestCommunityFeed(requestUri, encoded);
}

void DeletePost(int postId){
  String requestUri = "${api.BaseURL}/communities-feed/$postId";
  DeleteRequestCommunityFeed(requestUri, null);
}