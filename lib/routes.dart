import 'package:flutter/widgets.dart';
import 'package:aylf/screens/activities/activity_screen.dart';
import 'package:aylf/screens/activity_view/activity_view_screen.dart';
import 'package:aylf/screens/complete_profile/complete_profile_screen.dart';
import 'package:aylf/screens/choose_country/choose_country_screen.dart';
import 'package:aylf/screens/choose_region/choose_region_screen.dart';
import 'package:aylf/screens/choose_group/choose_group_screen.dart';
import 'package:aylf/screens/event_view/event_view_screen.dart';
import 'package:aylf/screens/events/events_screen.dart';
import 'package:aylf/screens/forgot_password/forgot_password_screen.dart';
import 'package:aylf/screens/verify_email/verify_email_screen.dart';
import 'package:aylf/screens/group/group_screen.dart';
import 'package:aylf/screens/members/members_screen.dart';
import 'package:aylf/screens/navigation/navigation_screen.dart';
import 'package:aylf/screens/notifications/notifications_screen.dart';
import 'package:aylf/screens/profile/profile_screen.dart';
import 'package:aylf/screens/resources/resources_screen.dart';
import 'package:aylf/screens/sign_up/sign_up_screen.dart';
import 'package:aylf/screens/splash/splash_screen.dart';
import 'package:aylf/screens/sign_in/sign_in_screen.dart';
import 'package:aylf/screens/youtube/youtube_screen.dart';

//Named routes
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  VerifyEmailScreen.routeName:(context)=> VerifyEmailScreen(),
  ChooseCountry.routeName: (context) => ChooseCountry(),
  ChooseRegion.routeName: (context) => ChooseRegion(),
  ChooseGroup.routeName: (context) => ChooseGroup(),
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
