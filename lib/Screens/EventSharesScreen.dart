import 'package:event_app/Components/BaseContainer.dart';
import 'package:event_app/Components/CommentContainer.dart';
import 'package:event_app/Components/ShareContainer.dart';
import 'package:event_app/Components/TextFieldWithAvatar.dart';
import 'package:event_app/Components/WhiteSpaceVertical.dart';
import 'package:event_app/Constants/Texts.dart';
import 'package:event_app/Helpers/SizeConfig.dart';
import 'package:event_app/Models/CommentCreateDto.dart';
import 'package:event_app/Models/Event.dart';
import 'package:event_app/Models/EventFeedComment.dart';
import 'package:event_app/Models/EventFeedCreateDto.dart';
import 'package:event_app/Models/SharePost.dart';
import 'package:event_app/Services/EventFeedCommentService.dart';
import 'package:event_app/Services/EventService.dart';
import 'package:event_app/Services/SharePostService.dart';
import 'package:event_app/Services/UserService.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventSharesScreen extends StatefulWidget {
  Event event;
  EventSharesScreen({Key key, this.event}) : super(key: key);

  @override
  State<EventSharesScreen> createState() => _EventSharesScreenState();
}

class _EventSharesScreenState extends State<EventSharesScreen> {
  SharedPreferences _preferences;

  var controllers = <TextEditingController>[];

  TextEditingController comment = TextEditingController(text: "");
  TextEditingController postDescription = TextEditingController(text: "");
  EdgeInsets pagePadding = EdgeInsets.all(8);

  getPrefs() async{
    _preferences = await SharedPreferences.getInstance(); 
  }
  
  @override
  void initState() {
    getPrefs();
    // TODO: implement initState
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: pagePadding,
        child: Column(
          children: [
            BaseContainer(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
              child: FutureBuilder(
                future: SharedPreferences.getInstance(),
                builder: (context, snapshot){
                  if(!snapshot.hasData) return CircularProgressIndicator();

                  return CreatePostTextField();
                },
              ),
            ),
            Divider(height: SizeConfig.blockSizeVertical * 5, thickness: 2,),
            Expanded(
              child: FutureBuilder<SharePostBase>(
                future: GetEventFeed(widget.event.id),
                builder: (BuildContext context, AsyncSnapshot<SharePostBase> snapshot){
                  if(!snapshot.hasData) return const CircularProgressIndicator();
                  List<SharePost> posts = snapshot.data.data;
                  if (posts.isEmpty) return Center(child: Text(Texts.feedNotFound));

                  posts.sort((post, post1) => post1.createdAt.compareTo(post.createdAt));

                  return ListView.separated(
                    padding: EdgeInsets.zero,
                    separatorBuilder: (context, index) => WhiteSpaceVertical(factor: 3,),
                    itemCount: posts.length,
                    itemBuilder: (context, index){
                      SharePost post = posts[index];
                      controllers.add(TextEditingController(text: ""));

                      return ShareContainer(
                        description: post.description,
                        postCreatedAt: post.createdAt,
                        user: post.user,
                        sessionUserId: _preferences.getInt("sessionUserId"),
                        isOwnPost: post.user.id == _preferences.getInt("sessionUserId") ? true : false,
                        onPopupMenuDelete: (){
                          setState(() {
                            DeletePost(widget.event.id, post.id);
                          });
                        },
                        controller: controllers[index],
                        onPressed: (){
                          setState(() {
                            CreateComment(widget.event.id, post.id, CommentCreateDto(
                                createdAt: DateTime.now(),
                                description: controllers[index].text,
                                userId: _preferences.getInt("sessionUserId")
                            ));
                          });
                        },
                        commentSection: FutureBuilder<EventFeedCommentBase>(
                          future: GetEventFeedComment(widget.event.id, post.id),
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
                                  isOwnComment: item.user.id == _preferences.getInt("sessionUserId") ? true : false,
                                  onPopupMenuDelete: (){
                                    setState(() {
                                      DeleteComment(widget.event.id, post.id, item.id);
                                    });
                                  },
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
          ],
        ),
      ),
    );
  }

  TextFieldWithAvatar CreatePostTextField(){
    return TextFieldWithAvatar(
      controller: postDescription,
      image: GetUserImage(_preferences.getInt("sessionUserId")),
      placeholder: Texts.shareYourThoughts,
      onPressed: (){
        setState(() {
          CreatePost(widget.event.id, EventFeedCreateDto(
            userId: _preferences.getInt("sessionUserId"),
            description: postDescription.text,
            createdAt: DateTime.now(),
          ));
        });
      },
    );
  }

}
