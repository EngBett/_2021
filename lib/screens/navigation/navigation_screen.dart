import 'package:flutter/material.dart';
import 'package:new_aylf_mobile/components/custom_drawer/drawer_user_controller.dart';
import 'package:new_aylf_mobile/components/custom_drawer/home_drawer.dart';
import 'package:new_aylf_mobile/screens/about_aylf/about_aylf_screen.dart';
import 'package:new_aylf_mobile/screens/about_dev/about_dev_screen.dart';
import 'package:new_aylf_mobile/screens/feedback/feedback_screen.dart';
import 'package:new_aylf_mobile/screens/help/help_screen.dart';
import 'package:new_aylf_mobile/screens/home/home_screen.dart';
import 'package:new_aylf_mobile/screens/invite_friend/invite_friend_screen.dart';

import '../../app_theme.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({
    Key key,
  }) : super(key:key);

  static String routeName = "/navigation";

  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  Widget screenView;
  DrawerIndex drawerIndex;
  AnimationController sliderAnimationController;


  @override
  void initState() {
    drawerIndex = DrawerIndex.HOME;
    screenView = const MyHomePage();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: DrawerUserController(
            screenIndex: drawerIndex,
            drawerWidth: MediaQuery.of(context).size.width * 0.75,
            animationController: (AnimationController animationController) {
              sliderAnimationController = animationController;
            },
            onDrawerCall: (DrawerIndex drawerIndexdata) {
              changeIndex(drawerIndexdata);
            },
            screenView: screenView,
          ),
        ),
      ),
    );
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      if (drawerIndex == DrawerIndex.HOME) {
        setState(() {
          screenView = const MyHomePage();
        });
      } else if (drawerIndex == DrawerIndex.Help) {
        setState(() {
          screenView = HelpScreen();
        });

      } else if (drawerIndex == DrawerIndex.FeedBack) {
        setState(() {
          screenView = FeedbackScreen();
        });
      } else if (drawerIndex == DrawerIndex.Invite) {
        setState(() {
          screenView = InviteFriendScreen();
        });
      }else if(drawerIndex == DrawerIndex.About){
        setState(() {
          screenView = AboutAylfScreen();
        });
      }else if(drawerIndex == DrawerIndex.Dev){
        setState(() {
          screenView = AboutDevScreen();
        });
      } else {
        //
      }
    }
  }
}
