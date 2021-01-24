import 'package:flutter/material.dart';

import 'components/body.dart';

class YoutubeScreen extends StatelessWidget {
  static String routeName = "/youtube_screen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Videos"),
        ),
        body: Body()
    );
  }
}
