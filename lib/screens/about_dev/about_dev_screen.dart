import 'package:flutter/material.dart';

import 'components/body.dart';

class AboutDevScreen extends StatefulWidget {
  @override
  _AboutDevScreenState createState() => _AboutDevScreenState();
}

class _AboutDevScreenState extends State<AboutDevScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
