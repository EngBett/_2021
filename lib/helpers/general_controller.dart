import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'api.dart';

class Controller {


  /// Get Countries
  static Future<List<List<String>>> getCountries() async {
    var res = await CallApi().getData('/api-countries');
    var body = await json.decode(res.body);

    List<List<String>> fulldata = [];

    for (var country in body['data']) {
      List<String> data = [];
      data.add("${country['id']}");
      data.add("${country['name']}");

      fulldata.add(data);
    }

    return fulldata;
  }

  /// Get Regions
  static Future<List<List<String>>> getRegions(int countryId) async {
    var res = await CallApi().getData('/api-countries/$countryId');
    var body = await json.decode(res.body);

    List<List<String>> fulldata = [];

    for (var region in body['regions']) {
      List<String> data = [];
      data.add("${region['id']}");
      data.add("${region['name']}");

      fulldata.add(data);
    }

    return fulldata;
  }

  /// Get Groups
  static Future<List<List<String>>> getGroups(int regionId) async {
    var res = await CallApi().getData('/api-regions/$regionId');
    var body = await json.decode(res.body);

    List<List<String>> fulldata = [];

    for (var region in body['data']['groups']) {
      List<String> data = [];
      data.add("${region['id']}");
      data.add("${region['name']}");

      fulldata.add(data);
    }

    return fulldata;
  }

  /// Get Group by id
  static Future<Map> getGroup(int groupId) async {
    var res = await CallApi().getData('/api-groups/$groupId');

    var body = await json.decode(res.body);

    return body["data"];
  }

  /// Get activities
  static Future<List<Map>> getActivities() async {
    List<Map> fullData = [];
    var storage = await SharedPreferences.getInstance();

    var res = await CallApi().getDataWToken("/api-activities", storage.get('token'));

    var body = await json.decode(res.body);

    for (Map data in body['data']) {
      fullData.add(data);
    }

    return fullData;
  }

  /// Get single Activity
  static Future<Map> getSingleActivity(int activityId) async {
    Map data;
    var storage = await SharedPreferences.getInstance();

    var res = await CallApi().getDataWToken("/api-activities/$activityId", storage.get('token'));

    var body = await json.decode(res.body);

    data = body["data"];

    return data;
  }

  /// Get group activities
  static Future<Map> checkIfVolunteered(int activityId) async {

    var storage = await SharedPreferences.getInstance();

    var res = await CallApi().getDataWToken("/api-check-if-volunteered/$activityId", storage.get('token'));

    var body = await json.decode(res.body);

    return body;
  }

  /// Get group activities
  static Future<List<Map>> getGroupActivities(int groupId) async {
    List<Map> fullData = [];
    var storage = await SharedPreferences.getInstance();

    var res = await CallApi()
        .getDataWToken("/api-group-activities/$groupId", storage.get('token'));
    var body = await json.decode(res.body);

    for (Map data in body['data']) {
      fullData.add(data);
    }

    return fullData;
  }

  /// Get group Events
  static Future<List<Map>> getGroupEvents(int groupId) async {
    List<Map> fullData = [];
    var storage = await SharedPreferences.getInstance();

    var res = await CallApi()
        .getDataWToken("/api-group-events/$groupId", storage.get('token'));
    var body = await json.decode(res.body);

    for (Map data in body['data']) {
      fullData.add(data);
    }

    return fullData;
  }

  /// Get group Resources
  static Future<List<Map>> getGroupResources(int groupId) async {
    List<Map> fullData = [];
    var storage = await SharedPreferences.getInstance();

    var res = await CallApi()
        .getDataWToken("/api-group-resources/$groupId", storage.get('token'));
    var body = await json.decode(res.body);

    for (Map data in body['data']) {
      fullData.add(data);
    }

    return fullData;
  }

  /// Get group News
  static Future<List<Map>> getGroupNews(int groupId) async {
    List<Map> fullData = [];
    var storage = await SharedPreferences.getInstance();

    var res = await CallApi()
        .getDataWToken("/api-group-news/$groupId", storage.get('token'));
    var body = await json.decode(res.body);

    for (Map data in body['data']) {
      fullData.add(data);
    }

    return fullData;
  }

  /// Get user activities
  static Future<List<Map>> getUserVolunteeredActivities() async {
    List<Map> fullData = [];
    var storage = await SharedPreferences.getInstance();

    var res = await CallApi().getDataWToken(
        "/api-user/get-volunteered-activities", storage.getString('token'));
    var body = await json.decode(res.body);

    for (Map data in body['data']) {
      if(data["activity"]==null){
        continue;
      }
      fullData.add(data["activity"]);
    }

    return fullData;
  }

  /// Get Events
  static Future<List<Map>> getEvents() async {
    List<Map> fullData = [];
    var storage = await SharedPreferences.getInstance();

    var res = await CallApi().getDataWToken("/api-events", storage.get('token'));

    var body = await json.decode(res.body);

    for (Map data in body['data']) {
      fullData.add(data);
    }

    return fullData;
  }

  /// Get Resources
  static Future<List<Map>> getResources() async {
    List<Map> fullData = [];
    var storage = await SharedPreferences.getInstance();

    var res = await CallApi().getDataWToken("/api-resources", storage.get('token'));

    var body = await json.decode(res.body);

    for (Map data in body['data']) {
      fullData.add(data);
    }

    return fullData;
  }

  ///Get three Resources
  static Future<List<Map>> getFewResources() async {
    List<Map> fullData = [];
    var allResources = await getResources();

    int i = 0;
    for (Map data in allResources) {
      if (i == 3) {
        break;
      }
      fullData.add(data);
      i++;
    }

    return fullData;
  }

  /// Get Resources
  static Future<List<Map>> getNews() async {
    List<Map> fullData = [];
    var storage = await SharedPreferences.getInstance();

    var res = await CallApi().getDataWToken("/api-news", storage.get('token'));
    var body = await json.decode(res.body);

    for (Map data in body['data']) {
      fullData.add(data);
    }

    return fullData;
  }
}
