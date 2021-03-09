import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:aylf/screens/activities/activity_screen.dart';
import 'package:aylf/screens/group/group_screen.dart';
import 'package:aylf/screens/splash/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app_theme.dart';
import '../../../size_config.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatefulWidget {
  final Map user;

  const Body({Key key, this.user}) : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics:const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(user: widget.user,),
          SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "${widget.user["data"]['firstname']} ${widget.user["data"]['lastname']}",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ],
          ),
          SizedBox(height: 20),
          ProfileMenu(
            text: "Activities",
            icon: "",
            alt: Icon(FeatherIcons.activity,color: AppTheme.aylfMain,size: getProportionateScreenWidth(20),),
            press: () => {
              Navigator.pushNamed(context, ActivityScreen.routeName,
                  arguments: {"userActivities": true})
            },
          ),
          ProfileMenu(
            text: "My group",
            icon: "",
            alt: Icon(FeatherIcons.users,color: AppTheme.aylfMain,size: getProportionateScreenWidth(20),),
            press: () async {
              var storage = await SharedPreferences.getInstance();
              Navigator.pushNamed(context, GroupScreen.routeName,arguments: storage.getInt('group_id'));
            },
          ),
          ProfileMenu(
            text: "Settings",
            icon: "assets/icons/Settings.svg",
            press: () {},
          ),

          ProfileMenu(
            text: "Log Out",
            icon: "assets/icons/Log out.svg",
            press: () async {
              var storage = await SharedPreferences.getInstance();
              storage.clear();
              Navigator.popUntil(context, ModalRoute.withName(SplashScreen.routeName));
            },
          ),
        ],
      ),
    );
  }
}
