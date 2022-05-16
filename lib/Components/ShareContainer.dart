import 'package:event_app/Components/BaseContainer.dart';
import 'package:event_app/Components/CommentContainer.dart';
import 'package:event_app/Components/TextFieldWithAvatar.dart';
import 'package:event_app/Components/WhiteSpaceVertical.dart';
import 'package:flutter/material.dart';

class ShareContainer extends StatelessWidget {
  ShareContainer({Key key}) : super(key: key);

  String desc = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras in tellus luctus, tristique ligula et, placerat mi. In quam quam, vulputate in elementum ac, placerat sit amet ligula. Integer dapibus tortor vitae faucibus cursus. Class aptent taciti sociosqu ad litora torque";

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 18),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage("assets/images/mocks/muhtar1.jpg"),
                radius: 25,
              ),
              SizedBox(width: 12,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Melih Güleç",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    "3 saat önce",
                    style: Theme.of(context).textTheme.caption,
                  )
                ],
              ),
            ],
          ),
          WhiteSpaceVertical(),
          Text(
            desc,
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.bodyLarge.fontSize,
              height: 1.3,
            ),
          ),
          WhiteSpaceVertical(),
          Divider(thickness: 2,),
          WhiteSpaceVertical(),
          TextFieldWithAvatar(),
          WhiteSpaceVertical(),
          CommentContainer(),
          WhiteSpaceVertical(),
          CommentContainer(),],
      ),
    );
  }
}
