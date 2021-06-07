import 'dart:io';

import 'package:json_utilities/json_utilities.dart';
import 'package:oneaddress/Classes/Order/ConfirmOrderModelView.dart';
import 'package:oneaddress/Classes/Order/OrderProduct.dart';
import 'package:oneaddress/Classes/Order/RequesterInfo.dart';
import 'package:oneaddress/Classes/Order/UserOrders.dart';
import 'package:oneaddress/Components/BottomNavBar/ButtonCartIconNavBarComponent.dart';
import 'package:oneaddress/Services/Network_Cache_Management/CustomCacheManager.dart';
import 'package:oneaddress/Services/Network_Cache_Management/Networking.dart';
import 'package:oneaddress/Utilities/Constants.dart';

class OrderService {
  Future<bool> submitOrder(
      RequesterInfo requesterInfo, String couponCode) async {
    NetworkHelper networkHelper = NetworkHelper(kSubmitOrder);
    ConfirmOrderModelView orderRequestModelView = ConfirmOrderModelView(
      userId: requesterInfo.userId,
      countryId: requesterInfo.countryId,
      couponCode: couponCode,
      shippingaddress: requesterInfo.address,
      additionalphone: requesterInfo.additionalPhoneNumber,
      notes: requesterInfo.notes,
    );

    var orderData =
        await networkHelper.postData(orderRequestModelView.toJson());
    if (orderData != null) {
      final int status = JSONUtils().get(orderData, 'status', 0);
      if (status == 200) {
        ButtonCartIconNavBarComponent.numberOfItems = 0;
        return true;
      }
    }
    return false;
  }

  Future<int> checkCoupon(int userId, String couponCode) async {
    final url =
        kCheckCoupon + "?userId=" + userId.toString() + "&code=" + couponCode;
    NetworkHelper networkHelper = NetworkHelper(url);
    var couponData = await networkHelper.getData();
    final double result = (JSONUtils().get(couponData, 'result', 0)).toDouble();
    return result.toInt();
  }

  Future<List<UserOrder>> getUserOrders(int userId) async {
    final url = kUserOrders + "/" + userId.toString();
    NetworkHelper networkHelper = NetworkHelper(url);

    var orderData = await networkHelper.getData();
    final List parsedList = JSONUtils().get(orderData, 'result', null);
    //check value

    if (parsedList == null) return [];
    var orders = parsedList.map((val) => UserOrder.fromJson(val)).toList();
    return orders;
  }

  Future<dynamic> getUserOrder(int orderId) async {
    final url = kUserOrder + "/" + orderId.toString();
    NetworkHelper networkHelper = NetworkHelper(url);

    var orderData =
        await networkHelper.getDataWithKey(kOrderKey + orderId.toString());
    final List parsedList = JSONUtils().get(orderData, 'result', null);
    //check value

    if (parsedList == null) return [];
    var orderProducts =
        parsedList.map((val) => OrderProduct.fromJson(val)).toList();

    for (var j = 0; j < orderProducts.length; j++) {
      File productFile = await CustomCacheManager()
          .getSingleFile(kImgProductBaseUrl + orderProducts[j].imageName);
      orderProducts[j].imageFile = productFile;
    }

    return orderProducts;
  }
}
