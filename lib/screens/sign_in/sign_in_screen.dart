import 'package:flutter/material.dart';

import 'components/body.dart';

class SignInScreen extends StatelessWidget {
  static String routeName = "/sign_in";

  @override
  Widget build(BuildContext context) {
    final bool args = ModalRoute.of(context).settings.arguments;
    return args == null
        ? Scaffold(
            appBar: AppBar(
              title: Text("Sign In"),
            ),
            body: Body(),
          )
        : WillPopScope(
            child: Scaffold(
              appBar: AppBar(
                title: Text("Sign In"),
              ),
              body: Body(),
            ),
            onWillPop: () async =>false);
  }
}
