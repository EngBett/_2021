import 'package:flutter/material.dart';

import 'components/body.dart';

class ChooseGroup extends StatelessWidget {
  static String routeName = "/choose_group";
  @override
  Widget build(BuildContext context) {
    final List<List<String>> groups = ModalRoute.of(context).settings.arguments;
    return Scaffold(
            appBar: AppBar(
              title: Text("Sign Up"),
            ),
            body: Body(groups: groups,),
          );
  }
}
