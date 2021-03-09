import 'package:flutter/material.dart';
import 'package:aylf/app_theme.dart';
import 'package:aylf/screens/sign_in/sign_in_screen.dart';
import 'package:aylf/screens/splash/splash_screen.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.02),
                Center(child: SizedBox(child: Image.asset("assets/images/aylf_logo.png"),)),
                SizedBox(height: getProportionateScreenHeight(200)),

                Text(
                  "Verify Email to continue",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: AppTheme.futura,
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                  ),
                ),

                SizedBox(height: getProportionateScreenHeight(300)),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Proceed to Sign In ",
                      style: TextStyle(fontSize: getProportionateScreenWidth(16)),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.popUntil(context, ModalRoute.withName(SplashScreen.routeName));
                        Navigator.pushNamed(context, SignInScreen.routeName);
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(16),
                            color: kPrimaryColor),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
