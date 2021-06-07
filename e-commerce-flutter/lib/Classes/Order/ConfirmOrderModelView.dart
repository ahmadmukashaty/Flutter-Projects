import 'package:json_utilities/json_utilities.dart';

class ConfirmOrderModelView {
  int userId;
  int countryId;
  String couponCode;
  String shippingaddress;
  String additionalphone;
  String notes;

  ConfirmOrderModelView({
    this.userId,
    this.countryId,
    this.couponCode,
    this.shippingaddress,
    this.additionalphone,
    this.notes,
  });

  ConfirmOrderModelView.fromJson(Map<String, dynamic> json)
      : userId = JSONUtils().get(json, 'userId', 0),
        countryId = JSONUtils().get(json, 'countryId', 1),
        couponCode = JSONUtils().get(json, 'couponCode', ''),
        shippingaddress = JSONUtils().get(json, 'shippingaddress', ''),
        additionalphone = JSONUtils().get(json, 'additionalphone', ''),
        notes = JSONUtils().get(json, 'notes', '');

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'countryId': countryId,
      'couponCode': couponCode,
      'shippingaddress': shippingaddress,
      'additionalphone': additionalphone,
      'notes': notes,
    };
  }
}
