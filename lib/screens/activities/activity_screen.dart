import 'package:flutter/material.dart';

import 'components/body.dart';

class ActivityScreen extends StatelessWidget {
  static String routeName = "/activity";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Activities"),
        ),
        body: Body()
    );
  }
}
