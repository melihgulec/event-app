import 'package:event_app/Components/ButtonWithIcon.dart';
import 'package:event_app/Components/WhiteSpaceVertical.dart';
import 'package:event_app/Constants/RolesEnum.dart';
import 'package:event_app/Constants/RouteNames.dart';
import 'package:event_app/Constants/Texts.dart';
import 'package:event_app/Helpers/SizeConfig.dart';
import 'package:event_app/Models/Community.dart';
import 'package:event_app/Models/UserCommunityRoles.dart';
import 'package:event_app/Screens/CommunitySharesScreen.dart';
import 'package:event_app/Services/CommunityService.dart';
import 'package:event_app/Services/UserCommunityRoleService.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommunityScreen extends StatefulWidget {
  Community community;

  CommunityScreen({
    Key key,
    this.community,
  }) : super(key: key);

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  SharedPreferences _preferences;
  bool isAuthorizedRoute = false;

  getPrefs() async{
    _preferences = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserAuthorizeControl();
  }

  Future UserAuthorizeControl() async{
    await getPrefs();

    UserCommunityRoleBase userCommunityRoleBase = await GetAllUserCommunityRoles(_preferences.getInt("sessionUserId"));
    List<UserCommunityRole> userCommunityRole = userCommunityRoleBase.data;

    var isUserAuthorized = userCommunityRole.where((element) => element.user.id == _preferences.getInt("sessionUserId"));

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
                    "${widget.community.name}",
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
                SliverToBoxAdapter(child: WhiteSpaceVertical()),
                SliverToBoxAdapter(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: CreateCommunityInfoBox(),
                  ),
                ),
                SliverToBoxAdapter(child: WhiteSpaceVertical()),
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
                CommunitySharesScreen(community: widget.community,)
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
      title: Text(Texts.community),
      actions: [
        if(isAuthorizedRoute) IconButton(
          icon: Icon(Icons.settings),
          onPressed: (){
            Navigator.pushNamed(context, communitySettingsRoute, arguments: widget.community);
          },
        )
      ],
    );
  }

  SingleChildScrollView CreateUserProfileDescription(){
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.community.description,
              style: const TextStyle(
                  fontSize: 16,
                  height: 1.6
              ),
            ),
          ],
        ),
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
              image: GetCommunityImage(widget.community.id),
              fit: BoxFit.cover,
              width: 100,
              height: 100,
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace stackTrace) {
                return Center(
                  child:const Text('😢', style: TextStyle(fontSize: 75),)
                );
              },
            )
        ),
      ],
    );
  }

  List<Widget> CreateCommunityInfoBox(){
    return [
      /*Column(
        children: [
          Text("0"),
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
      ),*/
      Column(
        children: [
          Text("${widget.community.city.name}"),
          WhiteSpaceVertical(factor: 1),
          Text(
            Texts.location,
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.subtitle2.fontSize,
              color: Theme.of(context).textTheme.caption.color,
            ),
          ),
        ],
      ),
    ];
  }

  Row CreateFollowButtons(){
    return Row(
      children: [
        const Spacer(),
        Expanded(
          flex: 15,
          child: ButtonWithIcon(
            title: Texts.follow,
            hasSuffixIcon: false,
            prefixIcon: FontAwesomeIcons.userPlus,
            onPressed: (){

            },
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
}
