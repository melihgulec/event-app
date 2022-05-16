import 'package:dynamic_icons/dynamic_icons.dart';
import 'package:event_app/Components/CustomItemTile.dart';
import 'package:event_app/Constants/RouteNames.dart';
import 'package:event_app/Constants/Texts.dart';
import 'package:event_app/Models/Interest.dart';
import 'package:event_app/Services/InterestsService.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InterestsScreen extends StatelessWidget {
  InterestsScreen({Key key}) : super(key: key);

  double pagePadding = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CreateAppBar(),
      body: Padding(
        padding: EdgeInsets.all(pagePadding),
        child: FutureBuilder<InterestBase>(
          future: GetAllInterests(),
          builder: (BuildContext context, AsyncSnapshot<InterestBase> snapshot){
            if(!snapshot.hasData) return Center(child: CircularProgressIndicator());
            List<Interest> interestList = snapshot.data.data;

            return ListView.separated(
              separatorBuilder: (context, index){
                return SizedBox(height: 25,);
              },
              itemCount: interestList.length,
              itemBuilder: (context, index){
                Interest item = interestList[index];

                return CustomItemTile(
                  leftBorderColor: Theme.of(context).primaryColor,
                  icon: DynamicIcons.getIconFromName(item.icon),
                  title: item.name,
                  onTap: (){
                    Navigator.pushNamed(context, eventsListRoute, arguments: item);
                  },
                );
              },
            );
          },
        ),
      )
    );
  }

  AppBar CreateAppBar(){
    return AppBar(
      title: Text(Texts.interests),
    );
  }
}
