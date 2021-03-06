import 'package:flutter/material.dart';
import 'package:aylf/components/custom_surfix_icon.dart';
import 'package:aylf/components/default_button.dart';
import 'package:aylf/components/form_error.dart';
import 'package:aylf/components/socal_card.dart';
import 'package:aylf/helpers/args.dart';
import 'package:aylf/helpers/general_controller.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import 'sign_up_form.dart';

class Body extends StatefulWidget {
  final SignUpArgs signUpArgs;

  const Body({Key key, this.signUpArgs}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.04), // 4%
                Center(
                    child: SizedBox(
                  child: Image.asset("assets/images/aylf_logo.png"),
                )),
                Text(
                  "Complete your details or continue \nwith social media",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                SignUpForm(
                  signUpArgs: widget.signUpArgs,
                ),

                SizedBox(height: SizeConfig.screenHeight * 0.08),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocalCard(
                      icon: "assets/icons/google-icon.svg",
                      press: () {},
                    ),
                  ],
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'By continuing you confirm that you agree with our',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.caption,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        "Terms and Conditions",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: getProportionateScreenWidth(9)),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
