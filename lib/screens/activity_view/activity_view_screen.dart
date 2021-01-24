import 'package:flutter/material.dart';

import 'components/body.dart';

class ActivityViewScreen extends StatelessWidget {
  static String routeName = "/activity_view_screen";
  @override
  Widget build(BuildContext context) {
    final Map activity = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(
          title: Text(""),
        ),
        body: Body(activity: activity,)
    );
  }
}
