import 'dart:convert';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:new_aylf_mobile/components/default_button.dart';
import 'package:new_aylf_mobile/components/no_account_text.dart';
import 'package:new_aylf_mobile/components/socal_card.dart';
import 'package:new_aylf_mobile/helpers/api.dart';
import 'package:new_aylf_mobile/screens/choose_region/choose_region_screen.dart';
import 'package:new_aylf_mobile/screens/complete_profile/complete_profile_screen.dart';
import '../../../size_config.dart';

class Body extends StatefulWidget {
  final List<List<String>> groups;

  const Body({Key key, this.groups}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var _errorMessage;
  String _group;
  List<List<String>> _groups;

  //date format
  final format = DateFormat("yyyy-MM-dd");
  TextEditingController dobController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _groups = widget.groups;
    });
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.02),
                Center(
                    child: SizedBox(
                  child: Image.asset("assets/images/aylf_logo.png"),
                )),
                Text(
                  "Sign in with your email and password  \nor continue with social media",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                selectRegion(),
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
                NoAccountText(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget selectRegion() {
    return Column(
      children: [
        SizedBox(
          height: getProportionateScreenHeight(20),
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Choose Group',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
            SizedBox(
              height: getProportionateScreenHeight(30),
            ),
            ListTile(
              title: _groups != null
                  ? DropdownButton(
                      isExpanded: true,
                      items: _groups.map((List dropDownStringItem) {
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem[0],
                          child: Text(
                            dropDownStringItem[1],
                            style: TextStyle(
                                color: Colors.black,
                                fontSize:
                                    MediaQuery.of(context).size.width > 360
                                        ? 17
                                        : 15,
                                fontWeight: FontWeight.normal),
                          ),
                        );
                      }).toList(),
                      value: _group,
                      onChanged: (valueSelectedByUser) {
                        setState(() {
                          _group = valueSelectedByUser;
                          _errorMessage = null;
                        });
                      })
                  : Center(
                      child: Text("loading..."),
                    ),
            ),
            if (_errorMessage != null)
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
            if (_errorMessage != null)
              Text(
                "*$_errorMessage*",
                style: TextStyle(color: Colors.red, fontSize: 13),
              )
          ],
        ),
        SizedBox(
          height: getProportionateScreenHeight(100.0),
        ),
        DefaultButton(
          text: "Proceed",
          press: () {
            print(_group);
            if (_group == null) {
              setState(() {
                _errorMessage = "Please choose your group first";
              });

            }

            Navigator.pushNamed(context, CompleteProfileScreen.routeName);
          },
        ),
      ],
    );
  }
}
