import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:aylf/app_theme.dart';
import 'package:aylf/helpers/general_controller.dart';
import 'package:aylf/screens/activities/activity_screen.dart';
import 'package:aylf/screens/events/events_screen.dart';
import 'package:aylf/screens/members/members_screen.dart';
import 'package:aylf/screens/resources/resources_screen.dart';
import 'package:aylf/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  String _country;

  @override
  void initState() {
    getGroup();
    super.initState();
  }

  getGroup() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    Map e = await Controller.getGroup(widget.groupId);

    setState(() {
      _group = e;
      _country = storage.getString('country');
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
                _group != null ? "${_group['name']}" : "Waiting ...",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      "${_group != null ? _group["region"]["name"] : "Waiting ..."}, "),
                  Text(_country != null ? _country : "Waiting ...")
                ],
              ),
              SizedBox(
                height: getProportionateScreenHeight(10),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "${_group != null ? _group['members'].length : 0}",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Members",
                    style: TextStyle(fontSize: 11, letterSpacing: -1),
                  )
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          ProfileMenu(
            text: "Members",
            icon: "",
            alt: Icon(
              FeatherIcons.users,
              color: AppTheme.aylfMain,
              size: getProportionateScreenWidth(20),
            ),
            press: (){
              Navigator.pushNamed(context, MembersScreen.routeName,
                  arguments: _group["members"]);
            },
          ),
          ProfileMenu(
            text: "Activities",
            icon: "",
            alt: Icon(
              FeatherIcons.activity,
              color: AppTheme.aylfMain,
              size: getProportionateScreenWidth(20),
            ),
            press: () => {
              Navigator.pushNamed(context, ActivityScreen.routeName,
                  arguments: {"groupId": _group["id"]})
            },
          ),
          ProfileMenu(
            text: "Events",
            icon: "",
            alt: Icon(
              FeatherIcons.calendar,
              color: AppTheme.aylfMain,
              size: getProportionateScreenWidth(20),
            ),
            press: () => {
              Navigator.pushNamed(context, EventScreen.routeName,
                  arguments: _group["id"])
            },
          ),
          ProfileMenu(
            text: "Resources",
            icon: "",
            alt: Icon(
              FeatherIcons.paperclip,
              color: AppTheme.aylfMain,
              size: getProportionateScreenWidth(20),
            ),
            press: () => {
              Navigator.pushNamed(context, ResourcesScreen.routeName,
                  arguments: _group["id"])
            },
          ),
        ],
      ),
    );
  }
}
