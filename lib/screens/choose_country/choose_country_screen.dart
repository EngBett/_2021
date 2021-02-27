import 'package:flutter/material.dart';

import 'components/body.dart';

class ChooseCountry extends StatelessWidget {
  static String routeName = "/choose_country";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
              title: Text("Sign Up"),
            ),
            body: Body(),
          );
  }
}
