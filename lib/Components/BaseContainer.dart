import 'package:flutter/material.dart';

class BaseContainer extends StatelessWidget {
  BaseContainer({Key key, this.child, this.padding, this.borderRadius, this.width, this.height }) : super(key: key);

  Color baseColor = Color(0xff1D1E21);
  Widget child;
  EdgeInsets padding;
  BorderRadius borderRadius;
  double width;
  double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height,
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(5),
        color: baseColor,
      ),
      padding: padding,
      child: child,
    );
  }
}
