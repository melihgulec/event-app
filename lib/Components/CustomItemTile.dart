import 'package:event_app/Helpers/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomItemTile extends StatelessWidget {
  String title;
  String subtitle;
  FaIcon icon;
  Color leftBorderColor;

  CustomItemTile({
    Key key,
    this.title = "",
    this.subtitle = "",
    this.icon,
    this.leftBorderColor = Colors.transparent
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
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
          if(leftBorderColor != Colors.transparent) SizedBox(width: 15,),
          Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15)
            ),
            child: Center(
              child: FaIcon(
                icon.icon,
                color: Colors.black,
                size: 30,
              ),
            ),
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
