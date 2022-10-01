import 'dart:convert';
import 'dart:io';
import 'package:event_app/Constants/Texts.dart';
import 'package:event_app/Helpers/ToastHelper.dart';
import 'package:event_app/Models/EventCreateDto.dart';
import 'package:event_app/Models/EventFeedComment.dart';
import 'package:event_app/Models/EventSponsor.dart';
import 'package:event_app/Models/SharePost.dart';
import 'package:event_app/Services/EventFeedCommentService.dart';
import 'package:event_app/Services/SponsorsService.dart';
import 'package:event_app/Services/SharePostService.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:event_app/Models/Event.dart';
import 'package:event_app/Constants/API.dart' as api;
import 'package:shared_preferences/shared_preferences.dart';

Future<void> MultiPartRequestEvents(String requestUri, String imagePath) async{
  SharedPreferences _preferences = await SharedPreferences.getInstance();
  String token = _preferences.getString("apiToken");

  Map<String, String> headers = {
    'Content-Type': 'multipart/form-data',
    'Authorization' : 'Bearer $token'
  };

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

Future<void> PutRequestEvent(String requestUri, String body) async{
  SharedPreferences _preferences = await SharedPreferences.getInstance();
  String token = _preferences.getString("apiToken");

  final response = await http.put(
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
    print("EventService, ${response.statusCode}");
  }
}

Future<void> DeleteRequestEvent(String requestUri) async{
  SharedPreferences _preferences = await SharedPreferences.getInstance();
  String token = _preferences.getString("apiToken");

  final response = await http.delete(
      Uri.parse(requestUri),
      headers: {
        "Content-Type": "application/json",
        "Authorization" : "Bearer $token"
      },
  );
  if(response.statusCode == 200){
    Map json = jsonDecode(response.body);
    ToastHelper().makeToastMessage(json["message"]);
  }else if(response.statusCode == 401){
    ToastHelper().makeToastMessage(Texts.notAuthorized);
  }else{
    print("EventService, ${response.statusCode}");
  }
}

Future<EventBase> GetRequestEvents(String requestUri) async{
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
    return EventBase.fromJson(jsonDecode(response.body));
  }else if(response.statusCode == 401){
    ToastHelper().makeToastMessage(Texts.notAuthorized);
  }else{
    print("EventService, ${response.statusCode}");
  }
}

Future<EventBase> GetAllEvents() async{
  String requestUri = "${api.BaseURL}/events";
  return GetRequestEvents(requestUri);
}

Future<EventBase> GetEvent(String eventId) async{
  String requestUri = "${api.BaseURL}/events/$eventId";
  return GetRequestEvents(requestUri);
}

Future<EventSponsorBase> GetEventSponsors(int eventId) async{
  String requestUri = "${api.BaseURL}/events/$eventId/sponsors";
  return GetRequestSponsors(requestUri);
}

Future<EventBase> GetEventsByInterest(String interestId) async{
  String requestUri = "${api.BaseURL}/events/interests/$interestId";
  return GetRequestEvents(requestUri);
}

Future<SharePostBase> GetEventFeed(eventId) async{
  String requestUri = "${api.BaseURL}/events/$eventId/feed";
  return GetRequestSharePost(requestUri);
}

Future<EventFeedCommentBase> GetEventFeedComment(int eventId, int feedId) async{
  String requestUri = "${api.BaseURL}/events/$eventId/feed/$feedId/comments";
  return GetRequestEventFeedComment(requestUri);
}

NetworkImage GetEventImage(int eventId){
  String requestUri = "${api.BaseURL}/events/$eventId/image";
  return NetworkImage(requestUri);
}

void CreateEvent(EventCreateDto event, int userId, File image) async{
  String requestUri = "${api.BaseURL}/events?"
      "name=${event.name}&"
      "description=${event.description}&"
      "address=${event.address}&"
      "startDate=${event.startDate}&"
      "endDate=${event.endDate}&"
      "isOnline=${event.isOnline}&"
      "onlineLink=${event.onlineLink}&"
      "isOver=${event.isOver}&"
      "imagePath=${event.imagePath}&"
      "communityID=${event.communityId}&"
      "eventTypeID=${event.eventTypeId}&"
      "languageID=${event.languageId}&"
      "participationTypeId=${event.participationTypeId}&"
      "cityId=${event.cityId}&"
      "countryId=${event.countryId}&"
      "userID=${userId}&"
      "interestId=${event.interestId}";

  print(requestUri);

  return MultiPartRequestEvents(requestUri, image.path);
}

void UpdateEvent(EventCreateDto updatedEvent, Event event) async{
  String requestUri = "${api.BaseURL}/events/${event.id}";
  String encoded = jsonEncode(updatedEvent);

  return PutRequestEvent(requestUri, encoded);
}

void DeleteEvent(Event event) async{
  String requestUri = "${api.BaseURL}/events/${event.id}";
  return DeleteRequestEvent(requestUri);
}