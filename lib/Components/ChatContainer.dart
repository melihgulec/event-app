import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatContainer extends StatelessWidget {

  String message;
  MainAxisSize mainAxisSize;
  EdgeInsets padding;
  BorderRadius borderRadius;
  Color color;
  bool isMe;
  DateTime date;

  ChatContainer({
    Key key,
    this.message,
    this.mainAxisSize = MainAxisSize.min,
    this.color = Colors.orange,
    this.isMe,
    this.date
  }) : super(key: key);

  double bubbleRadius = 12;

  EdgeInsets containerPadding = const EdgeInsets.all(12);


  @override
  Widget build(BuildContext context) {
    return Container(
        padding: containerPadding,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(bubbleRadius),
                bottomLeft:  Radius.circular(bubbleRadius),
                topRight: isMe ? Radius.zero : Radius.circular(bubbleRadius),
                topLeft: isMe ? Radius.circular(bubbleRadius) : Radius.zero,
            ),
            color: isMe ? Theme.of(context).primaryColor : Color(0xff202c33)
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 65, bottom: 2),
              child: Text(
                  message,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Text(
                DateFormat("hh:mm","tr_TR").format(date == null ? DateTime.now() : date),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13
                ),
              ),
            )
          ],
        )
    );
  }
}
