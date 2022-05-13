import 'dart:convert';
import 'package:event_app/Models/Community.dart';
import 'package:http/http.dart' as http;
import 'package:event_app/Constants/API.dart' as api;

Future<CommunityBase> GetAllCommunities() async{
  String requestUri = "${api.BaseURL}/communities/";
  final response = await http.get(Uri.parse(requestUri));
  if(response.statusCode == 200){
    return CommunityBase.fromJson(jsonDecode(response.body));
  }else{
    throw Exception('data error');
  }
}

Future<CommunityBase> GetCommunity(String communityId) async{
  String requestUri = "${api.BaseURL}/communities/$communityId";
  final response = await http.get(Uri.parse(requestUri));
  if(response.statusCode == 200){
    return CommunityBase.fromJson(jsonDecode(response.body));
  }else{
    throw Exception('data error');
  }
}