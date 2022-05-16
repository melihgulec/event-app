import 'package:event_app/Components/CommentContainer.dart';
import 'package:event_app/Components/ShareContainer.dart';
import 'package:event_app/Components/WhiteSpaceVertical.dart';
import 'package:event_app/Constants/Texts.dart';
import 'package:event_app/Models/CommentCreateDto.dart';
import 'package:event_app/Models/Event.dart';
import 'package:event_app/Models/EventFeedComment.dart';
import 'package:event_app/Models/SharePost.dart';
import 'package:event_app/Services/EventFeedCommentService.dart';
import 'package:event_app/Services/EventService.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventSharesScreen extends StatefulWidget {
  Event event;
  EventSharesScreen({Key key, this.event}) : super(key: key);

  @override
  State<EventSharesScreen> createState() => _EventSharesScreenState();
}

class _EventSharesScreenState extends State<EventSharesScreen> {
  SharedPreferences _preferences;
  TextEditingController comment = TextEditingController(text: "");
  
  getPrefs() async{
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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<SharePostBase>(
          future: GetEventFeed(widget.event.id),
          builder: (BuildContext context, AsyncSnapshot<SharePostBase> snapshot){
            if(!snapshot.hasData) return const CircularProgressIndicator();
            List<SharePost> posts = snapshot.data.data;
            if (posts.isEmpty) return Center(child: Text(Texts.feedNotFound));

            return ListView.separated(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => WhiteSpaceVertical(factor: 5,),
              itemCount: posts.length,
              itemBuilder: (context, index){
                SharePost item = posts[index];

                return ShareContainer(
                  description: item.description,
                  postCreatedAt: item.createdAt,
                  user: item.user,
                  sessionUserId: _preferences.getInt("sessionUserId"),
                  controller: comment,
                  onPressed: (){
                    setState(() {
                      CreateComment(widget.event.id, item.id, CommentCreateDto(
                          createdAt: DateTime.now(),
                          description: comment.text,
                          userId: _preferences.getInt("sessionUserId")
                      ));
                    });
                  },
                  commentSection: FutureBuilder<EventFeedCommentBase>(
                    future: GetEventFeedComment(widget.event.id, item.id),
                    builder: (BuildContext context, AsyncSnapshot<EventFeedCommentBase> snapshot){
                      if(!snapshot.hasData) return const Text("");
                      List<EventFeedComment> comments = snapshot.data.data;
                      comments.sort((comment, comment1) => comment1.createdAt.compareTo(comment.createdAt));

                      if (comments.isEmpty) return Center(child: Text(Texts.commentNotFound));

                      return ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        separatorBuilder: (context, index) => WhiteSpaceVertical(factor: 3),
                        itemCount: comments.length,
                        itemBuilder: (context, index){
                          EventFeedComment item = comments[index];
                          return CommentContainer(
                            description: item.description,
                            createdAt: item.createdAt,
                            user: item.user,
                          );
                        },
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
