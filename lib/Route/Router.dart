import 'package:flutter/material.dart';
import 'package:event_app/Screens/LoginScreen.dart';
import 'package:event_app/Screens/SignUpScreen.dart';
import 'package:event_app/Constants/RouteNames.dart';
import 'package:event_app/Screens/HomeScreen.dart';
import 'package:event_app/Screens/NotFoundScreen.dart';

class Router{
  static Route<dynamic> generateRoute(RouteSettings settings){
    List<dynamic> args = (settings.arguments is List<dynamic> ? settings.arguments : null);
    switch(settings.name){
      case homeRoute: return MaterialPageRoute(builder: (context) => HomeScreen());
      case loginRoute: return MaterialPageRoute(builder: (context) => LoginScreen());
      case signUpRoute: return MaterialPageRoute(builder: (context) => SignUpScreen());
      default:
        return MaterialPageRoute(builder: (context) => NotFoundScreen());
    }
  }
}