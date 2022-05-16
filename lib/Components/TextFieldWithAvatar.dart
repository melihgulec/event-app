import 'package:flutter/material.dart';

class TextFieldWithAvatar extends StatelessWidget {
  TextFieldWithAvatar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundImage: AssetImage("assets/images/mocks/muhtar1.jpg"),
        ),
        SizedBox(width: 12,),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(8),
              fillColor: Theme.of(context).inputDecorationTheme.fillColor.withAlpha(24),
              hintText: "Yorum yaz...",
              hintStyle: TextStyle(
                color: Theme.of(context).inputDecorationTheme.hintStyle.color,
                fontWeight: FontWeight.w400
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none
              )
            ),
          ),
        ),
      ],
    );
  }
}
