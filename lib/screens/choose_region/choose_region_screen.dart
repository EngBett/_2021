import 'package:flutter/material.dart';

import 'components/body.dart';

class ChooseRegion extends StatelessWidget {
  static String routeName = "/choose_region";
  @override
  Widget build(BuildContext context) {
    final List<List<String>> regions = ModalRoute.of(context).settings.arguments;
    return Scaffold(
            appBar: AppBar(
              title: Text("Sign Up"),
            ),
            body: Body(regions: regions,),
          );
  }
}
