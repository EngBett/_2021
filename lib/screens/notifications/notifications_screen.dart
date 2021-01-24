import 'package:flutter/material.dart';

import 'components/body.dart';

class NotificationsScreen extends StatelessWidget {
  static String routeName = "/notifications";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Notifications"),
        ),
        body: Body()
    );
  }
}
