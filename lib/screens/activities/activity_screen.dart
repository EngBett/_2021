import 'package:flutter/material.dart';

import 'components/body.dart';

class ActivityScreen extends StatelessWidget {
  static String routeName = "/activity";
  @override
  Widget build(BuildContext context) {
    final int groupId = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(
          title: Text("Activities"),
        ),
        body: Body(groupId: groupId,)
    );
  }
}
