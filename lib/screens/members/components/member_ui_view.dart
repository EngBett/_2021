import 'dart:convert';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';

import '../../../app_theme.dart';

class MemberUIView extends StatelessWidget {
  const MemberUIView({
    Key key,
    this.animationController,
    this.animation,
    this.name,
    this.email,
    this.phone,
  }) : super(key: key);


  final AnimationController animationController;
  final Animation<dynamic> animation;

  final String name;
  final String email;
  final String phone;

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
                              Container(
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        color: AppTheme.grey.withOpacity(0.6),
                                        offset: const Offset(2.0, 4.0),
                                        blurRadius: 8),
                                  ],
                                ),
                                child: GestureDetector(
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(40.0)),
                                    child: Image.asset('images/default-user-image.png'),
                                  ),
                                  onTap: () async{


                                  },
                                ),
                              ),

                              Padding(
                                  padding:
                                  const EdgeInsets.only(left: 15),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      Text(
                                        "$name",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontFamily: AppTheme.futura,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          letterSpacing: 0.27,
                                          color: AppTheme.aylfDark,
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
                                                "$email",
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
                                                "$phone",
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