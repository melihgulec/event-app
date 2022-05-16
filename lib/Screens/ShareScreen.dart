import 'package:event_app/Components/ShareContainer.dart';
import 'package:event_app/Components/WhiteSpaceVertical.dart';
import 'package:flutter/material.dart';

class ShareScreen extends StatefulWidget {
  ShareScreen({Key key}) : super(key: key);

  @override
  State<ShareScreen> createState() => _ShareScreenState();
}

class _ShareScreenState extends State<ShareScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ShareContainer(),
              WhiteSpaceVertical(factor: 5,),
              ShareContainer(),
              WhiteSpaceVertical(factor: 5,),
              ShareContainer(),
            ],
          ),
        ),
      ),
    );
  }
}
