import 'package:json_utilities/json_utilities.dart';
import 'package:oneaddress/Services/Network_Cache_Management/Networking.dart';
import 'package:oneaddress/Utilities/Constants.dart';

class ProfileService {
  Future<bool> sendNewPasswordSMS(String phoneNumber) async {
    NetworkHelper networkHelper =
        NetworkHelper(kForgetPasswordUrl + "/" + phoneNumber);

    var response = await networkHelper.getData();

    if (response == null) {
      return false;
    }

    final int responseStatus = JSONUtils().get(
      response,
      'status',
      400,
    );

    if (responseStatus != 200) {
      return false;
    }
    return true;
  }
}
