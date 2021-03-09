import 'package:flutter/material.dart';
import 'package:aylf/helpers/args.dart';

import 'components/body.dart';

class SignUpScreen extends StatelessWidget {
  static String routeName = "/sign_up";
  @override
  Widget build(BuildContext context) {
    SignUpArgs args =  ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Body(signUpArgs: args,),
    );
  }
}
