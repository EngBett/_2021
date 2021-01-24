import 'package:flutter/material.dart';

import 'components/body.dart';

class GroupScreen extends StatelessWidget {
  static String routeName = "/group";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Group"),
        ),
        body: Body()
    );
  }
}
