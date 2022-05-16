import 'package:event_app/Constants/Texts.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TextFieldWithAvatar extends StatelessWidget {
  ImageProvider image;

  TextFieldWithAvatar({Key key, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundImage: image,
          radius: 25,
        ),
        SizedBox(width: 12,),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(8),
              fillColor: Theme.of(context).inputDecorationTheme.fillColor.withAlpha(24),
              hintText: Texts.writeCommentPlaceholder,
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
        SizedBox(width: 5,),
        Container(
          height: 48,
          child: ElevatedButton(
            child: Icon(FontAwesomeIcons.check, color: Colors.white,),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              )
            ),
            onPressed: (){

            },
          ),
        ),
      ],
    );
  }
}
