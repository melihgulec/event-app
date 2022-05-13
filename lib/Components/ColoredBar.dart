import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ColoredBar extends StatelessWidget {
  Function onPressed;
  String title;
  FaIcon icon;
  Color backgroundColor;

  ColoredBar({
    Key key,
    this.title,
    this.icon,
    this.backgroundColor,
    this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: ElevatedButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FaIcon(
              icon.icon,
              color: Colors.white,
            ),
            SizedBox(width: 10,),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
            )
          ],
        ),
        style: ElevatedButton.styleFrom(
            primary: backgroundColor, shape: const StadiumBorder()),
        onPressed: onPressed,
      ),
    );
  }
}
