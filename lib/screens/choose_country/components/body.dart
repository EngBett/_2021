import 'package:flutter/material.dart';
import 'package:new_aylf_mobile/components/default_button.dart';
import 'package:new_aylf_mobile/components/no_account_text.dart';
import 'package:new_aylf_mobile/components/socal_card.dart';
import 'package:new_aylf_mobile/helpers/general_controller.dart';
import 'package:new_aylf_mobile/screens/choose_region/choose_region_screen.dart';
import '../../../size_config.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String _errorMessage;
  String _country;

  List<List<String>> _countries;
  bool _loading = false;

  _getCountries() async {
    var countries = await Controller.getCountries();
    setState(() {
      _countries = countries;
    });
  }

  @override
  void initState() {
    _getCountries();
    super.initState();
  }

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
                selectCountry(),
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

  Widget selectCountry() {
    return Column(
      children: [
        SizedBox(
          height: getProportionateScreenHeight(50),
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Choose Country',
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
              title: _countries != null
                  ? DropdownButton(
                      isExpanded: true,
                      items: _countries.map((List dropDownStringItem) {
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
                      value: _country,
                      onChanged: (valueSelectedByUser) {
                        setState(() {
                          _country = valueSelectedByUser;
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
          press: () async {
            if (!_loading) {
              _loading = !_loading;
              if (_country == null) {
                setState(() {
                  _errorMessage = "Please choose your country first";
                });
              }

              List<List<String>> regions =
                  await Controller.getRegions(int.parse(_country));
              Navigator.pushNamed(context, ChooseRegion.routeName,
                  arguments: regions);
            }
          },
        ),
      ],
    );
  }
}
