import 'package:event_app/Components/ItemTileWithImage.dart';
import 'package:event_app/Components/WhiteSpaceVertical.dart';
import 'package:event_app/Constants/RouteNames.dart';
import 'package:event_app/Models/Company.dart';
import 'package:event_app/Models/CompanySponsorships.dart';
import 'package:event_app/Models/Event.dart';
import 'package:event_app/Services/CompaniesService.dart';
import 'package:event_app/Services/EventService.dart';
import 'package:flutter/material.dart';

class CompanySponsorshipsScreen extends StatelessWidget {
  Company company;

  CompanySponsorshipsScreen({
    Key key,
    this.company
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: GetCompanySponsorships(company.id),
      builder: (BuildContext context, AsyncSnapshot<CompanySponsorshipsBase> snapshot){
        if(!snapshot.hasData) return Center(child: CircularProgressIndicator());

        List<Datum> eventList = snapshot.data.data;

        return ListView.separated(
          separatorBuilder: (context, index) => WhiteSpaceVertical(factor: 3,),
          itemCount: eventList.length,
          itemBuilder: (context, index){
            Event item = eventList[index].event;
            return ItemTileWithImage(
              image: GetEventImage(item.id),
              description: item.name,
              onTap: (){
                Navigator.pushNamed(context, eventDetailRoute, arguments: item);
              },
            );
          },
        );
      },
    );
  }
}
