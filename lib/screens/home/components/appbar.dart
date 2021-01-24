import 'package:flutter/material.dart';
import 'package:new_aylf_mobile/helpers/hex_color.dart';
import 'package:new_aylf_mobile/screens/notifications/notifications_screen.dart';

import '../../../size_config.dart';
import 'icon_btn_with_counter.dart';

class HomeAppBar extends StatefulWidget {
  @override
  _HomeAppBarState createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppBar().preferredSize.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 20),
            child: Container(
              width: AppBar().preferredSize.height - 8,
              height: AppBar().preferredSize.height - 8,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: getProportionateScreenWidth(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[


                  Row(
                    children: [

                      Container(
                        width: getProportionateScreenWidth(50.0),
                        height: getProportionateScreenHeight(50.0),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: ExactAssetImage("assets/images/aylf_logo.png"),
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),

                      Container(
                        width: 10.0,
                        height: 50.0,
                      ),

                      Text(
                        'AYLF',
                        style: TextStyle(
                          fontSize: 22,
                          color: HexColor("D5A52E"),
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                    ],
                  ), //Container

                  IconBtnWithCounter(
                    svgSrc: "assets/icons/Bell.svg",
                    numOfitem: 3,
                    press: () {
                      Navigator.pushNamed(context, NotificationsScreen.routeName);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
