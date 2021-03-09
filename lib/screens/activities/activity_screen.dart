import 'package:flutter/material.dart';

import 'components/body.dart';

class ActivityScreen extends StatelessWidget {
  static String routeName = "/activity";

  @override
  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(
          title: args == null
              ? Text("Activities")
              : Text(args["groupId"] != null
                  ? "Group Activities"
                  : "User Activities"),
        ),
        body: Body(
          groupId: args == null? null : args["groupId"],
          userActivities: args == null? null : args["userActivities"],
        ));
  }
}
