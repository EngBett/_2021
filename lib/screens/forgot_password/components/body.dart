import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:aylf/app_theme.dart';
import 'package:aylf/components/custom_surfix_icon.dart';
import 'package:aylf/components/default_button.dart';
import 'package:aylf/components/form_error.dart';
import 'package:aylf/components/no_account_text.dart';
import 'package:aylf/helpers/api.dart';
import 'package:aylf/screens/sign_in/sign_in_screen.dart';
import 'package:aylf/screens/splash/splash_screen.dart';

import '../../../constants.dart';
import '../../../size_config.dart';


class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.04),
              Center(child: SizedBox(child: Image.asset("assets/images/aylf_logo.png"),)),
              Text(
                "Please enter your email and we will send \nyou a link to return to your account",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.1),
              ForgotPassForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class ForgotPassForm extends StatefulWidget {
  @override
  _ForgotPassFormState createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {
  final _formKey = GlobalKey<FormState>();
  List<String> errors = [];
  String email;
  bool _isLoading = false;
  String _successMessage = "";
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            onSaved: (newValue) => email = newValue,
            onChanged: (value) {
              if (value.isNotEmpty && errors.contains(kEmailNullError)) {
                setState(() {
                  errors.remove(kEmailNullError);
                });
              } else if (emailValidatorRegExp.hasMatch(value) &&
                  errors.contains(kInvalidEmailError)) {
                setState(() {
                  errors.remove(kInvalidEmailError);
                });
              }
              setState(() {
                errors.clear();
              });
              return null;
            },
            validator: (value) {
              if (value.isEmpty && !errors.contains(kEmailNullError)) {
                setState(() {
                  errors.add(kEmailNullError);
                });
              } else if (!emailValidatorRegExp.hasMatch(value) &&
                  !errors.contains(kInvalidEmailError)) {
                setState(() {
                  errors.add(kInvalidEmailError);
                });
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: "Email",
              hintText: "Enter your email",
              // If  you are using latest version of flutter then lable text and hint text shown like this
              // if you r using flutter less then 1.20.* then maybe this is not working properly
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          FormError(errors: errors),
          SizedBox(height: SizeConfig.screenHeight * 0.1),
          DefaultButton(
            text: _isLoading?"Sending...":"Send link",
            press: () async {
              if (_formKey.currentState.validate()) {
                setState(() {
                  _isLoading = !_isLoading;
                });


                print(emailController.text);

                var data = {
                  "email": emailController.text
                };

                var res = await CallApi().postData(data, '/password/email');
                var body = json.decode(res.body);


                if(res.statusCode == 200){

                  setState((){
                    _successMessage = body["message"];
                    emailController.clear();
                  });


                }else{
                  setState((){
                    errors.add(body['message']);
                    emailController.clear();
                  });
                }


                setState(() {
                  _isLoading = !_isLoading;
                  emailController.clear();
                });
              }
            },
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.1),
          Center(
            child: Text("$_successMessage",style: TextStyle(fontFamily: "futura",fontWeight: FontWeight.bold,color: Colors.green),),
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.1),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Back to ",
                style: TextStyle(fontSize: getProportionateScreenWidth(16)),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.popUntil(context, ModalRoute.withName(SplashScreen.routeName));
                  Navigator.pushNamed(context, SignInScreen.routeName);
                },
                child: Text(
                  "Sign In",
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(16),
                      color: kPrimaryColor),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
