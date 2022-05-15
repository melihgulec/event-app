import 'package:event_app/Screens/EventDetailDetailTabScreen.dart';
import 'package:event_app/Screens/EventDetailScreen.dart';
import 'package:event_app/Screens/EventSponsorsScreen.dart';
import 'package:event_app/Screens/EventsListScreen.dart';
import 'package:event_app/Screens/InterestsScreen.dart';
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
      case loginRoute: return MaterialPageRoute(builder: (context) => LoginScreen());
      case homeRoute: return MaterialPageRoute(builder: (context) => HomeScreen(user: settings.arguments,));
      case signUpRoute: return MaterialPageRoute(builder: (context) => SignUpScreen());
      case eventDetailRoute: return MaterialPageRoute(builder: (context) => EventDetailScreen(event: settings.arguments,));
      case eventDetailTabRoute: return MaterialPageRoute(builder: (context) => EventDetailDetailTabScreen(event: settings.arguments,));
      case eventSponsorsRoute: return MaterialPageRoute(builder: (context) => EventSponsorsScreen(event: settings.arguments,));
      case interestsRoute: return MaterialPageRoute(builder: (context) => InterestsScreen());
      case eventsListRoute: return MaterialPageRoute(builder: (context) => EventsListScreen(interest: settings.arguments,));
      default:
        return MaterialPageRoute(builder: (context) => NotFoundScreen());
    }
  }
}