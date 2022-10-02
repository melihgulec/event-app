import 'package:event_app/Constants/RolesEnum.dart';
import 'package:event_app/Constants/RouteNames.dart';
import 'package:event_app/Constants/Texts.dart';
import 'package:event_app/Helpers/SizeConfig.dart';
import 'package:event_app/Models/Event.dart';
import 'package:event_app/Models/UserEventRoles.dart';
import 'package:event_app/Screens/EventDetailDetailTabScreen.dart';
import 'package:event_app/Screens/EventSharesScreen.dart';
import 'package:event_app/Screens/EventSponsorsScreen.dart';
import 'package:event_app/Services/EventService.dart';
import 'package:event_app/Services/UsersEventsRoleService.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventDetailScreen extends StatefulWidget {
  Event event;

  EventDetailScreen({Key key, this.event}) : super(key: key);

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  TabController _tabController;
  SharedPreferences _preferences;
  bool isAuthorizedRoute = false;

  getPrefs() async{
    _preferences = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    getPrefs();
    // TODO: implement initState
    super.initState();
    UserAuthorizeControl();
  }

  Future UserAuthorizeControl() async{
    UserEventRoleBase userEventRoleBase = await GetEventRoles(widget.event.id);
    List<UserEventRole> userEventRole = userEventRoleBase.data;

    var isUserAuthorized = userEventRole.where((element) => element.user.id == _preferences.getInt("sessionUserId"));

    if(isUserAuthorized.length > 0 && (isUserAuthorized.first.role.id == RolesEnum.yonetici.name || isUserAuthorized.first.role.id == RolesEnum.organizator.name)){
      setState(() {
        isAuthorizedRoute = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          headerSliverBuilder: (context, value) {
            return [
              CreateAppBar(),
              SliverToBoxAdapter(
                child: Image(
                  image: GetEventImage(widget.event.id),
                  fit: BoxFit.cover,
                  height: 244,
                  width: SizeConfig.screenWidth,
                )
              ),
              SliverList(
                  delegate: SliverChildListDelegate.fixed(
                    [
                      TabBar(
                        indicatorColor: Theme.of(context).primaryColor,
                        tabs: [
                          Tab(text: Texts.details),
                          Tab(text: Texts.sponsors),
                          Tab(text: Texts.shares),
                        ],
                      ),
                    ],
                  ),
                ),
            ];
          },
          body: TabBarView(
            children: [
              EventDetailDetailTabScreen(event: widget.event, isAuthorized: isAuthorizedRoute),
              EventSponsorsScreen(event: widget.event,),
              EventSharesScreen(event: widget.event,),
            ],
          ),
        ),
      ),
    );
  }

  SliverAppBar CreateAppBar(){
    return SliverAppBar(
      excludeHeaderSemantics: true,
      floating: true,
      pinned: true,
      title: Text(Texts.eventDetails),
      actions: [
        if(isAuthorizedRoute) IconButton(
          icon: Icon(Icons.settings),
          onPressed: (){
            Navigator.pushNamed(context, eventSettingsRoute, arguments: widget.event).then((value) => setState((){}));
            //Navigator.pushNamed(context, eventEditRoute, arguments: widget.event).then((value) => setState((){}));
          },
        )
      ],
    );
  }
}
