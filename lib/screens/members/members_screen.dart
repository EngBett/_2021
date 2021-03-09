import 'package:flutter/material.dart';

import 'components/body.dart';

class MembersScreen extends StatelessWidget {
  static String routeName = "/members";
  @override
  Widget build(BuildContext context) {
    List<dynamic> members = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("Members"),
      ),
      body: Body(members: members,)
    );
  }
}
