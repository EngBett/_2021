import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'api.dart';

class Controller {
  static String token =
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjkyZjZkNTczMmRkNDQ0Y2NhYzFjNjc4N2IzM2QyZjA4NWE2MmVmYjM3M2VlYzM0YjBjMWY5ZmExZTkyZGZhZThiN2Q4ZGQyZThhMTViYTdlIn0.eyJhdWQiOiIxIiwianRpIjoiOTJmNmQ1NzMyZGQ0NDRjY2FjMWM2Nzg3YjMzZDJmMDg1YTYyZWZiMzczZWVjMzRiMGMxZjlmYTFlOTJkZmFlOGI3ZDhkZDJlOGExNWJhN2UiLCJpYXQiOjE2MTEyOTg4NDcsIm5iZiI6MTYxMTI5ODg0NywiZXhwIjoxNjQyODM0ODQ3LCJzdWIiOiIyOSIsInNjb3BlcyI6W119.H2sYPQsT-uLQvFwA-nvKkKoSsADKpUwUllfVyQVL6h-Pj3EY9IwAy1w0_JpWV3HSgmh_SbCs33X7TEQPt5mLNSLCv2O4fqYBKUUszpYPFqBAMYC_a4oJjlTHIicv2lDAy8NXaBofIooM2T3LkFeFyCeOMlzexs1oxOf8u8g10kO0dGzyqay1NFJESYnKlHlH7VeJMz215YfXrKH_hFa-BhZDJJvMOYQb2QW3RTzfhany8TRU4MmRbyPT1IOnjrVTaSdhCTckR1p6raMYLeMC09kztSfXuNU118g3S4ogF3SPr2oKPSfoJ9AHMY0tC4Y79GX1x4v0jVh8PegIl31hZ2ApQIaUYks_skpCYG9lIBpvjMetvtSc7SBujGfSFaFI1nP1sL-j2FlboXTpupGdzanAAikPLAMwaMs8OZjZTbEaDIiEOoFJnSog4_97hgVECrgmeHINafMi2or-Sn2iw2hE2_DMHMuZuF13gQz-34yMlYxnAyPX8jwqmgyeZxevEKCTwfuJtshLfJDGEI9ymyDiJjo5ZtNi95Orb8DMsKxSMEEg0N5kSy9efK7jeo9xazDe9sc4wIjxIGeHND_Q24DPyygRTcFtI-Q2Mt_L46vE9U3HDjOTiGI-lsA-I9-IGca-P-B1IUSlqsTKp97fvRfKFl2Qk6FkEtDPOETtdJ8";

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

    //var res = await CallApi().getDataWToken("/api-activities", storage.get('token'));
    var res = await CallApi().getDataWToken("/api-activities", token);
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

    //var res = await CallApi().getDataWToken("/api-activities/$activityId", storage.get('token'));
    var res = await CallApi()
        .getDataWToken("/api-activities/$activityId", storage.get('token'));
    var body = await json.decode(res.body);

    data = body["data"];

    return data;
  }

  /// Get group activities
  static Future<Map> checkIfVolunteered(int activityId) async {
    Map data;
    var storage = await SharedPreferences.getInstance();

    //var res = await CallApi().getDataWToken("/api-check-if-volunteered/$activityId", storage.get('token'));
    var res = await CallApi()
        .getDataWToken("/api-check-if-volunteered/$activityId", token);
    var body = await json.decode(res.body);

    data = body;

    return data;
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
      fullData.add(data);
    }

    return fullData;
  }

  /// Get Events
  static Future<List<Map>> getEvents() async {
    List<Map> fullData = [];
    var storage = await SharedPreferences.getInstance();

    //var res = await CallApi().getDataWToken("/api-events", storage.get('token'));
    var res = await CallApi().getDataWToken("/api-events", token);
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

    //var res = await CallApi().getDataWToken("/api-resources", storage.get('token'));
    var res = await CallApi().getDataWToken("/api-resources", token);
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
