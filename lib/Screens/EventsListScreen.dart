import 'package:event_app/Components/CustomItemTile.dart';
import 'package:event_app/Constants/Texts.dart';
import 'package:event_app/Models/Event.dart';
import 'package:event_app/Models/Interest.dart';
import 'package:event_app/Services/EventService.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EventsListScreen extends StatefulWidget {
  Interest interest;

  EventsListScreen({Key key, this.interest}) : super(key: key);

  @override
  State<EventsListScreen> createState() => _EventsListScreenState();
}

class _EventsListScreenState extends State<EventsListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CreateAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: widget.interest == null ? CreateEventsList() : CreateEventsListByInterestId()
      ),
    );
  }

  FutureBuilder CreateEventsListByInterestId(){
    return FutureBuilder<EventBase>(
      future: GetEventsByInterest(widget.interest.id.toString()),
      builder: (BuildContext context, AsyncSnapshot<EventBase> snapshot){
        if(!snapshot.hasData){
          return Center(
            child: Text(Texts.eventsNotFound),
          );
        }

        List<Event> eventList = snapshot.data.data;

        return ListView.separated(
          separatorBuilder: (context, index){
            return SizedBox(height: 25,);
          },
          itemCount: eventList.length,
          itemBuilder: (context, index){
            Event item = eventList[index];

            return CustomItemTile(
              title: item.name,
              icon: FaIcon(FontAwesomeIcons.g),
            );
          },
        );
      },
    );
  }

  FutureBuilder CreateEventsList(){
    return FutureBuilder<EventBase>(
      future: GetAllEvents(),
      builder: (BuildContext context, AsyncSnapshot<EventBase> snapshot){
        if(!snapshot.hasData){
          return Center(
            child: Text(Texts.eventsNotFound),
          );
        }

        List<Event> eventList = snapshot.data.data;

        return ListView.separated(
          separatorBuilder: (context, index){
            return SizedBox(height: 25,);
          },
          itemCount: eventList.length,
          itemBuilder: (context, index){
            Event item = eventList[index];

            return CustomItemTile(
              title: item.name,
              icon: FaIcon(FontAwesomeIcons.g),
            );
          },
        );
      },
    );
  }

  AppBar CreateAppBar(){
    String title = widget.interest == null ? Texts.events : "${Texts.events}: ${widget.interest.name}";

    return AppBar(
      title: Text(title),
    );
  }
}
