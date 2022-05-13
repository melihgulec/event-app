import 'package:event_app/Components/CustomListTile.dart';
import 'package:event_app/Constants/Texts.dart';
import 'package:event_app/Helpers/SizeConfig.dart';
import 'package:event_app/Models/Event.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class EventDetailDetailTabScreen extends StatelessWidget {
  Event event;

  EventDetailDetailTabScreen({Key key, this.event}) : super(key: key);

  EdgeInsets pagePadding = EdgeInsets.symmetric(vertical: 24, horizontal: 24);

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
                event.name,
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            WhiteSpaceVertical(),
            CustomItemTile(
              title: DateFormat("d MMMM, yyyy","tr_TR").format(event.startDate),
              subtitle: DateFormat("EEEE, H:mm:ss", "tr_TR").format(event.startDate),
              icon: FontAwesomeIcons.calendar,
            ),
            WhiteSpaceVertical(),
            CustomItemTile(
              title: Texts.eventAddress,
              subtitle: event.address,
              icon: FontAwesomeIcons.locationDot,
            ),
            WhiteSpaceVertical(),
            CustomItemTile(
              title: Texts.communityOrganizingTheEvent,
              subtitle: event.communityName,
              icon: FontAwesomeIcons.c,
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
                event.description,
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.bodyText2.fontSize,
                  height: 1.7
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox WhiteSpaceVertical({double factor = 4}){
    return SizedBox(
      height: SizeConfig.blockSizeVertical * factor,
    );
  }
}