import 'package:event_app/Components/ShareContainer.dart';
import 'package:event_app/Components/WhiteSpaceVertical.dart';
import 'package:flutter/material.dart';

class ProfileShareScreen extends StatefulWidget {
  ProfileShareScreen({Key key}) : super(key: key);

  @override
  State<ProfileShareScreen> createState() => _ProfileShareScreenState();
}

class _ProfileShareScreenState extends State<ProfileShareScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [

            ],
          ),
        ),
      ),
    );
  }
}
