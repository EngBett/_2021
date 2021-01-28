import 'package:flutter/widgets.dart';
import 'package:new_aylf_mobile/screens/activities/activity_screen.dart';
import 'package:new_aylf_mobile/screens/activity_view/activity_view_screen.dart';
import 'package:new_aylf_mobile/screens/complete_profile/complete_profile_screen.dart';
import 'package:new_aylf_mobile/screens/event_view/event_view_screen.dart';
import 'package:new_aylf_mobile/screens/events/events_screen.dart';
import 'package:new_aylf_mobile/screens/forgot_password/forgot_password_screen.dart';
import 'package:new_aylf_mobile/screens/group/group_screen.dart';
import 'package:new_aylf_mobile/screens/members/members_screen.dart';
import 'package:new_aylf_mobile/screens/navigation/navigation_screen.dart';
import 'package:new_aylf_mobile/screens/notifications/notifications_screen.dart';
import 'package:new_aylf_mobile/screens/profile/profile_screen.dart';
import 'package:new_aylf_mobile/screens/resources/resources_screen.dart';
import 'package:new_aylf_mobile/screens/sign_up/sign_up_screen.dart';
import 'package:new_aylf_mobile/screens/splash/splash_screen.dart';
import 'package:new_aylf_mobile/screens/sign_in/sign_in_screen.dart';
import 'package:new_aylf_mobile/screens/youtube/youtube_screen.dart';

//Named routes
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  NavigationScreen.routeName: (context) => NavigationScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  YoutubeScreen.routeName: (context) => YoutubeScreen(),
  ActivityScreen.routeName: (context) => ActivityScreen(),
  EventScreen.routeName: (context) => EventScreen(),
  ResourcesScreen.routeName: (context) => ResourcesScreen(),
  GroupScreen.routeName: (context) => GroupScreen(),
  NotificationsScreen.routeName: (context) => NotificationsScreen(),
  EventViewScreen.routeName: (context) => EventViewScreen(),
  ActivityViewScreen.routeName: (context) => ActivityViewScreen(),
  MembersScreen.routeName: (context) => MembersScreen()
};
