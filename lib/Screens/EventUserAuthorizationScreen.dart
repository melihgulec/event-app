import 'package:event_app/Components/ButtonWithIcon.dart';
import 'package:event_app/Components/TextFieldWithIcon.dart';
import 'package:event_app/Components/WhiteSpaceVertical.dart';
import 'package:event_app/Constants/Texts.dart';
import 'package:event_app/Helpers/SizeConfig.dart';
import 'package:event_app/Helpers/ToastHelper.dart';
import 'package:event_app/Models/Event.dart';
import 'package:event_app/Models/Role.dart';
import 'package:event_app/Services/RoleService.dart';
import 'package:event_app/Services/UsersEventsRoleService.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventUserAuthorizationScreen extends StatefulWidget {
  Event event;

  EventUserAuthorizationScreen({Key key, this.event}) : super(key: key);

  @override
  State<EventUserAuthorizationScreen> createState() =>
      _EventUserAuthorizationScreenState();
}

class _EventUserAuthorizationScreenState extends State<EventUserAuthorizationScreen> {
  EdgeInsets pagePadding = EdgeInsets.all(8);
  SharedPreferences _preferences;

  TextEditingController userEmail = TextEditingController(text: '');

  String roleDropdownValue = '1';

  void SendRole() {
    if(userEmail.text.isNotEmpty && roleDropdownValue.isNotEmpty){
      PostEventRole(widget.event.id, userEmail.text, int.parse(roleDropdownValue));
    }else{
      ToastHelper().makeToastMessage(Texts.allFieldsMustBeFilled);
    }
  }

  void getPrefs() async{
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
      appBar: CreateAppBar(),
      body: Padding(
        padding: pagePadding,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(Texts.eventAuthorizationScreenDescription),
                  WhiteSpaceVertical(),
                  TextFieldWithIcon(
                    prefixIcon: Icons.description,
                    placeholder: Texts.mailPlaceholder,
                    controller: userEmail,
                  ),
                  WhiteSpaceVertical(),
                  Container(
                    width: SizeConfig.screenWidth,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: CreateRoleDropdown(),
                  ),
                ],
              ),
            ),
            WhiteSpaceVertical(),
            ButtonWithIcon(title: Texts.save, onPressed: SendRole),
          ],
        ),
      ),
    );
  }

  FutureBuilder CreateRoleDropdown() {
    return FutureBuilder<RoleBase>(
      future: GetRoles(),
      builder: (BuildContext context, AsyncSnapshot<RoleBase> snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());

        List<Role> roleList = snapshot.data.data;

        return DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            selectedItemBuilder: (_) {
              return roleList
                  .map((e) => Container(
                        alignment: Alignment.center,
                        child: Text(
                          e.description,
                          style: TextStyle(color: Colors.black),
                        ),
                      ))
                  .toList();
            },
            hint: Text(
              "Rol seç",
              style: TextStyle(color: Colors.black),
            ),
            icon: Icon(
              Icons.arrow_downward,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            value: roleDropdownValue,
            elevation: 16,
            onChanged: (String newValue) {
              setState(() {
                roleDropdownValue = newValue;
              });
            },
            items: roleList.map((Role item) {
              return DropdownMenuItem<String>(
                value: item.id.toString(),
                child: Text(
                  item.description,
                  style: const TextStyle(color: Colors.white),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  AppBar CreateAppBar() {
    return AppBar(
      title: Text(Texts.setAuthorize),
    );
  }
}
