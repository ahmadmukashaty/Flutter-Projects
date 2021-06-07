import 'package:json_utilities/json_utilities.dart';
import 'package:oneaddress/Classes/Authentication/UpdateUserInfo.dart';

class User {
  int id;
  String email;
  String firstName;
  String lastName;
  int countryId;
  String countryName;
  String emailAddress;
  String phone;

  User({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.countryId,
    this.countryName,
    this.emailAddress,
    this.phone,
  });

  User.fromJson(Map<String, dynamic> json)
      : id = JSONUtils().get(json, 'id', 0),
        email = JSONUtils().get(json, 'email', ''),
        firstName = JSONUtils().get(json, 'firstName', ''),
        lastName = JSONUtils().get(json, 'lastName', ''),
        countryId = JSONUtils().get(json, 'countryId', 1),
        countryName = JSONUtils().get(json, 'countryName', ''),
        emailAddress = JSONUtils().get(json, 'emailAddress', ''),
        phone = JSONUtils().get(json, 'phone', '');

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'countryId': countryId,
      'countryName': countryName,
      'emailAddress': emailAddress,
      'phone': phone
    };
  }

  void updateUser(UpdateUserInfo userInfo) {
    this.firstName = userInfo.firstName;
    this.lastName = userInfo.lastName;
    this.emailAddress = userInfo.phone;
  }
}
