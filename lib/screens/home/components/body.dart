import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_aylf_mobile/helpers/general_controller.dart';
import 'package:new_aylf_mobile/helpers/hex_color.dart';
import 'package:new_aylf_mobile/screens/activities/activity_screen.dart';
import 'package:new_aylf_mobile/screens/events/events_screen.dart';
import 'package:new_aylf_mobile/screens/group/group_screen.dart';
import 'package:new_aylf_mobile/screens/home/components/appbar.dart';
import 'package:new_aylf_mobile/screens/resources/resources_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app_theme.dart';
import 'caruosel_ui.dart';
import 'group_view.dart';
import 'resources_view.dart';
import 'title_view.dart';
import 'volunteer_view.dart';

class Body extends StatefulWidget {
  Body({Key key, this.scaffoldKey}) : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with TickerProviderStateMixin {
  double topBarOpacity = 0.0;

  String _groupName;
  String _groupId;
  String _country;


  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _getUserDetails();

    super.initState();
  }

  void _getUserDetails() async {
    SharedPreferences storage = await SharedPreferences.getInstance();

    setState(() {
      _country = storage.get('country');
      _groupName = storage.get('group_name');
      _groupId = storage.get('group_id');
    });

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: AppTheme.white,
        body: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //Appbar
              HomeAppBar(),
              Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    CarouselUi(),
                    ResourcesListView(
                      scaffoldKey: _scaffoldKey,
                      callBacks: [
                        () {
                          openEvents();
                        },
                        () {
                          openVolunteer();
                        },
                        () {
                          openResource();
                        }
                      ],
                    ),
                    TitleView(
                      titleTxt: 'Volunteering',
                      subTxt: 'Activities',
                      function: () {},
                      hasIcon: false,
                    ),
                    VolunteerView(),
                    TitleView(
                      titleTxt: 'My Group',
                      subTxt: 'Go to',
                      function: () {
                        openGroup();
                      },
                    ),

                    GroupView(
                      groupName: _groupName != null ? _groupName : 'waiting...',
                      regionName: _country != null ? _country : 'waiting...',
                    )

                  ],
                ),
              )),

              SizedBox(
                height: MediaQuery.of(context).padding.bottom - 100,
              )
            ],
          ),
        ));
  }

  /*Navigation*/

  void openGroup() async {
    Navigator.pushNamed(context, GroupScreen.routeName,arguments: _groupId);
  }

  void openVolunteer() async {
    Navigator.pushNamed(context, ActivityScreen.routeName);
  }

  void openResource() async {
    Navigator.pushNamed(context, ResourcesScreen.routeName);
  }

  void openEvents() async {
    Navigator.pushNamed(context, EventScreen.routeName);
  }

}
