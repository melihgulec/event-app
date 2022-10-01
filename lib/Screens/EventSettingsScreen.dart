import 'package:event_app/Components/WhiteSpaceVertical.dart';
import 'package:event_app/Constants/RouteNames.dart';
import 'package:event_app/Constants/Texts.dart';
import 'package:event_app/Models/Event.dart';
import 'package:flutter/material.dart';

class EventSettingsScreen extends StatefulWidget {
  Event event;

  EventSettingsScreen({Key key, this.event}) : super(key: key);

  @override
  State<EventSettingsScreen> createState() => _EventSettingsScreenState();
}

class _EventSettingsScreenState extends State<EventSettingsScreen> {

  void navigateEventEditScreen(){
    Navigator.pushNamed(context, eventEditRoute, arguments: widget.event).then((value) => setState((){}));
  }

  void navigateUserAuthorizationScreen(){
    Navigator.pushNamed(context, eventUserAuthorizationRoute, arguments: widget.event).then((value) => setState((){}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CreateAppBar(),
      body: Column(
        children: [
          Card(
            child: ListTile(
              onTap: navigateEventEditScreen,
              leading: Icon(Icons.edit, color: Colors.white,),
              title: Text(Texts.editEvent),
            ),
          ),
          WhiteSpaceVertical(),
          Card(
            child: ListTile(
              onTap: navigateUserAuthorizationScreen,
              leading: Icon(Icons.key, color: Colors.white,),
              title: Text(Texts.setAuthorize),
            ),
          ),
        ],
      ),
    );
  }

  AppBar CreateAppBar(){
    return AppBar(
      title: Text(Texts.eventSettings),
    );
  }
}
