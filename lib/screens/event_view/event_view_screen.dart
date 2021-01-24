import 'package:flutter/material.dart';

import 'components/body.dart';

class EventViewScreen extends StatelessWidget {
  static String routeName = "/event_view_screen";
  @override
  Widget build(BuildContext context) {
    final Map event = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(
          title: Text(""),
        ),
        body: Body(event: event,)
    );
  }
}
