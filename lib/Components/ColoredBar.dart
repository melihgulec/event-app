import 'package:flutter/material.dart';

class ColoredBar extends StatelessWidget {
  Function onPressed;
  String title;
  IconData icon;
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
      width: 100,
      height: 55,
      child: ElevatedButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
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
