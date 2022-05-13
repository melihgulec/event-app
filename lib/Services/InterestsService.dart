import 'dart:convert';
import 'package:event_app/Models/Interest.dart';
import 'package:http/http.dart' as http;
import 'package:event_app/Constants/API.dart' as api;

Future<InterestBase> GetAllInterests() async{
  String requestUri = "${api.BaseURL}/interests/";
  final response = await http.get(Uri.parse(requestUri));
  if(response.statusCode == 200){
    return InterestBase.fromJson(jsonDecode(response.body));
  }else{
    throw Exception('data error');
  }
}