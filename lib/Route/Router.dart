import 'package:event_app/Screens/CommunitySettingsScreen.dart';
import 'package:event_app/Screens/CommunityUserAuthorizationScreen.dart';
import 'package:event_app/Screens/CreateEventScheduleScreen.dart';
import 'package:event_app/Screens/EditCommunityScreen.dart';
import 'package:event_app/Screens/EditEventScheduleScreen.dart';
import 'package:event_app/Screens/EditEventScreen.dart';
import 'package:event_app/Screens/EventSettingsScreen.dart';
import 'package:event_app/Screens/EventUserAuthorizationScreen.dart';
import 'package:event_app/Screens/SendMessageScreen.dart';
import 'package:event_app/Screens/UserMessagesScreen.dart';
import 'package:flutter/material.dart';
import 'package:event_app/Constants/RouteNames.dart';
import 'package:event_app/Screens/CommunitiesListScreen.dart';
import 'package:event_app/Screens/CommunityScreen.dart';
import 'package:event_app/Screens/CompanyScreen.dart';
import 'package:event_app/Screens/CreateCommunityScreen.dart';
import 'package:event_app/Screens/CreateEventScreen.dart';
import 'package:event_app/Screens/EventDetailDetailTabScreen.dart';
import 'package:event_app/Screens/EventDetailScreen.dart';
import 'package:event_app/Screens/EventSponsorsScreen.dart';
import 'package:event_app/Screens/EventsListScreen.dart';
import 'package:event_app/Screens/InterestsScreen.dart';
import 'package:event_app/Screens/ProfileShareScreen.dart';
import 'package:event_app/Screens/UserProfileScreen.dart';
import 'package:event_app/Screens/LoginScreen.dart';
import 'package:event_app/Screens/SignUpScreen.dart';
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
      case eventEditRoute: return MaterialPageRoute(builder: (context) => EditEventScreen(event: settings.arguments,));
      case createEventScheduleRoute: return MaterialPageRoute(builder: (context) => CreateEventScheduleScreen(event: settings.arguments));
      case editEventScheduleRoute: return MaterialPageRoute(builder: (context) => EditEventScheduleScreen(eventSchedule: args[0], event: args[1],));
      case eventSettingsRoute: return MaterialPageRoute(builder: (context) => EventSettingsScreen(event: settings.arguments));
      case eventUserAuthorizationRoute: return MaterialPageRoute(builder: (context) => EventUserAuthorizationScreen(event: settings.arguments));
      case communitySettingsRoute: return MaterialPageRoute(builder: (context) => CommunitySettingsScreen(community: settings.arguments));
      case communityUserAuthorizationRoute: return MaterialPageRoute(builder: (context) => CommunityUserAuthorizationScreen(community: settings.arguments));
      case interestsRoute: return MaterialPageRoute(builder: (context) => InterestsScreen());
      case eventsListRoute: return MaterialPageRoute(builder: (context) => EventsListScreen(interest: settings.arguments,));
      case userProfileRoute: return MaterialPageRoute(builder: (context) => ProfileScreen(user: settings.arguments,));
      case shareRoute: return MaterialPageRoute(builder: (context) => ProfileShareScreen());
      case companyRoute: return MaterialPageRoute(builder: (context) => CompanyScreen(company: settings.arguments,));
      case communityRoute: return MaterialPageRoute(builder: (context) => CommunityScreen(community: settings.arguments,));
      case communityEditRoute: return MaterialPageRoute(builder: (context) => EditCommunityScreen(community: settings.arguments,));
      case communityListRoute: return MaterialPageRoute(builder: (context) => CommunitiesListScreen());
      case createCommunityRoute: return MaterialPageRoute(builder: (context) => CreateCommunityScreen());
      case createEventRoute: return MaterialPageRoute(builder: (context) => CreateEventScreen());
      case sendMessageRoute: return MaterialPageRoute(builder: (context) => SendMessageScreen(user: settings.arguments,));
      case userMessagesRoute: return MaterialPageRoute(builder: (context) => UserMessagesScreen(user: settings.arguments,));
      default:
        return MaterialPageRoute(builder: (context) => NotFoundScreen());
    }
  }
}