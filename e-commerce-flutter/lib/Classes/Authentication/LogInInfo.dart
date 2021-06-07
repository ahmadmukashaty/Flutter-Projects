import 'package:json_utilities/json_utilities.dart';

class LogInInfo {
  String username;
  String password;

  LogInInfo({
    this.username,
    this.password,
  });

  LogInInfo.fromJson(Map<String, dynamic> json)
      : username = JSONUtils().get(json, 'username', 0),
        password = JSONUtils().get(json, 'password', '');

  Map<String, dynamic> toJson() {
    return {'username': username, 'password': password};
  }
}
