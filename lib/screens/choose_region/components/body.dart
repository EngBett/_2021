import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:aylf/components/default_button.dart';
import 'package:aylf/components/no_account_text.dart';
import 'package:aylf/components/socal_card.dart';
import 'package:aylf/helpers/api.dart';
import 'package:aylf/screens/choose_group/choose_group_screen.dart';
import '../../../size_config.dart';

class Body extends StatefulWidget {

  final List<List<String>> regions;

  const Body({Key key, this.regions}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var _errorMessage;
  String _region;
  List<List<String>> _regions;

  bool _loading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _regions = widget.regions;
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
                Center(child: SizedBox(child: Image.asset("assets/images/aylf_logo.png"),)),
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

  Widget selectRegion(){
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
                  'Choose Region',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize:14,
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),


            SizedBox(
              height: getProportionateScreenHeight(30),
            ),

            ListTile(
              title: _regions != null
                  ? DropdownButton(
                  isExpanded: true,
                  items: _regions.map((List dropDownStringItem) {
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
                  value: _region,
                  onChanged: (valueSelectedByUser) {
                    setState(() {
                      _region = valueSelectedByUser;
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
            if(!_loading){
              _loading = !_loading;
              if (_region == null) {
                _errorMessage = "Please choose your region first";
              }
              List<List<String>> groups = await _getGroups();
              Navigator.pushNamed(context, ChooseGroup.routeName,arguments: groups);
            }
          },
        ),
      ],
    );
  }

  Future<List<List<String>>> _getGroups() async {
    var res = await CallApi().getData('/api-groups');
    var body = await json.decode(res.body);


    List<List<String>> fulldata = [];

    for(var group in body['data']){
      List<String> data = [];
      data.add("${group['id']}");
      data.add("${group['name']} - ${group['region']['name']}");

      fulldata.add(data);
    }

    return fulldata;

  }

}
