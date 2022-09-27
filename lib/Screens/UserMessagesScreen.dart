import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app/Constants/RouteNames.dart';
import 'package:event_app/Constants/Texts.dart';
import 'package:event_app/Models/User.dart';
import 'package:event_app/Services/UserService.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserMessagesScreen extends StatefulWidget {
  User user;

  UserMessagesScreen({
    Key key,
    this.user,
  }) : super(key: key);

  @override
  State<UserMessagesScreen> createState() => _UserMessagesScreenState();
}

class _UserMessagesScreenState extends State<UserMessagesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CreateAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
          .collection("chatRooms")
          .snapshots(),
          builder: (context, snapshot){
            if(!snapshot.hasData) return const Center(child: CircularProgressIndicator(),);
            List<DocumentSnapshot> items = snapshot.data.docs;

            Map<String, Map<String, String>> test = {};

            items.forEach((element){
              List<String> split = element["roomId"].toString().split('_');

              if(split[0] == widget.user.id.toString()){
                test.putIfAbsent(element["roomId"].toString(), () => {"peer" : split[1]});
              }else if(split[1] == widget.user.id.toString()){
                test.putIfAbsent(element["roomId"].toString(), () => {"peer" : split[0]});
              }
            });

            var conversations = test.entries.toList();

            return ListView.separated(
              itemCount: conversations.length,
              separatorBuilder: (context, index) => const SizedBox(height: 25,),
              itemBuilder: (context, index){
                return FutureBuilder(
                  future: GetUser(int.parse(conversations[index].value["peer"])),
                  builder: (context, snapshot){
                    if(!snapshot.hasData) return const Center(child: CircularProgressIndicator());
                    UserBase userBase = snapshot.data;
                    User user = userBase.data.first;

                    String room = conversations[index].key;

                    return StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                        .collection("chats")
                        .where("roomId", isEqualTo: room)
                        .orderBy("date", descending: false)
                        .snapshots(),
                      builder: (context, snapshot){
                        if(snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator(),);
                        List<DocumentSnapshot> items = snapshot.data.docs;

                        String lastMessage = items.last["message"];

                        return ListTile(
                          leading: ClipOval(
                            child: Image(
                              image: GetUserImage(user.id),
                            ),
                          ),
                          title: Text("${user.name} ${user.surname}"),
                          subtitle: Text(lastMessage),
                          trailing: Icon(FontAwesomeIcons.chevronRight, color: Theme.of(context).primaryIconTheme.color,),
                          onTap: (){
                            Navigator.pushNamed(context, sendMessageRoute, arguments: user);
                          },
                        );
                      },
                    );
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
      title: Text(Texts.messages),
    );
  }
}
