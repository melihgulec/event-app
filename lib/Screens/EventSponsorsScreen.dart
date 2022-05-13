import 'package:event_app/Models/Event.dart';
import 'package:event_app/Models/EventSponsor.dart';
import 'package:event_app/Services/EventService.dart';
import 'package:flutter/material.dart';
import 'package:event_app/Components/CustomItemTile.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EventSponsorsScreen extends StatelessWidget {
  Event event;

  EventSponsorsScreen({Key key, this.event}) : super(key: key);

  EdgeInsets pagePadding = EdgeInsets.symmetric(horizontal: 16, vertical: 0);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: pagePadding,
      child: FutureBuilder<EventSponsorBase>(
        future: GetEventSponsors(event.id),
        builder: (BuildContext context, AsyncSnapshot<EventSponsorBase> snapshot){
          if(!snapshot.hasData) return Center(child: CircularProgressIndicator(),);
          List<EventSponsor> eventSponsorList = snapshot.data.data;

          if(eventSponsorList.isEmpty) return Center(child: Text("Sponsor bilgisi bulunamadı."),);

          return ListView.separated(
            itemCount: eventSponsorList.length,
            separatorBuilder: (context, index){
              return SizedBox(height: 30,);
            },
            itemBuilder: (context, index){
              EventSponsor item = eventSponsorList[index];

              return CustomItemTile(
                icon: FaIcon(FontAwesomeIcons.c),
                title: item.company.companyName,
                leftBorderColor: Theme.of(context).primaryColor,
              );
            },
          );
        },
      ),
    );
  }
}
