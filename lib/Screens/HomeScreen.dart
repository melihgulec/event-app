import 'package:event_app/Components/CardBase.dart';
import 'package:event_app/Components/ColoredBar.dart';
import 'package:event_app/Components/ContainerWithTitle.dart';
import 'package:event_app/Constants/Texts.dart';
import 'package:event_app/Helpers/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key key}) : super(key: key);

  var scaffoldKey = GlobalKey<ScaffoldState>();

  double pageTopPadding = 20;
  double pageBottomPadding = 20;
  double contentHorizontalPadding = 20;
  double contentVerticalPadding = 20;
  double containersSeparatorFactor = 5;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      key: scaffoldKey,
      drawer: CreateDrawer(context),
      appBar: CreateAppBar(),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
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
                    child: Container(
                      width: double.infinity,
                      height: 312,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index){
                          return SizedBox(width: 5,);
                        },
                        physics: BouncingScrollPhysics(),
                        itemCount: events.length,
                        itemBuilder: (context, index){
                          return Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: events[index],
                          );
                        },
                      ),
                    ),
                  ),
                  WhiteSpaceVertical(factor: 5),
                  ContainerWithTitle(
                    containerTitle: Texts.upcomingEvents,
                    containerInteractionText: Texts.all,
                    titlePadding: EdgeInsets.symmetric(horizontal: contentHorizontalPadding),
                    child: Container(
                      width: double.infinity,
                      height: 312,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index){
                          return SizedBox(width: 5,);
                        },
                        physics: BouncingScrollPhysics(),
                        itemCount: events.length,
                        itemBuilder: (context, index){
                          return Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: events[index],
                          );
                        },
                      ),
                    ),
                  ),
                  WhiteSpaceVertical(factor: 5),
                  ContainerWithTitle(
                    containerTitle: Texts.communities,
                    containerInteractionText: Texts.all,
                    titlePadding: EdgeInsets.symmetric(horizontal: contentHorizontalPadding),
                    child: Container(
                      width: double.infinity,
                      height: 312,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index){
                          return SizedBox(width: 5,);
                        },
                        physics: BouncingScrollPhysics(),
                        itemCount: events.length,
                        itemBuilder: (context, index){
                          return Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: events[index],
                          );
                        },
                      ),
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

  List<Widget> events = [
    CardBase(
      width: 250,
      imagePath: "assets/images/mocks/muhtar1.jpg",
      title: "Uluslararası etkinlik düzenlenecektir",
      address: "İşcan Sk. No:5, Osmangazi/Bursa",
      description: "+20 Gidiyor",
      hasFirstBlurredContainer: true,
      hasSecondBlurredContainer: true,
      secondBlurredContainerOnTap: (){
        print("second");
      },
      firstBlurredContainer: [
        Text(
            "5",
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xffF0635A)
            )
        ),
        Text(
            "EYL",
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color(0xffF0635A)
            )
        ),
      ],
      secondBlurredContainer: [
        Icon(FontAwesomeIcons.bookmark, color: Color(0xffF0635A), size: 22,)
      ],
    ),
    CardBase(
      width: 250,
      imagePath: "assets/images/mocks/muhtar2.jpg",
      title: "Uluslararası etkinlik düzenlenecektir",
      address: "İşcan Sk. No:5, Osmangazi/Bursa",
      description: "+20 Gidiyor",
      hasFirstBlurredContainer: true,
      hasSecondBlurredContainer: true,
      firstBlurredContainer: [
        Text(
            "5",
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xffF0635A)
            )
        ),
        Text(
            "EYL",
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color(0xffF0635A)
            )
        ),
      ],
      secondBlurredContainer: [
        Icon(FontAwesomeIcons.bookmark, color: Color(0xffF0635A), size: 22,)
      ],
    ),
    CardBase(
      width: 250,
      imagePath: "assets/images/mocks/muhtar3.jpg",
      title: "Uluslararası etkinlik düzenlenecektir",
      address: "İşcan Sk. No:5, Osmangazi/Bursa",
      description: "+20 Gidiyor",
      descriptionColor: Colors.red,
    ),
    CardBase(
      width: 250,
      imagePath: "assets/images/mocks/muhtar1.jpg",
      title: "Uluslararası etkinlik düzenlenecektir",
      address: "İşcan Sk. No:5, Osmangazi/Bursa",
      description: "+20 Gidiyor",
      hasFirstBlurredContainer: true,
      hasSecondBlurredContainer: true,
      firstBlurredContainer: [
        Text(
            "5",
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xffF0635A)
            )
        ),
        Text(
            "EYL",
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color(0xffF0635A)
            )
        ),
      ],
      secondBlurredContainer: [
        Icon(FontAwesomeIcons.bookmark, color: Color(0xffF0635A), size: 22,)
      ],
    ),
    CardBase(
      width: 250,
      imagePath: "assets/images/mocks/muhtar2.jpg",
      title: "Uluslararası etkinlik düzenlenecektir",
      address: "İşcan Sk. No:5, Osmangazi/Bursa",
      description: "+20 Gidiyor",
      hasFirstBlurredContainer: true,
      hasSecondBlurredContainer: true,
      firstBlurredContainer: [
        Text(
            "5",
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xffF0635A)
            )
        ),
        Text(
            "EYL",
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color(0xffF0635A)
            )
        ),
      ],
      secondBlurredContainer: [
        Icon(FontAwesomeIcons.bookmark, color: Color(0xffF0635A), size: 22,)
      ],
    ),
    CardBase(
      width: 250,
      imagePath: "assets/images/mocks/muhtar3.jpg",
      title: "Uluslararası etkinlik düzenlenecektir",
      address: "İşcan Sk. No:5, Osmangazi/Bursa",
      description: "+20 Gidiyor",
      descriptionColor: Colors.red,
    ),
    CardBase(
      width: 250,
      imagePath: "assets/images/mocks/muhtar1.jpg",
      title: "Uluslararası etkinlik düzenlenecektir",
      address: "İşcan Sk. No:5, Osmangazi/Bursa",
      description: "+20 Gidiyor",
      hasFirstBlurredContainer: true,
      hasSecondBlurredContainer: true,
      firstBlurredContainer: [
        Text(
            "5",
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xffF0635A)
            )
        ),
        Text(
            "EYL",
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color(0xffF0635A)
            )
        ),
      ],
      secondBlurredContainer: [
        Icon(FontAwesomeIcons.bookmark, color: Color(0xffF0635A), size: 22,)
      ],
    ),
    CardBase(
      width: 250,
      imagePath: "assets/images/mocks/muhtar2.jpg",
      title: "Uluslararası etkinlik düzenlenecektir",
      address: "İşcan Sk. No:5, Osmangazi/Bursa",
      description: "+20 Gidiyor",
      hasFirstBlurredContainer: true,
      hasSecondBlurredContainer: true,
      firstBlurredContainer: [
        Text(
            "5",
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xffF0635A)
            )
        ),
        Text(
            "EYL",
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color(0xffF0635A)
            )
        ),
      ],
      secondBlurredContainer: [
        Icon(FontAwesomeIcons.bookmark, color: Color(0xffF0635A), size: 22,)
      ],
    ),
    CardBase(
      width: 250,
      imagePath: "assets/images/mocks/muhtar3.jpg",
      title: "Uluslararası etkinlik düzenlenecektir",
      address: "İşcan Sk. No:5, Osmangazi/Bursa",
      description: "+20 Gidiyor",
      descriptionColor: Colors.red,
    ),
  ];

  Drawer CreateDrawer(BuildContext context){
    return Drawer(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          CreateDrawerHeader(),
          DrawerHeaderItem(context, FontAwesomeIcons.user, Texts.myProfile, (){}),
          DrawerHeaderItem(context, FontAwesomeIcons.comment, Texts.messages, (){}),
          DrawerHeaderItem(context, FontAwesomeIcons.calendar, Texts.events, (){}),
          DrawerHeaderItem(context, FontAwesomeIcons.heart, Texts.areasOfInterest, (){}),
          DrawerHeaderItem(context, FontAwesomeIcons.bookmark, Texts.favorites, (){}),
          DrawerHeaderItem(context, FontAwesomeIcons.wrench, Texts.settings, (){}),
          DrawerHeaderItem(context, FontAwesomeIcons.question, Texts.help, (){}),
          DrawerHeaderItem(context, FontAwesomeIcons.minus, Texts.logout, (){}),
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
      margin: EdgeInsets.only(bottom: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          CircleAvatar(
            backgroundImage: AssetImage("assets/images/mocks/muhtar1.jpg"),
            radius: 30,
          ),
          SizedBox(height: 15,),
          Text(
            "Melih GÜLEÇ",
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

  ListView CreateAreasOfInterestList() {

    List<Widget> interests = [
      ColoredBar(
        icon: FontAwesomeIcons.personRunning,
        title: "Spor",
        backgroundColor: Colors.red,
        onPressed: (){},
      ),
      ColoredBar(
        icon: FontAwesomeIcons.music,
        title: "Müzik",
        backgroundColor: Color(0xffF59762),
        onPressed: (){},
      ),
      ColoredBar(
        icon: FontAwesomeIcons.utensils,
        title: "Yemek",
        backgroundColor: Color(0xff29D697),
        onPressed: (){},
      ),
      ColoredBar(
        icon: FontAwesomeIcons.paintbrush,
        title: "Sanat",
        backgroundColor: Color(0xff46CDFB),
        onPressed: (){},
      ),
    ];

    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemCount: interests.length,
      scrollDirection: Axis.horizontal,
      separatorBuilder: (context, index){
        return SizedBox(width: 10,);
      },
      itemBuilder: (context,index){
        return Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: interests[index],
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
