import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ButtonWithIcon extends StatelessWidget {
  Function onPressed;
  String title;

  ButtonWithIcon({Key key, this.title = "TEXT", this.onPressed}) : super(key: key);

  double buttonWidth = double.infinity;
  double buttonHeight = 58;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.button,
            ),
          ),
          Icon(
            FontAwesomeIcons.chevronRight,
            color: Colors.white,
          )
        ],
      ),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(buttonWidth, buttonHeight),
      ),
    );
  }
}
