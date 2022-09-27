import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app/Components/ChatContainer.dart';
import 'package:event_app/Constants/RouteNames.dart';
import 'package:event_app/Models/User.dart';
import 'package:event_app/Services/UserService.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SendMessageScreen extends StatefulWidget {
  User user;

  SendMessageScreen({
    Key key,
    this.user
  }) : super(key: key);

  @override
  State<SendMessageScreen> createState() => _SendMessageScreenState();
}

class _SendMessageScreenState extends State<SendMessageScreen> {
  SharedPreferences _preferences;
  CollectionReference commentsCollection = FirebaseFirestore.instance.collection('chats');
  TextEditingController messageController = TextEditingController(text: "");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPrefs();
    getData();
  }

  getPrefs() async{
    _preferences = await SharedPreferences.getInstance();
  }

  QuerySnapshot chatRoom;

  final _fireStore = FirebaseFirestore.instance;

  Future<void> getData() async {
    // sonra düzeltilecek.
    _preferences = await SharedPreferences.getInstance();

    QuerySnapshot firstSnapshot =
    await _fireStore.collection('chatRooms')
        .where("roomId", isEqualTo: "${_preferences.getInt("sessionUserId")}_${widget.user.id}")
        .get();

    QuerySnapshot secondSnapshot =
    await _fireStore.collection('chatRooms')
        .where("roomId", isEqualTo: "${widget.user.id}_${_preferences.getInt("sessionUserId")}")
        .get();

    if(firstSnapshot.docs.isNotEmpty || secondSnapshot.docs.isNotEmpty){
      setState(() {
        chatRoom = firstSnapshot.docs.isNotEmpty ? firstSnapshot : secondSnapshot;
      });
    }
    else if(firstSnapshot.docs.isEmpty){
      CollectionReference roomCollection = FirebaseFirestore.instance.collection('chatRooms');
      roomCollection.add({
        'roomId' : "${_preferences.getInt("sessionUserId")}_${widget.user.id}",
        'users' : [
          _preferences.getInt("sessionUserId"),
          widget.user.id
        ]
      });

      chatRoom = await _fireStore.collection('chatRooms')
          .where("roomId", isEqualTo: "${_preferences.getInt("sessionUserId")}_${widget.user.id}").get();

      setState(() {});}
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CreateAppBar(),
      body: FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot){
          if(!snapshot.hasData) return Center(child: CircularProgressIndicator(),);

          return Column(
            children: [
              Expanded(
                  child:  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('chats')
                          .where("roomId", isEqualTo: chatRoom == null ? 0 : chatRoom.docs.first["roomId"] )
                          .orderBy("date", descending: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<DocumentSnapshot> items = snapshot.data.docs;

                          return ListView.separated(
                            reverse: true,
                            separatorBuilder: (context, index) => SizedBox(height: 35,),
                            itemCount: items.length,
                            itemBuilder: (context, index){
                              int senderId = items[index]["senderId"];
                              int receiverId = items[index]["receiverId"];
                              String message = items[index]["message"];
                              Timestamp timestamp = items[index]["date"];
                              var timeToNormal = DateTime.fromMicrosecondsSinceEpoch(timestamp == null ? DateTime.now().microsecondsSinceEpoch : timestamp.microsecondsSinceEpoch);

                              bool isMe = widget.user.id == receiverId ? true : false;

                              return Align(
                                alignment:  isMe ? Alignment.centerRight : Alignment.centerLeft,
                                child: ChatContainer(
                                  message: message,
                                  isMe: isMe ? true : false,
                                  date: timeToNormal,
                                ),
                              );
                            },
                          );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      },
                    ),
                  )
              ),
              Padding(
                padding: EdgeInsets.only(left: 5, right: 5, bottom: 15),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 65,
                        child: TextField(
                          controller: messageController,
                          style: TextStyle(
                            color: Colors.black
                          ),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100)
                            ),

                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 15,),
                    ClipOval(
                      child: Container(
                          width: 50,
                          height: 50,
                          color: Theme.of(context).primaryColor,
                          child: IconButton(
                            icon: Icon(FontAwesomeIcons.paperPlane, color: Colors.white,),
                            onPressed: (){
                              commentsCollection.add({
                                'message': messageController.text,
                                'roomId' : chatRoom.docs.first["roomId"],
                                'receiverId' : widget.user.id,
                                'senderId' : _preferences.get("sessionUserId"),
                                'date': FieldValue.serverTimestamp(),
                                'users':[
                                  widget.user.id,
                                  _preferences.getInt("sessionUserId")
                                ]
                              });
                              messageController.clear();
                            },
                          )
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  AppBar CreateAppBar(){
    return AppBar(
      title: InkWell(
        onTap: (){
          Navigator.pushNamed(context, userProfileRoute, arguments: widget.user);

        },
        child: Row(
          children: [
            ClipOval(
                child: Image(
                  image: GetUserImage(widget.user.id),
                  width: 40,
                  height: 40,
                )
            ),
            SizedBox(width: 15,),
            Text(
                "${widget.user.name} ${widget.user.surname}"
            ),
          ],
        ),
      ),
    );
  }

}
