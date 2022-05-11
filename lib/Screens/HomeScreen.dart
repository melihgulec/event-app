import 'package:event_app/Constants/RouteNames.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              child: Text("Login"),
              onPressed: (){
                Navigator.pushNamed(context, loginRoute);
              },
            ),
            ElevatedButton(
              child: Text("Sign Up"),
              onPressed: (){
                Navigator.pushNamed(context, signUpRoute);
              },
            ),
          ],
        ),
      ),
    );
  }
}
