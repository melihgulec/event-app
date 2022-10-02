import 'package:event_app/Components/WhiteSpaceVertical.dart';
import 'package:event_app/Constants/RouteNames.dart';
import 'package:event_app/Constants/Texts.dart';
import 'package:event_app/Models/Community.dart';
import 'package:flutter/material.dart';

class CommunitySettingsScreen extends StatefulWidget {
  Community community;

  CommunitySettingsScreen({Key key, this.community}) : super(key: key);

  @override
  State<CommunitySettingsScreen> createState() => _CommunitySettingsScreenState();
}

class _CommunitySettingsScreenState extends State<CommunitySettingsScreen> {

  void navigateCommunityEditScreen(){
    Navigator.pushNamed(context, communityEditRoute, arguments: widget.community).then((value) => setState((){}));
  }

  void navigateCommunityAuthorizationScreen(){
    Navigator.pushNamed(context, communityUserAuthorizationRoute, arguments: widget.community).then((value) => setState((){}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CreateAppBar(),
      body: Column(
        children: [
          Card(
            child: ListTile(
              onTap: navigateCommunityEditScreen,
              leading: Icon(Icons.edit, color: Colors.white,),
              title: Text(Texts.editCommunity),
            ),
          ),
          WhiteSpaceVertical(),
          Card(
            child: ListTile(
              onTap: navigateCommunityAuthorizationScreen,
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
      title: Text(Texts.communitySettings),
    );
  }
}
