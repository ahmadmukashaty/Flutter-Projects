import 'package:json_utilities/json_utilities.dart';

class UpdateUserInfo {
  String firstName;
  String lastName;
  String password;
  String phone;
  String email;
  String emailAddress;
  int id;

  UpdateUserInfo({
    this.firstName,
    this.lastName,
    this.password,
    this.phone,
    this.email,
    this.emailAddress,
    this.id,
  });

  UpdateUserInfo.fromJson(Map<String, dynamic> json)
      : firstName = JSONUtils().get(json, 'firstName', ''),
        lastName = JSONUtils().get(json, 'lastName', ''),
        password = JSONUtils().get(json, 'password', ''),
        phone = JSONUtils().get(json, 'phone', ''),
        email = JSONUtils().get(json, 'email', ''),
        emailAddress = JSONUtils().get(json, 'emailAddress', ''),
        id = JSONUtils().get(json, 'id', 0);

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'password': password,
      'phone': phone,
      'email': email,
      'emailAddress': emailAddress,
      'id': id,
    };
  }
}
