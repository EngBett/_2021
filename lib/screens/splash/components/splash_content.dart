import 'package:flutter/material.dart';
import 'package:new_aylf_mobile/app_theme.dart';

import '../../../size_config.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key key,
    this.text, this.color,
  }) : super(key: key);
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Spacer(),
        Center(
            child: SizedBox(
          child: Image.asset("assets/images/aylf_logo.png"),
        )),
        Text(
          "Nurturing a new breed of Leaders in Africa",
          textAlign: TextAlign.center,
        ),
        Spacer(flex: 2),
        SizedBox(
          height: getProportionateScreenHeight(265),
          width: double.infinity,
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
              child: Text(
                  text,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: color.withOpacity(.7),
                  fontFamily: AppTheme.futura,
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                ),
              ),
            ),
          ),
        ),

      ],
    );
  }
}
