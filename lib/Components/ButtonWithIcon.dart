import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ButtonWithIcon extends StatelessWidget {
  Function onPressed;
  String title;
  IconData prefixIcon;
  IconData suffixIcon;
  double buttonWidth;
  double buttonHeight;
  bool hasSuffixIcon;

  ButtonWithIcon({
    Key key,
    this.title = "TEXT",
    this.onPressed,
    this.suffixIcon = FontAwesomeIcons.chevronRight,
    this.prefixIcon,
    this.buttonWidth = double.infinity,
    this.buttonHeight = 58,
    this.hasSuffixIcon = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Row(
        children: [
          if(prefixIcon != null) Icon(
            prefixIcon,
            color: Colors.white,
          ),
          Expanded(
            flex: 3,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.button,
            ),
          ),
          if(hasSuffixIcon) Icon(
            suffixIcon,
            color: Colors.white,
          ),
        ],
      ),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(buttonWidth, buttonHeight),
      ),
    );
  }
}
