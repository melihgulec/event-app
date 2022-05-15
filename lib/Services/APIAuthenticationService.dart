import 'dart:convert';
import 'package:event_app/Helpers/ToastHelper.dart';
import 'package:event_app/Models/User.dart';
import 'package:event_app/Constants/API.dart' as api;
import 'package:http/http.dart' as http;

Future<UserBase> UserLogin(String mail, String password) async{
  String requestUri = "${api.BaseURL}/users/authenticate";


  Map data = {
    "email" : mail,
    "password" : password,
  };

    final response = await http.post(
      Uri.parse(requestUri),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );

    var decodedBody = jsonDecode(response.body);

    if(response.statusCode == 200){
      return UserBase.fromJson(decodedBody);
    }
    else{
      ToastHelper().makeToastMessage(decodedBody.message);
      return null;
    }
}