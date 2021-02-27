import 'dart:convert';

import 'package:new_aylf_mobile/helpers/api.dart';

class Auth{
  static Future<Map> login(String email, String password) async {
    var data = {
      "email": email,
      "password": password,
    };

    var res = await CallApi().postData(data, '/login');
    return json.decode(res.body);

  }

  static Future<Map> register(
      String firstName,
      String middleName,
      String lastName,
      String email,
      String phone,
      String dob,
      String groupId,
      String gender,
      String password,
      String confirmPassword
      ) async {

    var data = {
      "firstname": firstName,
      "middlename": middleName,
      "lastname": lastName,
      "email": email,
      "phone": phone,
      "group_id": groupId,
      "dob": dob,
      "gender": gender,
      "password":password,
      "password_confirmation": confirmPassword
    };

    var res = await CallApi().postData(data, '/register');

    return json.decode(res.body);
  }

}