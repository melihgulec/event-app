import 'package:event_app/Constants/RouteNames.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text("Login"),
          onPressed: (){
            Navigator.pushNamed(context, loginRoute);
          },
        ),
      ),
    );
  }
}
