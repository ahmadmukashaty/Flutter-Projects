import 'package:json_utilities/json_utilities.dart';
import 'package:intl/intl.dart';

class UserOrder {
  int id;
  String creationDate;
  String shippingAddress;
  double cost;
  double totalCost;
  int countryId;
  int customerId;
  String notes;
  String statusName;
  double couponCost;

  UserOrder({
    this.id,
    this.creationDate,
    this.shippingAddress,
    this.cost,
    this.totalCost,
    this.countryId,
    this.customerId,
    this.notes,
    this.statusName,
    this.couponCost,
  });

  UserOrder.fromJson(Map<String, dynamic> json)
      : id = JSONUtils().get(json, 'id', 0),
        creationDate = parseDate(JSONUtils().get(json, 'creationDate', '')),
        shippingAddress = JSONUtils().get(json, 'shippingAddress', ''),
        cost = (JSONUtils().get(json, 'cost', 0.0)).toDouble(),
        totalCost = (JSONUtils().get(json, 'totalCost', 0.0)).toDouble(),
        countryId = JSONUtils().get(json, 'countryId', 1),
        customerId = JSONUtils().get(json, 'customerId', 0),
        notes = JSONUtils().get(json, 'notes', ''),
        statusName = JSONUtils().get(json, 'statusName', ''),
        couponCost = checkCoupon(JSONUtils().get(json, 'couponCost', ''));

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'creationDate': creationDate,
      'shippingAddress': shippingAddress,
      'cost': cost,
      'totalCost': totalCost,
      'countryId': countryId,
      'customerId': customerId,
      'notes': notes,
      'statusName': statusName,
    };
  }

  static String parseDate(String date) {
    if (date == '') return date;
    DateTime myDatetime = DateTime.parse(date);
    var formatter = new DateFormat('yyyy-MM-dd');
    String formatted = formatter.format(myDatetime);
    return formatted;
  }

  static checkCoupon(dynamic data) {
    if (data == null || data.toString() == "") return 0.0;
    return double.parse(data.toString());
  }
}
