import 'package:flutter/material.dart';

import 'components/body.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.groupName, this.regionName})
      : super(key: key);
  final String groupName;
  final String regionName;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) => SafeArea(
    child: Scaffold(
      body: Body(),
    ),
  );
}
