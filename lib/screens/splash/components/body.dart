import 'package:flutter/material.dart';
import 'package:new_aylf_mobile/helpers/hex_color.dart';
import 'package:new_aylf_mobile/screens/navigation/navigation_screen.dart';
import 'package:new_aylf_mobile/screens/sign_in/sign_in_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

// This is the best practice
import '../../../constants.dart';
import '../../../size_config.dart';
import '../components/splash_content.dart';
import '../../../components/default_button.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  List<Map<String,String>> splashData = [
    {
      "text":"We believe everything rises and falls with leadership. If we influence the leadership culture then the society will be a better place.",
      "color":"AA7C00"
    },
    {
      "text":"We believe if we live together as friends and in Love, then we can solve the most complex of problems.",
      "color":"0B9A17"
    },
    {
      "text":"We believe in leadership anchored in the Values, Principles, Precepts and the Person of Jesus.",
      "color":"DB5860"
    }
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  text: splashData[index]["text"],
                  color: HexColor(splashData[index]["color"]),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                            (index) => buildDot(index: index),
                      ),
                    ),
                    Spacer(flex: 3),
                    DefaultButton(
                      text: "Continue",
                      hasIcon: true,
                      icon: Icon(
                          Icons.arrow_forward_ios,
                        color: Colors.white,
                      ),
                      press: () async {
                        SharedPreferences storage = await SharedPreferences.getInstance();
                        if(storage.getString("token") == null){
                          Navigator.pushNamed(context, SignInScreen.routeName);
                        }else{
                          Navigator.pushNamed(context, NavigationScreen.routeName);
                        }

                      },
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
