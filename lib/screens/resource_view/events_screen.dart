import 'package:flutter/material.dart';

import 'components/body.dart';

class EventScreen extends StatelessWidget {
  static String routeName = "/events";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Events"),
        ),
        body: Body()
    );
  }
}
