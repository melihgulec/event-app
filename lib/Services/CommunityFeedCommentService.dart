import 'dart:convert';

import 'package:event_app/Constants/Texts.dart';
import 'package:event_app/Helpers/ToastHelper.dart';
import 'package:event_app/Models/CommunityFeedComment.dart';
import 'package:event_app/Models/CommunityFeedCommentCreateDto.dart';
import 'package:event_app/Services/CommunityFeedService.dart';
import 'package:http/http.dart' as http;
import 'package:event_app/Constants/API.dart' as api;
import 'package:shared_preferences/shared_preferences.dart';

Future<CommunityFeedCommentBase> GetRequestCommunityFeedComments(String requestUri) async{
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
    return CommunityFeedCommentBase.fromJson(jsonDecode(response.body));
  }else if(response.statusCode == 401){
    ToastHelper().makeToastMessage(Texts.notAuthorized);
  }else{
    print("CommunitiesService, ${response.statusCode}");
  }
}

Future<CommunityFeedCommentBase> GetCommunityFeedComments(int postId) async{
  String requestUri = "${api.BaseURL}/communities-feed/$postId/comments";
  return GetRequestCommunityFeedComments(requestUri);
}

void CreateComment(int postId, CommunityFeedCommentCreateDto commentCreateDto){
  String requestUri = "${api.BaseURL}/communities-feed/${postId}/comments";
  String encoded = jsonEncode(commentCreateDto);
  PostRequestCommunityFeed(requestUri, encoded);
}

void DeleteComment(int postId, int commentId){
  String requestUri = "${api.BaseURL}/communities-feed/${postId}/comments/$commentId";
  DeleteRequestCommunityFeed(requestUri, null);
}