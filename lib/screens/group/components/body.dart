import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:new_aylf_mobile/app_theme.dart';
import 'package:new_aylf_mobile/helpers/general_controller.dart';
import 'package:new_aylf_mobile/screens/activities/activity_screen.dart';
import 'package:new_aylf_mobile/screens/members/members_screen.dart';
import 'package:new_aylf_mobile/size_config.dart';

import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatefulWidget {
  final int groupId;

  const Body({Key key, @required this.groupId}) : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  Map _group;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<void> getEvents() async{
    Map e = await Controller.getGroup(widget.groupId);

    setState(() {
      _group = e;
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(),
          SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Nairobi Aylf Group",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text("Nairobi, "), Text("Kenya")],
              ),
              SizedBox(
                height: getProportionateScreenHeight(10),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "27",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Text("Members",style: TextStyle(fontSize: 11,letterSpacing: -1),)
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          ProfileMenu(
            text: "Members",
            icon: "",
            alt: Icon(FeatherIcons.users,color: AppTheme.aylfMain,size: getProportionateScreenWidth(20),),
            press: () => {
              Navigator.pushNamed(context, MembersScreen.routeName,arguments: _group["members"])
            },
          ),
          ProfileMenu(
            text: "Activities",
            icon: "",
            alt: Icon(FeatherIcons.activity,color: AppTheme.aylfMain,size: getProportionateScreenWidth(20),),
            press: () => {
              Navigator.pushNamed(context, ActivityScreen.routeName,arguments: _group["id"])
            },
          ),
          ProfileMenu(
            text: "Events",
            icon: "",
            alt: Icon(FeatherIcons.calendar,color: AppTheme.aylfMain,size: getProportionateScreenWidth(20),),
            press: () => {
              Navigator.pushNamed(context, ActivityScreen.routeName,arguments: _group["events"])
            },
          ),
          ProfileMenu(
            text: "Resources",
            icon: "",
            alt: Icon(FeatherIcons.paperclip,color: AppTheme.aylfMain,size: getProportionateScreenWidth(20),),
            press: () => {
              Navigator.pushNamed(context, ActivityScreen.routeName,arguments: _group["resources"])
            },
          ),
        ],
      ),
    );
  }
}
