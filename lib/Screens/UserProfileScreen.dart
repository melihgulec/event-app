import 'dart:convert';

import 'package:event_app/Components/ButtonWithIcon.dart';
import 'package:event_app/Constants/Texts.dart';
import 'package:event_app/Helpers/SizeConfig.dart';
import 'package:event_app/Models/User.dart';
import 'package:event_app/Models/UserFollower.dart';
import 'package:event_app/Screens/ProfileShareScreen.dart';
import 'package:event_app/Services/UserFollowerService.dart';
import 'package:event_app/Services/UserService.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  User user;

  ProfileScreen({
    Key key,
    this.user
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  SharedPreferences _preferences;

  getPrefs()async{
    _preferences = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPrefs();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, value) {
            return [
              CreateAppBar(),
              SliverToBoxAdapter(child: WhiteSpaceVertical()),
              SliverToBoxAdapter(child: CreateProfilePic()),
              SliverToBoxAdapter(child: WhiteSpaceVertical()),
              SliverToBoxAdapter(
                child: Text(
                  "${widget.user.name} ${widget.user.surname}",
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
              ),
              SliverToBoxAdapter(child: WhiteSpaceVertical()),
              SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: CreateFollowBox(),
                )
              ),
              SliverToBoxAdapter(child: WhiteSpaceVertical()),
              SliverToBoxAdapter(
                child: FutureBuilder(
                  future: SharedPreferences.getInstance(),
                  builder: (context, snapshot){
                    if(!snapshot.hasData) return CircularProgressIndicator();
                    if(_preferences.getInt("sessionUserId") == widget.user.id) return SizedBox(width: 0, height: 0,);
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                          height: 55,
                          child: CreateFollowButtons()
                      ),
                    );
                  },
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate.fixed(
                  [
                    TabBar(
                      indicatorColor: Theme.of(context).primaryColor,
                      tabs: [
                        Tab(text: Texts.details),
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
              CreateUserProfileDescription(),
              ProfileShareScreen(),
            ],
          ),
        ),
      )
    );
  }

  SliverAppBar CreateAppBar(){
    return SliverAppBar(
      excludeHeaderSemantics: true,
      floating: true,
      pinned: true,
      title: Text(Texts.userProfile),
    );
  }

  Padding CreateUserProfileDescription(){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.user.profileDescription,
            style: const TextStyle(
              fontSize: 16,
              height: 1.6
            ),
          ),
        ],
      ),
    );
  }

  Column CreateProfilePic(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipOval(
            child: Image(
              image: GetUserImage(widget.user.id),
              fit: BoxFit.cover,
              width: 100,
              height: 100,
            )
        ),
      ],
    );
  }

  Row CreateFollowButtons(){
    return Row(
      children: [
        const Spacer(),
        Expanded(
          flex: 15,
          child: FutureBuilder(
            future: SharedPreferences.getInstance(),
            builder: (context, snapshot){
              if(!snapshot.hasData) return CircularProgressIndicator();
              return FutureBuilder(
                future: GetUserFollows(_preferences.getInt("sessionUserId")),
                builder: (context, AsyncSnapshot<UserFollowerBase> snapshot){
                  bool isUserContain = false;
                  UserFollower follow;

                  if(snapshot.hasData){
                    List<UserFollower> followers = snapshot.data.data;

                    for(int i = 0; i < followers.length; i++){
                      if(followers[i].user.id == widget.user.id){
                        isUserContain = true;
                        follow = followers[i];
                        break;
                      }
                    }
                  }

                  return ButtonWithIcon(
                    title: isUserContain ? Texts.stopFollowing : Texts.follow,
                    hasSuffixIcon: false,
                    prefixIcon: FontAwesomeIcons.userPlus,
                    onPressed: (){
                      setState(() {
                        if(isUserContain){
                          DeleteUserFollow(follow.id);
                        }else{
                          PostUserFollow(_preferences.getInt("sessionUserId"), widget.user.id);
                          GetUserFollowers(widget.user.id);
                        }
                      });
                    },
                  );
                },
              );
            }
          ),
        ),
        const Spacer(),
        Expanded(
          flex: 15,
          child: ButtonWithIcon(
            title: Texts.message,
            hasSuffixIcon: false,
            prefixIcon: FontAwesomeIcons.comment,
            onPressed: (){

            },
          ),
        ),
        const Spacer(),
      ],
    );
  }

  List<Widget> CreateFollowBox(){
    return [
      Column(
        children: [
          FutureBuilder<UserFollowerBase>(
            future: GetUserFollows(widget.user.id),
            builder: (BuildContext context, AsyncSnapshot<UserFollowerBase> snapshot){
              if(!snapshot.hasData) return const CircularProgressIndicator();
              int count = snapshot.data.count;

              return Text(
                count.toString(),
                style: Theme.of(context).textTheme.subtitle1,
              );
            },
          ),
          WhiteSpaceVertical(factor: 1),
          Text(
            "Takip",
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.subtitle2.fontSize,
              color: Theme.of(context).textTheme.caption.color,
            ),
          ),
        ],
      ),
      SizedBox(
        width: SizeConfig.blockSizeHorizontal * 3,
      ),
      Container(
        width: 2,
        height: 45,
        decoration: const BoxDecoration(
          color: Colors.red,
        ),
      ),
      SizedBox(
        width: SizeConfig.blockSizeHorizontal * 3,
      ),
      Column(
        children: [
          FutureBuilder<UserFollowerBase>(
            future: GetUserFollowers(widget.user.id),
            builder: (BuildContext context, AsyncSnapshot<UserFollowerBase> snapshot){
              if(!snapshot.hasData) return const CircularProgressIndicator();

              int count = snapshot.data.count;

              return Text(
                count.toString(),
                style: Theme.of(context).textTheme.subtitle1,
              );
            },
          ),
          WhiteSpaceVertical(factor: 1),
          Text(
            Texts.followers,
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.subtitle2.fontSize,
              color: Theme.of(context).textTheme.caption.color,
            ),
          ),
        ],
      ),
    ];
  }

  SizedBox WhiteSpaceVertical({double factor = 3}){
    return SizedBox(
      height: SizeConfig.blockSizeVertical * factor,
    );
  }
}
