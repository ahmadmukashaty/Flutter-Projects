import 'package:oneaddress/Classes/Authentication/User.dart';
import 'package:oneaddress/Services/Network_Cache_Management/SharedPref.dart';

class Authentication {
  static User _userInfo;

  static checkAuth() async {
    SharedPref sharedPref = SharedPref();
    _userInfo = await sharedPref.getUserInfo();
  }

  static bool isAuth() {
    return (_userInfo != null);
  }

  static bool notAuth() {
    return (_userInfo == null);
  }

  static User userData() {
    return _userInfo;
  }

  static removeAuth() async {
    SharedPref sharedPref = SharedPref();
    sharedPref.removeUser();
    await checkAuth();
  }
}
