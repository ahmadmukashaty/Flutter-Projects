import 'package:json_utilities/json_utilities.dart';

class UserInfo {
  String username;
  String firstName;
  String lastName;
  int countryId;
  String password;
  String email;
  String phone;

  UserInfo(
      {this.username,
      this.firstName,
      this.lastName,
      this.countryId,
      this.password,
      this.email,
      this.phone});

  UserInfo.fromJson(Map<String, dynamic> json)
      : username = JSONUtils().get(json, 'username', ''),
        firstName = JSONUtils().get(json, 'firstName', ''),
        lastName = JSONUtils().get(json, 'lastName', ''),
        countryId = JSONUtils().get(json, 'countryId', 1),
        password = JSONUtils().get(json, 'password', ''),
        email = JSONUtils().get(json, 'email', ''),
        phone = JSONUtils().get(json, 'phone', '');

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'firstName': firstName,
      'lastName': lastName,
      'countryId': countryId.toString(),
      'password': password,
      'email': email,
      'phone': phone
    };
  }
}
