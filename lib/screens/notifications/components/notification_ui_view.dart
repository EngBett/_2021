import 'dart:convert';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:aylf/constants.dart';

import '../../../app_theme.dart';

class NotificationUIView extends StatelessWidget {
  const NotificationUIView({
    Key key,
    this.animationController,
    this.animation, this.title, this.description, this.date, this.seen, this.id,
  }) : super(key: key);


  final AnimationController animationController;
  final Animation<dynamic> animation;

  final String title;
  final String description;
  final String date;
  final int seen;
  final int id;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
              transform: Matrix4.translationValues(
                  0.0, 50 * (1.0 - animation.value), 0.0),

              child: Padding(

                padding:EdgeInsets.all(10.0),

                child:Container(
                  decoration: BoxDecoration(
                    color: AppTheme.white,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8.0),
                        bottomRight: Radius.circular(8.0),
                        topRight: Radius.circular(8.0)
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: AppTheme.grey.withOpacity(0.4),
                          offset: const Offset(1.1, 1.1),
                          blurRadius: 10.0),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                        focusColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                        splashColor: AppTheme.nearlyDarkBlue.withOpacity(0.2),
                        onTap: (){

                        },
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [

                              Padding(
                                  padding:
                                  const EdgeInsets.only(left: 15),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      Text(
                                        "$title",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontFamily: AppTheme.futura,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          letterSpacing: 0.27,
                                          color: kPrimaryColor,
                                        ),
                                      ),

                                      SizedBox(height: 15,),

                                      Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          physics: const BouncingScrollPhysics(),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [

                                              Icon(
                                                FeatherIcons.mail,
                                                color: AppTheme.grey,
                                                size: 14,
                                              ),

                                              SizedBox(width: 5,),

                                              Text(
                                                "$description",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w200,
                                                  fontSize: 14,
                                                  letterSpacing: 0.1,
                                                  color: AppTheme.grey,
                                                ),
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                              ),

                                            ],
                                          ),
                                        ),
                                      ),

                                      Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          physics: const BouncingScrollPhysics(),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [

                                              Icon(
                                                FeatherIcons.phone,
                                                color: AppTheme.grey,
                                                size: 14,
                                              ),

                                              SizedBox(width: 5,),

                                              Text(
                                                "$date",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w200,
                                                  fontSize: 14,
                                                  letterSpacing: 0.1,
                                                  color: AppTheme.grey,
                                                ),
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                              ),

                                            ],
                                          ),
                                        ),
                                      ),

                                    ],
                                  )
                              ),

                            ],
                          ),
                        )
                    ),
                  ),
                ),

              )
          ),
        );
      },
    );
  }
}