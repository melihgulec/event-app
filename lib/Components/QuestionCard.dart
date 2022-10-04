import 'package:event_app/Components/WhiteSpaceVertical.dart';
import 'package:event_app/Helpers/SizeConfig.dart';
import 'package:event_app/Models/QuestionBase.dart';
import 'package:event_app/Services/UserService.dart';
import 'package:flutter/material.dart';

class QuestionCard extends StatefulWidget {
  Question question;
  Function onLongPress;

  QuestionCard({Key key, this.question, this.onLongPress}) : super(key: key);

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  BorderRadius borderRadius = BorderRadius.circular(12);
  EdgeInsets padding = EdgeInsets.symmetric(vertical: 12, horizontal: 8);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: borderRadius,
      onLongPress: widget.onLongPress,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: Colors.white10,
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: GetUserImage(widget.question.user.id),
              radius: 30,
            ),
            const SizedBox(width: 25,),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: SizeConfig.screenWidth,
                    child: Text('${widget.question.user.name} ${widget.question.user.surname}', style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    )),
                  ),
                  WhiteSpaceVertical(),
                  SizedBox(
                    width: SizeConfig.screenWidth,
                    child: Text(widget.question.description),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
