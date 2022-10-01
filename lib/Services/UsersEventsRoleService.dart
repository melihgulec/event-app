import 'dart:convert';
import 'package:event_app/Constants/Texts.dart';
import 'package:event_app/Helpers/ToastHelper.dart';
import 'package:event_app/Models/EventType.dart';
import 'package:event_app/Models/Language.dart';
import 'package:event_app/Models/UserCommunityRoles.dart';
import 'package:event_app/Models/UserEventRoles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:event_app/Constants/API.dart' as api;
import 'package:http/http.dart' as http;

Future<UserEventRoleBase> GetRequestUserEventRoles(String requestUri) async{
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
    return UserEventRoleBase.fromJson(jsonDecode(response.body));
  }else if(response.statusCode == 401){
    ToastHelper().makeToastMessage(Texts.notAuthorized);
  }else{
    print("UserEventsRoleService, ${response.statusCode}");
  }
}

Future<UserEventRoleBase> PostRequestUserEventRoles(String requestUri) async{
  SharedPreferences _preferences = await SharedPreferences.getInstance();
  String token = _preferences.getString("apiToken");

  final response = await http.post(
      Uri.parse(requestUri),
      headers: {
        "Content-Type": "application/json",
        "Authorization" : "Bearer $token"
      },
  );

  var body = jsonDecode(response.body);

  if(response.statusCode == 200){
    ToastHelper().makeToastMessage(body['message']);
  }else if(response.statusCode == 401){
    ToastHelper().makeToastMessage(Texts.notAuthorized);
  }else{
    ToastHelper().makeToastMessage(body['message']);
    print("UserEventsRoleService, ${response.statusCode}");
  }
}

Future<UserEventRoleBase> GetEventRoles(int eventId) async{
  String requestUri = "${api.BaseURL}/user-event-roles/$eventId";
  return GetRequestUserEventRoles(requestUri);
}

Future<UserEventRoleBase> PostEventRole(int eventId, String userEmail, int roleId) async{
  String requestUri = "${api.BaseURL}/user-event-roles/${eventId}/user/${userEmail}/role/${roleId}";
  return PostRequestUserEventRoles(requestUri);
}
