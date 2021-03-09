import 'dart:convert';

import 'package:aylf/services/db_service.dart';
import 'package:aylf/services/models/Notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:aylf/screens/activities/activity_screen.dart';
import 'package:aylf/screens/events/events_screen.dart';
import 'package:aylf/screens/group/group_screen.dart';
import 'package:aylf/screens/home/components/appbar.dart';
import 'package:aylf/screens/notifications/notifications_screen.dart';
import 'package:aylf/screens/resources/resources_screen.dart';
import 'package:aylf/size_config.dart';
import 'package:intl/intl.dart';
import 'package:pusher_websocket_flutter/pusher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

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
  int _notifications = -1;
  String _groupName;
  String _regionName;

  //Database
  DatabaseHelper databaseHelper = DatabaseHelper();

  Channel _channel;

  int channelDataNotificationCount=0;
  List<String> channelDataNotifier;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings androidInitializationSettings;
  IOSInitializationSettings iosInitializationSettings;
  InitializationSettings initializationSettings;

  @override
  void initState() {
    _initPusher();
    _inizializeNotifications();
    _getGroup();
    super.initState();
  }

  void _getGroup() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    setState(() {
      _groupId = storage.getInt('group_id');
      _groupName = storage.getString('group_name');
      _regionName = storage.getString('region_name');
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //update Notifications here
    if(_notifications==-1){
      _notifications=0;
      _updateNotifications();
    }
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: <Widget>[
          SizedBox(
            height: getProportionateScreenHeight(10),
          ),
          HomeAppBar(notifications: _notifications,),
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
          InkWell(
            onTap: () {
              setState(() {
              });
            },
            child: GroupView(
              groupName: _groupName != null ? _groupName : 'waiting...',
              regionName: _regionName != null ? _regionName : 'waiting...',
            ),
          ),
        ],
      ),
    );
  }

  /*Navigation*/

  void openGroup() async {
    Navigator.pushNamed(context, GroupScreen.routeName, arguments: _groupId);
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

  Future<void> _initPusher() async {
    try {
      await Pusher.init("c89f8467f4343c87029c", PusherOptions(cluster: "ap2"));
    } catch (e) {
      print(e);
    }

    //Connect pusher
    Pusher.connect(onConnectionStateChange: (val) {
      print(val.currentState);
    }, onError: (err) {
      print(err.message);
    });

    //Subscribe
    _channel = await Pusher.subscribe("aylf_notifications");

    //bind
    _channel.bind('notification_event', (event) {
      Map data = json.decode(event.data);
      var title = data["type"].toLowerCase()=="resource"? "New Resource" : "Upcoming ${data["type"]}";
      var description = data["type"].toLowerCase()=="resource"? "A New Resource was recently uploaded": "A new ${data["type"]} has been created";

      _showNotifications(_notifications, title, description);

      //Add to database
      var notification = Notif(title,_currentTime(),1,description);
      databaseHelper.insertNote(notification);

      //update notification
      _updateNotifications();
    });
  }

  void _inizializeNotifications() async {
    androidInitializationSettings = AndroidInitializationSettings("aylf_logo");
    iosInitializationSettings = IOSInitializationSettings(
        onDidReceiveLocalNotification: _onDidReceiveLocalNotification);
    initializationSettings = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: _onSelectNotification);
  }

  void _showNotifications(int id, String title, String body) async {
    await _notification(id,title,body);
  }

  Future<void> _notification(int id, String title, String body) async {
    AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
        "Channel ID",
        "Channel title",
        "channel body",
        priority: Priority.high,
        importance: Importance.max,
        ticker: 'test'
    );

    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();

    NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails, iOS: iosNotificationDetails);
    await flutterLocalNotificationsPlugin.show(id, title, body, notificationDetails);
  }

  Future _onSelectNotification(String payLoad) async{
    if(payLoad!=null){
      print(payLoad);
    }
    Navigator.pushNamed(context, NotificationsScreen.routeName);
  }

  Future _onDidReceiveLocalNotification(int id, String title, String body, String payload)async{
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: CupertinoAlertDialog(
        title: Text(title),
        content: Text(body),
        actions: [
          CupertinoDialogAction(
            child: Text("Okay"),
            isDefaultAction: true,
            onPressed: (){
              print("");
            },
          )
        ],
      ),
    );
  }

  void _updateNotifications() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database){

      Future<int> notificationCount = databaseHelper.getCount();
      notificationCount.then((value) {
        setState((){
          _notifications = value;
        });
      });

    });
  }

  String _currentTime() {
    final DateTime now = DateTime. now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd Hm');
    String formatted = formatter. format(now);
    return formatted; // something like 2013-04-20.
  }


}
