import 'package:flutter/material.dart';

import 'components/body.dart';

class ResourcesScreen extends StatelessWidget {
  static String routeName = "/resources";
  @override
  Widget build(BuildContext context) {
    final int args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            args == null
                ? "Resources"
                : "Group Resources"
          ),
        ),
        body: Body(groupId: args,)
    );
  }
}
