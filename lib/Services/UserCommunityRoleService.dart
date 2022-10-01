import 'dart:convert';
import 'package:event_app/Constants/Texts.dart';
import 'package:event_app/Helpers/ToastHelper.dart';
import 'package:event_app/Models/EventType.dart';
import 'package:event_app/Models/Language.dart';
import 'package:event_app/Models/UserCommunityRoles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:event_app/Constants/API.dart' as api;
import 'package:http/http.dart' as http;

Future<UserCommunityRoleBase> GetRequestUserCommunityRoles(String requestUri) async{
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
    return UserCommunityRoleBase.fromJson(jsonDecode(response.body));
  }else if(response.statusCode == 401){
    ToastHelper().makeToastMessage(Texts.notAuthorized);
  }else{
    print("LanguageService, ${response.statusCode}");
  }
}

Future<UserCommunityRoleBase> GetAllUserCommunityRoles(int userId) async{
  String requestUri = "${api.BaseURL}/user-community-roles/$userId";
  return GetRequestUserCommunityRoles(requestUri);
}

Future<UserCommunityRoleBase> GetAllUserCommunityRolesByRoleID(int userId, int roleId) async{
  String requestUri = "${api.BaseURL}/user-community-roles/$userId/roles/$roleId";
  return GetRequestUserCommunityRoles(requestUri);
}

Future<UserCommunityRoleBase> GetAllUserCommunityRolesByCommunity(int communityId) async{
  String requestUri = "${api.BaseURL}/user-community-roles/community/$communityId";
  return GetRequestUserCommunityRoles(requestUri);
}
