import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:aylf/components/custom_surfix_icon.dart';
import 'package:aylf/components/default_button.dart';
import 'package:aylf/components/form_error.dart';
import 'package:aylf/helpers/args.dart';
import 'package:aylf/screens/sign_up/sign_up_screen.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class CompleteProfileForm extends StatefulWidget {
  final DetailArgs detailArgs;

  const CompleteProfileForm({Key key, this.detailArgs}) : super(key: key);

  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  String firstName;
  String lastName;
  String phoneNumber;
  String dob;

  bool _loading = false;

  //Date format
  final format = DateFormat("yyyy-MM-dd");

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildFirstNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildLastNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildDOBField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPhoneNumberFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "continue",
            press: () {
              if (_formKey.currentState.validate()) {
                if(!_loading){
                  _loading = !_loading;
                  var signUpArgs = SignUpArgs(widget.detailArgs, firstName, lastName, dob.split(" ")[0], phoneNumber);
                  Navigator.pushNamed(context, SignUpScreen.routeName,arguments: signUpArgs);
                }
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => phoneNumber = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
          removeError(error: "format your phone no e.g. 254712345678");
        }
        phoneNumber = value;
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPhoneNumberNullError);
          return "";
        }else{
          if(value.length<12){
            addError(error: "format your phone no e.g. 254712345678");
            return "";
          }
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Phone Number",
        hintText: "e.g. 254712345678",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Call.svg"),
      ),
    );
  }

  TextFormField buildLastNameFormField() {
    return TextFormField(
      onSaved: (newValue) => lastName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: "Please enter your last name");
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: "Please enter your last name");
          return "";
        }
        lastName = value;
        return null;
      },
      decoration: InputDecoration(
        labelText: "Last Name",
        hintText: "e.g. Mandela",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User Icon.svg"),
      ),
    );
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      onSaved: (newValue) => firstName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: "Please enter your first name");
        }
        firstName = value;
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: "Please enter your first name");
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "First Name",
        hintText: "e.g. Nelson",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User Icon.svg"),
      ),
    );
  }

  DateTimeField buildDOBField() {
    return DateTimeField(
      format: format,
      onShowPicker: (context, currentValue) {
        return showDatePicker(
            context: context,
            firstDate: DateTime(1900),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime(2100));
      },
      onChanged: (value) {
        setState(() {
          dob = value.toString();
        });
      },
      validator: (value) {
        if (value == null) {
          addError(error: "Please choose your date of birth");
        }
      },
      decoration: InputDecoration(
        labelText: "Date of Birth",
        hintText: "Choose date of birth",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/calendar.svg"),
      ),
    );
  }
}
