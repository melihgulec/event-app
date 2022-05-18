import 'package:event_app/Components/ItemTileWithImage.dart';
import 'package:event_app/Constants/RouteNames.dart';
import 'package:event_app/Constants/Texts.dart';
import 'package:event_app/Models/Community.dart';
import 'package:event_app/Services/CommunityService.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommunitiesListScreen extends StatelessWidget {
  CommunitiesListScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CreateAppBar(),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CreateCommunityList(),
      ),
    );
  }

  FutureBuilder CreateCommunityList(){
    return FutureBuilder<CommunityBase>(
      future: GetAllCommunities(),
      builder: (BuildContext context, AsyncSnapshot<CommunityBase> snapshot){
        if(!snapshot.hasData){
          return Center(
            child: Text(Texts.communitiesNotFound),
          );
        }

        List<Community> eventList = snapshot.data.data;

        return ListView.separated(
          separatorBuilder: (context, index){
            return SizedBox(height: 25,);
          },
          itemCount: eventList.length,
          itemBuilder: (context, index){
            Community item = eventList[index];

            return ItemTileWithImage(
              description: item.name,
              title: DateFormat("d MMMM, yyyy","tr_TR").format(item.createdAt),
              subtitle: item.city.name,
              image: GetCommunityImage(item.id),
              onTap: (){
                Navigator.pushNamed(context, communityRoute, arguments: item);
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
    String title = Texts.communities;

    return AppBar(
      title: Text(title),
    );
  }
}
