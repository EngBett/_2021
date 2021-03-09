import 'dart:convert';

import 'package:aylf/helpers/api.dart';

class Auth{
  static Future<Map> login(String email, String password) async {
    var data = {
      "email": email,
      "password": password,
    };

    var res = await CallApi().postData(data, '/login');
    return json.decode(res.body);

  }

  static Future<Map> register(Map data) async {
    var res = await CallApi().postData(data, '/register');

    return json.decode(res.body);
  }

}