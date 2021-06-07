import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:oneaddress/Services/Network_Cache_Management/SharedPref.dart';

class NetworkHelper {
  NetworkHelper(this.url);
  final String url;

  Future getData() async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      String responseData = utf8.decode(response.bodyBytes);
      return jsonDecode(responseData);
    } else {
      print(response.statusCode);
      return null;
    }
  }

  Future getDataWithKey(String key,
      {bool checkInMemory = true, bool saveInMemory = true}) async {
    String responseData = null;
    SharedPref sharedPref = null;
    if (checkInMemory) {
      sharedPref = SharedPref();
      responseData = await sharedPref.read(key);
      if (responseData != null) {
        return jsonDecode(responseData);
      }
    }
    if (responseData == null) {
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        String responseData = utf8.decode(response.bodyBytes);
        if (saveInMemory) {
          if (sharedPref == null) sharedPref = SharedPref();
          await sharedPref.save(key, responseData);
        }
        return jsonDecode(responseData);
      } else {
        print(response.statusCode);
        return null;
      }
    }
  }

  Future postData(dynamic data) async {
    http.Response response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      String responseData = utf8.decode(response.bodyBytes);
      return jsonDecode(responseData);
    } else {
      print(response.statusCode);
      return null;
    }
  }

  Future postDataWithKey(dynamic data, String key,
      {checkInMemory = true, saveInMemory = true}) async {
    String responseData = null;
    SharedPref sharedPref = null;
    if (checkInMemory) {
      sharedPref = SharedPref();
      responseData = await sharedPref.read(key);
      if (responseData != null) {
        return jsonDecode(responseData);
      }
    }
    if (responseData == null) {
      http.Response response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );
      if (response.statusCode == 200) {
        String responseData = utf8.decode(response.bodyBytes);
        if (saveInMemory) {
          if (sharedPref == null) sharedPref = SharedPref();
          await sharedPref.save(key, responseData);
        }
        return jsonDecode(responseData);
      } else {
        print(response.statusCode);
        return null;
      }
    }
  }
}
