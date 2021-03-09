import 'package:flutter/material.dart';

import 'components/body.dart';

class EventScreen extends StatelessWidget {
  static String routeName = "/events";

  @override
  Widget build(BuildContext context) {
    final int groupId = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            groupId==null
                ? "Events"
                : "Group Events"
          ),
        ),
        body: InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Body(groupId: groupId,)));
  }
}
