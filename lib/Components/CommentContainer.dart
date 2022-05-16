import 'package:event_app/Models/User.dart';
import 'package:event_app/Services/UserService.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommentContainer extends StatelessWidget {
  CommentContainer({
    Key key,
    this.user,
    this.createdAt,
    this.description
  }) : super(key: key);

  User user;
  DateTime createdAt;
  String description;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: GetUserImage(user.id),
        ),
        SizedBox(width: 15,),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${user.name} ${user.surname} - ${DateFormat("d MMM, yyyy HH:mm","tr_TR").format(createdAt)}",
                style: TextStyle(
                  fontWeight: FontWeight.w500
                ),
              ),
              SizedBox(height: 5,),
              Text(
                description
              )
            ],
          ),
        ),
      ],
    );
  }
}
