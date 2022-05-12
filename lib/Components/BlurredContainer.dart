import 'dart:ui';
import 'package:flutter/material.dart';

class BlurredContainer extends StatelessWidget {
  List<Widget> children;
  Function onTap;

  BlurredContainer({Key key, this.onTap, this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.7),
          borderRadius: BorderRadius.circular(10)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: children
        ),
      ),
    );
  }
}
