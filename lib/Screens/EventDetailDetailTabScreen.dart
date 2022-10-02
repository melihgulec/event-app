import 'package:event_app/Components/ButtonWithIcon.dart';
import 'package:event_app/Components/FlowCard.dart';
import 'package:event_app/Components/ItemTileWithIcon.dart';
import 'package:event_app/Components/WhiteSpaceVertical.dart';
import 'package:event_app/Constants/RouteNames.dart';
import 'package:event_app/Constants/Texts.dart';
import 'package:event_app/Helpers/SizeConfig.dart';
import 'package:event_app/Models/Event.dart';
import 'package:event_app/Models/EventSchedule.dart';
import 'package:event_app/Services/EventScheduleService.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class EventDetailDetailTabScreen extends StatefulWidget {
  Event event;
  bool isAuthorized;

  EventDetailDetailTabScreen({Key key, this.event, this.isAuthorized}) : super(key: key);

  @override
  State<EventDetailDetailTabScreen> createState() => _EventDetailDetailTabScreenState();
}

class _EventDetailDetailTabScreenState extends State<EventDetailDetailTabScreen> {
  EdgeInsets pagePadding = EdgeInsets.symmetric(vertical: 24, horizontal: 24);
  
  navigateEditScheduleScreen(EventSchedule eventSchedule){
    Navigator.pushNamed(context, editEventScheduleRoute, arguments: [eventSchedule, widget.event]).then((value) => setState((){}));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return SingleChildScrollView(
      child: Padding(
        padding: pagePadding,
        child: Column(
          children: [
            SizedBox(
              width: SizeConfig.screenWidth,
              child: Text(
                widget.event.name,
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            WhiteSpaceVertical(),
            ItemTileWithIcon(
              title: DateFormat("d MMMM, yyyy","tr_TR").format(widget.event.startDate),
              subtitle: DateFormat("EEEE", "tr_TR").format(widget.event.startDate),
              icon: FaIcon(FontAwesomeIcons.calendar),
            ),
            WhiteSpaceVertical(),
            ItemTileWithIcon(
              title: Texts.eventAddress,
              subtitle: widget.event.address,
              icon: FaIcon(FontAwesomeIcons.locationDot),
            ),
            WhiteSpaceVertical(),
            ItemTileWithIcon(
              title: Texts.communityOrganizingTheEvent,
              subtitle: widget.event.community.name,
              icon: FaIcon(FontAwesomeIcons.c),
              onTap: (){
                Navigator.pushNamed(context, communityRoute, arguments: widget.event.community);
              },
            ),
            WhiteSpaceVertical(factor: 6),
            SizedBox(
              width: SizeConfig.screenWidth,
              child: Text(
                Texts.aboutEvent,
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            WhiteSpaceVertical(),
            SizedBox(
              width: SizeConfig.screenWidth,
              child: Text(
                widget.event.description,
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.bodyText2.fontSize,
                  height: 1.7
                ),
              ),
            ),
            WhiteSpaceVertical(factor: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  Texts.eventFlow,
                  style: Theme.of(context).textTheme.headline5,
                ),
                if(widget.isAuthorized) ElevatedButton(
                  child: Text(Texts.add, style: TextStyle(color: Colors.white)),
                  onPressed: (){
                    Navigator.pushNamed(context, createEventScheduleRoute, arguments: widget.event).then((value) => setState((){}));
                  },
                )
              ],
            ),
            WhiteSpaceVertical(),
            FutureBuilder<EventScheduleBase>(
              future: GetEventSchedule(widget.event.id),
              builder: (BuildContext context, AsyncSnapshot<EventScheduleBase> snapshot){
                if(!snapshot.hasData) return CircularProgressIndicator();

                List<EventSchedule> eventSchedules = snapshot.data.data;

                if(eventSchedules.length == 0) return Container( width: SizeConfig.screenWidth, child: Text(Texts.schedulesNotFound, textAlign: TextAlign.start,));

                eventSchedules.sort((a, b) => a.startDate.compareTo(b.endDate));

                return ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index){
                    return WhiteSpaceVertical();
                  },
                  shrinkWrap: true,
                  itemCount: eventSchedules.length,
                  itemBuilder: (context, index){
                    EventSchedule eventSchedule = eventSchedules[index];

                    return FlowCard(
                      onTap: (){
                        navigateEditScheduleScreen(eventSchedule);
                      },
                      startDate: eventSchedule.startDate,
                      endDate: eventSchedule.endDate,
                      description: eventSchedule.description
                    );
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }

  SizedBox WhiteSpaceVertical({double factor = 2}){
    return SizedBox(
      height: SizeConfig.blockSizeVertical * factor,
    );
  }
}
