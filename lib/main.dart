import 'package:event_app/Theme/Theme.dart';
import 'package:flutter/material.dart';
import 'package:event_app/Constants/RouteNames.dart';
import 'package:event_app/Route/Router.dart' as AppRouter;

void main() {
  runApp(MainScreen());
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      initialRoute: loginRoute,
      onGenerateRoute: AppRouter.Router.generateRoute,
    );
  }
}
