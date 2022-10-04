import 'package:event_app/Components/ItemTileWithIcon.dart';
import 'package:event_app/Components/ItemTileWithImage.dart';
import 'package:event_app/Constants/RouteNames.dart';
import 'package:event_app/Constants/Texts.dart';
import 'package:event_app/Models/Event.dart';
import 'package:event_app/Models/Interest.dart';
import 'package:event_app/Services/EventService.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

            return ItemTileWithImage(
              description: item.name,
              title: DateFormat("d MMMM, yyyy","tr_TR").format(item.startDate),
              subtitle: item.city.name,
              image: GetEventImage(item.id),
              onTap: (){
                Navigator.pushNamed(context, eventDetailRoute, arguments: item);
              },
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

        if(eventList.isEmpty) return Center(child: Text(Texts.eventsNotFound),);

        return ListView.separated(
          separatorBuilder: (context, index){
            return SizedBox(height: 25,);
          },
          itemCount: eventList.length,
          itemBuilder: (context, index){
            Event item = eventList[index];

            return ItemTileWithImage(
              description: item.name,
              title: DateFormat("d MMMM, yyyy","tr_TR").format(item.startDate),
              subtitle: item.city.name,
              image: GetEventImage(item.id),
              onTap: (){
                Navigator.pushNamed(context, eventDetailRoute, arguments: item);
              },
            );

            /*return CustomItemTile(
              title: item.name,
              icon: FaIcon(FontAwesomeIcons.g),
              onTap: (){
                Navigator.pushNamed(context, eventDetailRoute, arguments: item);
              },
            );*/
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
