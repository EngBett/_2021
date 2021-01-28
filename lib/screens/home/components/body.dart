import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_aylf_mobile/helpers/general_controller.dart';
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
  Body({Key key}) : super(key: key);


  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with TickerProviderStateMixin {
  double topBarOpacity = 0.0;

  int _groupId;
  String _groupName;
  String _regionName;

  @override
  void initState() {
    _getGroup();
    super.initState();
  }

  void _getGroup() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    _groupId = storage.getInt('group_id');
    _groupName = storage.getString('group_name');
    _regionName = storage.getString('region_name');
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      regionName: _regionName != null ? _regionName : 'waiting...',
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
