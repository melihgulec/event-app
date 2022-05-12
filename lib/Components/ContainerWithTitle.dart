import 'package:event_app/Components/CardBase.dart';
import 'package:event_app/Constants/Texts.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContainerWithTitle extends StatelessWidget {
  String containerTitle;
  String containerInteractionText;
  Widget child;
  double width;
  double height;
  EdgeInsets titlePadding;

  ContainerWithTitle({
    Key key,
    this.containerTitle,
    this.containerInteractionText,
    this.child,
    this.width,
    this.height,
    this.titlePadding = EdgeInsets.zero
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: titlePadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  containerTitle,
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.headline6.fontSize,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      containerInteractionText,
                      style: const TextStyle(
                        fontSize: 17,
                        color: Colors.grey
                      ),
                    ),
                    Icon(FontAwesomeIcons.chevronRight, color: Theme.of(context).primaryIconTheme.color, size: 12,)
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 15,),
          child
        ],
      ),
    );
  }
}
