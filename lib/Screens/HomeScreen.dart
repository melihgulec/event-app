import 'package:dynamic_icons/dynamic_icons.dart';
import 'package:event_app/Components/CardBase.dart';
import 'package:event_app/Components/ColoredBar.dart';
import 'package:event_app/Components/ContainerWithTitle.dart';
import 'package:event_app/Constants/RouteNames.dart';
import 'package:event_app/Constants/Texts.dart';
import 'package:event_app/Helpers/SizeConfig.dart';
import 'package:event_app/Models/Community.dart';
import 'package:event_app/Models/Event.dart';
import 'package:event_app/Models/Interest.dart';
import 'package:event_app/Models/User.dart';
import 'package:event_app/Services/CommunityService.dart';
import 'package:event_app/Services/EventService.dart';
import 'package:event_app/Services/InterestsService.dart';
import 'package:event_app/Services/UserService.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  User user;

  HomeScreen({Key key, this.user}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  SharedPreferences _preferences;

  double pageTopPadding = 20;
  double pageBottomPadding = 20;
  double contentHorizontalPadding = 20;
  double contentVerticalPadding = 20;
  double containersSeparatorFactor = 5;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  getPrefs() async{
    _preferences = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      key: scaffoldKey,
      drawer: CreateDrawer(context),
      appBar: CreateAppBar(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.only(bottom: pageBottomPadding),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: pageTopPadding),
                child: SizedBox(
                  height: 40,
                  child: CreateAreasOfInterestList(),
                ),
              ),
              Column(
                children: [
                  WhiteSpaceVertical(factor: 3),
                  ContainerWithTitle(
                    containerTitle: Texts.onlineEvents,
                    containerInteractionText: Texts.all,
                    titlePadding: EdgeInsets.symmetric(horizontal: contentHorizontalPadding),
                    containerIntercationTextOnPressed: () {
                      Navigator.pushNamed(context, eventsListRoute);
                    },
                    child: SizedBox(
                        width: double.infinity,
                        height: 312,
                        child: CreateOnlineEvents()
                    ),
                  ),
                  WhiteSpaceVertical(factor: 5),
                  ContainerWithTitle(
                    containerTitle: Texts.upcomingEvents,
                    containerInteractionText: Texts.all,
                    titlePadding: EdgeInsets.symmetric(horizontal: contentHorizontalPadding),
                    containerIntercationTextOnPressed: () {
                      Navigator.pushNamed(context, eventsListRoute);
                    },
                    child: SizedBox(
                        width: double.infinity,
                        height: 312,
                        child: CreateUpcomingEvents()
                    ),
                  ),
                  WhiteSpaceVertical(factor: 5),
                  ContainerWithTitle(
                    containerTitle: Texts.communities,
                    containerInteractionText: Texts.all,
                    titlePadding: EdgeInsets.symmetric(horizontal: contentHorizontalPadding),
                    containerIntercationTextOnPressed: () {
                      Navigator.pushNamed(context, communityListRoute);
                    },
                    child: SizedBox(
                        width: double.infinity,
                        height: 312,
                        child: CreateCommunitiesList()
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Drawer CreateDrawer(BuildContext context){
    return Drawer(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          CreateDrawerHeader(),
          DrawerHeaderItem(context, FontAwesomeIcons.user, Texts.myProfile, () => Navigator.pushNamed(context, userProfileRoute, arguments: widget.user)),
          DrawerHeaderItem(context, FontAwesomeIcons.comment, Texts.messages, () => Navigator.pushNamed(context, userMessagesRoute, arguments: widget.user)),
          DrawerHeaderItem(context, FontAwesomeIcons.calendar, Texts.events, () => Navigator.pushNamed(context, eventsListRoute)),
          DrawerHeaderItem(context, FontAwesomeIcons.calendarCheck, Texts.createEvent, () => Navigator.pushNamed(context, createEventRoute).then((value) => setState((){}))),
          DrawerHeaderItem(context, FontAwesomeIcons.userGroup, Texts.communities, () => Navigator.pushNamed(context, communityListRoute)),
          DrawerHeaderItem(context, FontAwesomeIcons.userPlus, Texts.createCommunity, () => Navigator.pushNamed(context, createCommunityRoute).then((value) => setState((){}))),
          DrawerHeaderItem(context, FontAwesomeIcons.heart, Texts.areasOfInterest, () => Navigator.pushNamed(context, interestsRoute)),
          //DrawerHeaderItem(context, FontAwesomeIcons.bookmark, Texts.favorites, (){}),
          //DrawerHeaderItem(context, FontAwesomeIcons.wrench, Texts.settings, (){}),
          DrawerHeaderItem(context, FontAwesomeIcons.minus, Texts.logout, () => Navigator.popAndPushNamed(context, loginRoute)),
        ],
      ),
    );
  }

  ListTile DrawerHeaderItem(BuildContext context, IconData icon, String text, Function onTap){
    Color iconColor = Colors.white;
    double iconSize = 20;
    double contentPaddingHorizontal = 32;
    double horizontalTitleGap = 5;
    FontWeight textWeight = FontWeight.w300;
    double fontSize = 16;

    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: contentPaddingHorizontal),
      leading: Icon(
        icon,
        color: iconColor,
        size: iconSize,
      ),
      horizontalTitleGap: horizontalTitleGap,
      title: Text(
        text,
        style: TextStyle(
            fontWeight: textWeight,
            fontSize: fontSize
        ),
      ),
      onTap: onTap
    );
  }

  DrawerHeader CreateDrawerHeader(){
    return DrawerHeader(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            child: CircleAvatar(
              backgroundImage: GetUserImage(widget.user.id),
              radius: 30,
            ),
            onTap: (){
              Navigator.pushNamed(context, userProfileRoute, arguments: widget.user);
            },
          ),
          SizedBox(height: 15,),
          Text(
            "${widget.user.name} ${widget.user.surname}",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
            ),
          ),
        ],
      ),
    );
  }

  AppBar CreateAppBar(){
    return AppBar(
      leading: IconButton(
        padding: EdgeInsets.zero,
        icon: const Icon(FontAwesomeIcons.bars),
        onPressed: () => scaffoldKey.currentState.openDrawer()
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                Texts.location,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const Text(
                "Türkiye",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  FutureBuilder CreateAreasOfInterestList() {
    double seperatorWidth = 20;

    return FutureBuilder<InterestBase>(
      future: GetAllInterests(),
      builder: (context, AsyncSnapshot<InterestBase> snapshot){
        if(!snapshot.hasData) return const CircularProgressIndicator();
        List<Interest> interestList = snapshot.data.data;
        return ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemCount: interestList.length,
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index){
            return SizedBox(width: seperatorWidth,);
          },
          itemBuilder: (context,index){
            Interest item = interestList[index];
            double firstItemLeftPadding = index == 0 ? 20 : 0;
            double lastItemRightPadding = index == interestList.length - 1 ? 20 : 0;

            return Padding(
              padding: EdgeInsets.only(left: firstItemLeftPadding, right: lastItemRightPadding),
              child: ColoredBar(
                icon: DynamicIcons.getIconFromName(item.icon),
                title: item.name,
                backgroundColor: Color(int.parse(item.color)),
                onPressed: (){
                  Navigator.pushNamed(context, eventsListRoute, arguments: item);
                },
              ),
            );
          },
        );
      },
    );
  }

  FutureBuilder CreateOnlineEvents(){
    return FutureBuilder<EventBase>(
      future: GetAllEvents(),
      builder: (BuildContext context, AsyncSnapshot<EventBase> snapshot){
        if(!snapshot.hasData) return const Center(child: SizedBox(width:50, height:50 ,child: CircularProgressIndicator()));
        List<Event> eventList = snapshot.data.data;
        if(eventList.isEmpty) return Center(child: Text(Texts.eventsNotFound));

        return ListView.separated(
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index){
            return const SizedBox(width: 25,);
          },
          physics: const BouncingScrollPhysics(),
          itemCount: eventList.length,
          itemBuilder: (context, index){
            Event item = eventList[index];

            return CardBase(
              width: 280,
              image: GetEventImage(item.id),
              title: item.name,
              address: "${item.city.name}, ${item.country.name}",
              description: item.eventType.name,
              hasFirstBlurredContainer: true,
              hasSecondBlurredContainer: true,
              secondBlurredContainerOnTap: (){

              },
              firstBlurredContainer: [
                Text(
                    "${item.startDate.day}",
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffF0635A)
                    )
                ),
                Text(
                    DateFormat.MMM("tr_TR").format(item.startDate),
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffF0635A)
                    )
                ),
              ],
              secondBlurredContainer: const [
                Icon(FontAwesomeIcons.bookmark, color: Color(0xffF0635A), size: 22,)
              ],
              cardOnTap: (){
                Navigator.pushNamed(context, eventDetailRoute, arguments: item);
              },
            );
          },
        );
      },
    );
  }

  FutureBuilder CreateUpcomingEvents(){
    return FutureBuilder<EventBase>(
      future: GetAllEvents(),
      builder: (BuildContext context, AsyncSnapshot<EventBase> snapshot){
        if(!snapshot.hasData) return const Center(child: SizedBox(width:50, height:50 ,child: CircularProgressIndicator()));
        List<Event> eventList = snapshot.data.data;
        if(eventList.isEmpty) return Center(child: Text(Texts.eventsNotFound));

        eventList.sort((event, event1) => event1.startDate.compareTo(event.startDate));

        return ListView.separated(
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index){
            return const SizedBox(width: 25,);
          },
          physics: const BouncingScrollPhysics(),
          itemCount: eventList.length,
          itemBuilder: (context, index){
            Event item = eventList[index];

            return CardBase(
              width: 280,
              image: GetEventImage(item.id),
              title: item.name,
              address: "${item.city.name}, ${item.country.name}",
              description: item.eventType.name,
              hasFirstBlurredContainer: true,
              hasSecondBlurredContainer: true,
              secondBlurredContainerOnTap: (){
                print("second");
              },
              firstBlurredContainer: [
                Text(
                    "${item.startDate.day}",
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffF0635A)
                    )
                ),
                Text(
                    DateFormat.MMM("tr_TR").format(item.startDate),
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffF0635A)
                    )
                ),
              ],
              secondBlurredContainer: const [
                Icon(FontAwesomeIcons.bookmark, color: Color(0xffF0635A), size: 22,)
              ],
              cardOnTap: (){
                Navigator.pushNamed(context, eventDetailRoute, arguments: item);
              },
            );
          },
        );
      },
    );
  }

  FutureBuilder CreateCommunitiesList(){
    return FutureBuilder<CommunityBase>(
      future: GetAllCommunities(),
      builder: (BuildContext context, AsyncSnapshot<CommunityBase> snapshot){
        if(!snapshot.hasData) return const Center(child: SizedBox(width:50, height:50 ,child: CircularProgressIndicator()));
        List<Community> communityList = snapshot.data.data;
        if(communityList.isEmpty) return Center(child: Text(Texts.communitiesNotFound));

        return ListView.separated(
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index){
            return const SizedBox(width: 25,);
          },
          physics: const BouncingScrollPhysics(),
          itemCount: communityList.length,
          itemBuilder: (context, index){
            Community item = communityList[index];

            return CardBase(
              width: 280,
              image: GetCommunityImage(item.id),
              title: item.name,
              address: "${item.city.name}, ${item.country.name}",
              description: "Kuruluş: ${DateFormat("d MMMM, yyyy","tr_TR").format(item.createdAt)}",
              cardOnTap: (){
                Navigator.pushNamed(context, communityRoute, arguments: item);
              },
            );
          },
        );
      },
    );
  }

  SizedBox WhiteSpaceVertical({double factor = 2}){
    return SizedBox(
      height: SizeConfig.blockSizeVertical * factor,
    );
  }
}
