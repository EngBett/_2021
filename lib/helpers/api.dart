import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class CallApi{

  final String _url = "https://aylf-ke.herokuapp.com/api";

  Future<http.Response> getNews() async {
    var fullUrl = "http://newsapi.org/v2/everything?domains=wsj.com&apiKey=084e92e05f6444eeb1e9632f3b09240c";
    return await http.get(
        fullUrl,
        headers: _setHeaders()
    );
  }

  Future<http.Response> postData(data, apiUrl) async{
    var fullUrl = _url + apiUrl;

    return await http.post(
      fullUrl,
      body: jsonEncode(data),
      headers: _setHeaders()
    );
  }

  Future<String> uploadImage(filename, url, token) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('profPic', filename));

    request.headers.addAll({
      "Content-type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    });

    var res = await request.send();
    return res.reasonPhrase;
  }

  Future<http.Response> postDataWToken(data, apiUrl, token) async{
    var fullUrl = _url + apiUrl;

    return await http.post(
        fullUrl,
        body: jsonEncode(data),
        headers: {
          "Content-type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $token"
        }
    );
  }

  Future<http.Response> getData(apiUrl) async{
    var fullUrl = _url + apiUrl;
    
    return await http.get(
      fullUrl,
      headers: _setHeaders()
    );
  }


  Future<http.Response> getDataWToken(apiUrl, token) async{
    var fullUrl = _url + apiUrl;

    return await http.get(
        fullUrl,
        headers: {
          "Content-type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $token"
        }
    );
  }

  _setHeaders() => {
    "Content-type": "application/json",
    "Accept": "application/json"
  };

}