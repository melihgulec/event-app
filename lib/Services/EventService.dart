import 'dart:convert';
import 'package:event_app/Models/EventSponsor.dart';
import 'package:http/http.dart' as http;
import 'package:event_app/Models/Event.dart';
import 'package:event_app/Constants/API.dart' as api;

Future<EventBase> GetAllEvents() async{
  String requestUri = "${api.BaseURL}/events/";
  final response = await http.get(Uri.parse(requestUri));
  if(response.statusCode == 200){
    return EventBase.fromJson(jsonDecode(response.body));
  }else{
    throw Exception('data error');
  }
}

Future<EventBase> GetEvent(String eventId) async{
  String requestUri = "${api.BaseURL}/events/$eventId";
  final response = await http.get(Uri.parse(requestUri));
  if(response.statusCode == 200){
    return EventBase.fromJson(jsonDecode(response.body));
  }else{
    throw Exception('data error');
  }
}

Future<EventSponsorBase> GetEventSponsors(int eventId) async{
  String requestUri = "${api.BaseURL}/events/$eventId/sponsors";
  final response = await http.get(Uri.parse(requestUri));
  if(response.statusCode == 200){
    return EventSponsorBase.fromJson(jsonDecode(response.body));
  }else{
    throw Exception('data error');
  }
}