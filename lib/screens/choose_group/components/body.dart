import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:aylf/components/default_button.dart';
import 'package:aylf/constants.dart';
import 'package:aylf/helpers/args.dart';
import 'package:aylf/screens/complete_profile/complete_profile_screen.dart';
import '../../../size_config.dart';

class Body extends StatefulWidget {
  final List<List<String>> groups;

  const Body({Key key, this.groups}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var _errorMessage;
  bool _male = false;
  bool _female = false;

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
                SizedBox(height: getProportionateScreenHeight(20)),
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
            SizedBox(
              height: getProportionateScreenHeight(30),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Select Gender',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            Row(
              children: [
                Switch(
                  value: _male,
                  onChanged: (value) {
                    setState(() {
                      _errorMessage = null;
                      _male = value;
                      if (_female) {
                        _female = !_female;
                      }
                    });
                  },
                  activeTrackColor: kPrimaryColor.withOpacity(.5),
                  activeColor: kPrimaryColor,
                ),
                Text("Male")
              ],
            ),
            Row(
              children: [
                Switch(
                  value: _female,
                  onChanged: (value) {
                    setState(() {
                      _errorMessage = null;
                      _female = value;
                      if (_male) {
                        _male = !_male;
                      }
                    });
                  },
                  activeTrackColor: kPrimaryColor.withOpacity(.5),
                  activeColor: kPrimaryColor,
                ),
                Text("Female")
              ],
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
          height: getProportionateScreenHeight(50),
        ),
        DefaultButton(
          text: "Proceed",
          press: () {
            print(_group);
            if (_group == null) {
              setState(() {
                _errorMessage = "Please choose your group first";
              });
              return;
            }

            if (!_male && !_female) {
              setState(() {
                _errorMessage = "Please select your gender";
              });
              return;
            }

            var args = DetailArgs(_male?"Male":"Female", _group);

            Navigator.pushNamed(context, CompleteProfileScreen.routeName, arguments: args);
          },
        ),
      ],
    );
  }
}

