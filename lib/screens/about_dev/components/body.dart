import 'package:flutter/material.dart';
import 'package:new_aylf_mobile/helpers/hex_color.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app_theme.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body>  with TickerProviderStateMixin{

  final double infoHeight = 364.0;
  AnimationController animationController;
  Animation<double> animation;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    setData();
    super.initState();
  }


  Future<void> setData() async {
    animationController.forward();
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity1 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity2 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity3 = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {

    final double tempHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).size.width / 1.2) +
        24.0;

    return Container(
      color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 1,
                    child: Image.asset('assets/images/undraw/developer_activity.png'),
                  ),
                ],
              ),
              Positioned(
                top: (MediaQuery.of(context).size.width / 1.2) - 24.0,
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppTheme.nearlyWhite,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(32.0),
                        topRight: Radius.circular(32.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: AppTheme.grey.withOpacity(0.2),
                          offset: const Offset(1.1, 1.1),
                          blurRadius: 10.0),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: SingleChildScrollView(
                      child: Container(
                        constraints: BoxConstraints(
                            minHeight: infoHeight,
                            maxHeight: tempHeight > infoHeight
                                ? tempHeight
                                : infoHeight),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 32.0, left: 18, right: 16),
                              child: Text(
                                'Developers',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 22,
                                  letterSpacing: 0.27,
                                  color: AppTheme.darkerText,
                                ),
                              ),
                            ),

                            SizedBox(height: 20,),

                            Divider(height: 1,),

                            SizedBox(height: 20,),

                            Expanded(
                              child: AnimatedOpacity(
                                duration: const Duration(milliseconds: 500),
                                opacity: opacity2,
                                child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16, right: 16, top: 8, bottom: 8),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[

                                        Text(
                                          'Developed by:',
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w200,
                                            fontFamily: AppTheme.fontName,
                                            fontSize: MediaQuery.of(context).size.width > 360 ? 20 : 18,
                                            letterSpacing: 0.27,
                                            color: AppTheme.grey,
                                          ),
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),


                                        SizedBox(height: 10,),

                                        Row(children: <Widget>[
                                          Text(
                                            "Ronald Bett",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w200,
                                              fontFamily: AppTheme.fontName,
                                              fontSize: MediaQuery.of(context).size.width > 360 ? 20 : 18,
                                              letterSpacing: 0.27,
                                              color: HexColor("0078D7"),
                                            ),
                                          ),

                                          Text(
                                            " & ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w200,
                                              fontFamily: AppTheme.fontName,
                                              fontSize: MediaQuery.of(context).size.width > 360 ? 20 : 18,
                                              letterSpacing: 0.27,
                                              color: HexColor("0078D7"),
                                            ),
                                          ),
                                          Text(
                                            "Patrick Mwangi",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w200,
                                              fontFamily: AppTheme.fontName,
                                              fontSize: MediaQuery.of(context).size.width > 360 ? 20 : 18,
                                              letterSpacing: 0.27,
                                              color: HexColor("0078D7"),
                                            ),
                                          )
                                        ],),

                                        SizedBox(height: 30,),

                                        Text(
                                          'For more info click below',
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w200,
                                            fontFamily: AppTheme.fontName,
                                            fontSize: MediaQuery.of(context).size.width > 360 ? 20 : 18,
                                            letterSpacing: 0.27,
                                            color: AppTheme.grey,
                                          ),
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),

                                        SizedBox(height: 10,),

                                        InkWell(
                                          onTap: (){
                                            _launchURL("https://icodeio.com");
                                          },
                                          child: Text(
                                            'https://icodeio.com',
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w200,
                                              fontFamily: AppTheme.fontName,
                                              fontSize: MediaQuery.of(context).size.width > 360 ? 20 : 18,
                                              letterSpacing: 0.27,
                                              color: HexColor("0078D7"),
                                            ),
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),

                                      ],)
                                ),
                              ),
                            ),


                            SizedBox(
                              height: MediaQuery.of(context).padding.bottom,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

