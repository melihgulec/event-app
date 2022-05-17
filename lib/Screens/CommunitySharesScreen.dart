import 'dart:convert';

import 'package:event_app/Components/BaseContainer.dart';
import 'package:event_app/Components/CommentContainer.dart';
import 'package:event_app/Components/ShareContainer.dart';
import 'package:event_app/Components/TextFieldWithAvatar.dart';
import 'package:event_app/Components/WhiteSpaceVertical.dart';
import 'package:event_app/Constants/Texts.dart';
import 'package:event_app/Helpers/SizeConfig.dart';
import 'package:event_app/Models/Community.dart';
import 'package:event_app/Models/CommunityFeedComment.dart';
import 'package:event_app/Models/CommunityFeedCommentCreateDto.dart';
import 'package:event_app/Models/CommunityFeedCreateDto.dart';
import 'package:event_app/Models/SharePost.dart';
import 'package:event_app/Services/CommunityFeedCommentService.dart';
import 'package:event_app/Services/CommunityFeedService.dart';
import 'package:event_app/Services/UserService.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommunitySharesScreen extends StatefulWidget {
  Community community;
  CommunitySharesScreen({Key key, this.community}) : super(key: key);

  @override
  State<CommunitySharesScreen> createState() => _EventSharesScreenState();
}

class _EventSharesScreenState extends State<CommunitySharesScreen> {
  SharedPreferences _preferences;

  var controllers = <TextEditingController>[];

  TextEditingController comment = TextEditingController(text: "");
  TextEditingController postDescription = TextEditingController(text: "");
  EdgeInsets pagePadding = const EdgeInsets.all(8);

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
    SizeConfig().init(context);
    return Scaffold(
      body: Padding(
        padding: pagePadding,
        child: Column(
          children: [
            BaseContainer(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
              child: FutureBuilder(
                future: SharedPreferences.getInstance(),
                builder: (context, snapshot){
                  if(!snapshot.hasData) return const CircularProgressIndicator();

                  return CreatePostTextField();
                },
              ),
            ),
            Divider(height: SizeConfig.blockSizeVertical * 5, thickness: 2,),
            Expanded(
              child: FutureBuilder<SharePostBase>(
                future: GetCommunityFeed(widget.community.id),
                builder: (BuildContext context, AsyncSnapshot<SharePostBase> snapshot){
                  if(!snapshot.hasData) return Center(child: Text(Texts.feedNotFound));
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
                            DeletePost(post.id);
                          });
                          setState(() {});
                        },
                        controller: controllers[index],
                        onPressed: (){
                          setState(() {
                            CreateComment(post.id, CommunityFeedCommentCreateDto(
                                createdAt: DateTime.now(),
                                description: controllers[index].text,
                                userId: _preferences.getInt("sessionUserId"),
                                communityId: widget.community.id
                            ));
                            setState(() {});
                          });
                        },
                        commentSection: FutureBuilder<CommunityFeedCommentBase>(
                          future: GetCommunityFeedComments(post.id),
                          builder: (BuildContext context, AsyncSnapshot<CommunityFeedCommentBase> snapshot){
                            if(!snapshot.hasData) return const Text("");
                            List<CommunityFeedComment> comments = snapshot.data.data;
                            comments.sort((comment, comment1) => comment1.createdAt.compareTo(comment.createdAt));

                            if (comments.isEmpty) return const Center(child: const Text(""));

                            return ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              separatorBuilder: (context, index) => WhiteSpaceVertical(factor: 3),
                              itemCount: comments.length,
                              itemBuilder: (context, index){
                                CommunityFeedComment item = comments[index];
                                return CommentContainer(
                                  description: item.description,
                                  createdAt: item.createdAt,
                                  user: item.user,
                                  isOwnComment: item.user.id == _preferences.getInt("sessionUserId") ? true : false,
                                  onPopupMenuDelete: (){
                                    setState(() {
                                      DeleteComment(post.id, item.id);
                                    });
                                    setState(() {

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
          CreatePost(widget.community.id, _preferences.getInt("sessionUserId"), CommunityFeedCreateDto(
            description: postDescription.text,
            createdAt: DateTime.now(),
          ));
        });
        setState(() {

        });
      },
    );
  }

}