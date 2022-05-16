import 'package:event_app/Components/BaseContainer.dart';
import 'package:event_app/Components/CommentContainer.dart';
import 'package:event_app/Components/TextFieldWithAvatar.dart';
import 'package:event_app/Components/WhiteSpaceVertical.dart';
import 'package:event_app/Models/User.dart';
import 'package:event_app/Services/UserService.dart';
import 'package:flutter/material.dart';

class ShareContainer extends StatelessWidget {
  ShareContainer({
    Key key,
    this.description,
    this.postCreatedAt,
    this.user,
    this.commentSection,
    this.sessionUserId,
    this.controller,
    this.onPressed
  }) : super(key: key);

  User user;
  int sessionUserId;
  DateTime postCreatedAt;
  String description;
  Widget commentSection;
  TextEditingController controller;
  Function onPressed;

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 18),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: GetUserImage(user.id),
                radius: 25,
              ),
              SizedBox(width: 12,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${user.name} ${user.surname}",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    postCreatedAt.toString(),
                    style: Theme.of(context).textTheme.caption,
                  )
                ],
              ),
            ],
          ),
          WhiteSpaceVertical(),
          Text(
            description,
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.bodyLarge.fontSize,
              height: 1.3,
            ),
          ),
          WhiteSpaceVertical(),
          Divider(thickness: 2,),
          WhiteSpaceVertical(),
          TextFieldWithAvatar(
            image: GetUserImage(sessionUserId),
            controller: controller,
            onPressed: onPressed,
          ),
          commentSection,
        ],
      ),
    );
  }
}
