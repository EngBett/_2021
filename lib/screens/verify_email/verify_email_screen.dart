import 'package:flutter/material.dart';

import 'components/body.dart';

class VerifyEmailScreen extends StatelessWidget {
  static String routeName = "/verify_email";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: Body(),
    );
  }
}
