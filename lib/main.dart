import 'package:flutter/material.dart';
import 'package:event_app/Constants/RouteNames.dart';
import 'package:event_app/Route/Router.dart' as AppRouter;

void main() {
  runApp(MainScreen());
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      initialRoute: homeRoute,
      onGenerateRoute: AppRouter.Router.generateRoute,
    );

  }
}
