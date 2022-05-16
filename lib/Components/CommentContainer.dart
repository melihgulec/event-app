import 'package:flutter/material.dart';

class CommentContainer extends StatelessWidget {
  CommentContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: AssetImage("assets/images/mocks/muhtar1.jpg"),
        ),
        SizedBox(width: 15,),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Gülfer Güreşçi - 2 saat önce",
              ),
              SizedBox(height: 5,),
              Text(
                "Nulla ac suscipit dolor. Ut odio purus, molestie quis diam nec, aliquet euismod ex. ",
              )
            ],
          ),
        ),
      ],
    );
  }
}
