import 'package:event_app/Helpers/SizeConfig.dart';
import 'package:flutter/material.dart';

class WhiteSpaceVertical extends StatelessWidget {
  double factor;

  WhiteSpaceVertical({Key key, this.factor = 2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return SizedBox(
      height: SizeConfig.blockSizeVertical * factor,
    );
  }
}