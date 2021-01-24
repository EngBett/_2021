import 'package:flutter/material.dart';

import 'components/body.dart';

class ResourcesScreen extends StatelessWidget {
  static String routeName = "/resources";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Resources"),
        ),
        body: Body()
    );
  }
}
