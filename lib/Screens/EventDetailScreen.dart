import 'package:event_app/Constants/RouteNames.dart';
import 'package:event_app/Constants/Texts.dart';
import 'package:event_app/Helpers/SizeConfig.dart';
import 'package:event_app/Models/Event.dart';
import 'package:event_app/Screens/EventDetailDetailTabScreen.dart';
import 'package:event_app/Screens/EventSharesScreen.dart';
import 'package:event_app/Screens/EventSponsorsScreen.dart';
import 'package:event_app/Services/EventService.dart';
import 'package:flutter/material.dart';

class EventDetailScreen extends StatefulWidget {
  Event event;

  EventDetailScreen({Key key, this.event}) : super(key: key);

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  TabController _tabController;

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
              EventDetailDetailTabScreen(event: widget.event,),
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
        IconButton(
          icon: Icon(Icons.edit),
          onPressed: (){
            Navigator.pushNamed(context, eventEditRoute, arguments: widget.event);
          },
        )
      ],
    );
  }
}
