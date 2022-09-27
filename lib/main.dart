import 'dart:io';

import 'package:event_app/Theme/Theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:event_app/Constants/RouteNames.dart';
import 'package:event_app/Route/Router.dart' as AppRouter;
import 'package:intl/date_symbol_data_local.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true; }}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = new MyHttpOverrides();
  await Firebase.initializeApp();
  runApp(MainScreen());
}

class MainScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting("tr_TR");
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      initialRoute: loginRoute,
      onGenerateRoute: AppRouter.Router.generateRoute,
    );
  }
}
