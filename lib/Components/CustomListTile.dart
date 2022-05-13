import 'package:event_app/Helpers/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomItemTile extends StatelessWidget {
  String title;
  String subtitle;
  IconData icon;
  Color leftBorderColor;

  CustomItemTile({
    Key key,
    this.title = "",
    this.subtitle = "",
    this.icon = FontAwesomeIcons.xmark,
    this.leftBorderColor = Colors.transparent
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Container(
      width: SizeConfig.screenWidth,
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            width: leftBorderColor == Colors.transparent ? 0 : 3,
            color: leftBorderColor,
          )
        )
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if(leftBorderColor != Colors.transparent) SizedBox(width: 10,),
          Icon(
            icon,
            color: Colors.white,
            size: 45,
          ),
          const SizedBox(width: 20,),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18
                  ),
                ),
                SizedBox(
                  height: subtitle.isNotEmpty ? 10 : 0,
                ),
                if(subtitle.isNotEmpty)
                Text(
                  subtitle,
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w300
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
