import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nectar/data/global/global_controller.dart';
import 'package:nectar/data/global/global_variable.dart';
import 'package:nectar/data/models/delivery_address_model.dart';
import 'package:nectar/data/models/order_model.dart';
import 'package:nectar/view/order_accepted/order_accepted.dart';

import '../../../app_config.dart';
import '../../../data/service/api.service.dart';
import '../../auth/controller/auth_controller.dart';
import 'car_controller.dart';

class OrderControllerNew extends GetxController {

  //cart controller init
  var cartController = Get.find<CartControllerNew>();
  GlobalController _globalController = Get.find();


  //model
  Rx<OrderModelNew> orderModel = OrderModelNew().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getOrderList(); //get order list
    Get.find<AuthController>().getMyProfile(); //get user profile


  }

  //place order
  RxBool isPlacingOrder = false.obs;
  RxBool isLoading = false.obs;

  void placeOrder(String selectedDeliveryDateTime, String payment_method,
      double deliveryFee, AddressModel selectedAddress) async {
    isPlacingOrder.value = true;
    print('Place order');

    List<Map<String, dynamic>> products = [];
    cartController.cartList.value.data!.forEach((element) {
      products.add({
        "product_id": element.productId.toString(),
        "quantity": element.quantity,
        "price": _globalController.priceCalculat(
            element.productRegularPrice, element.productSellingPrice,
            element.productWholePrice, 00.00) ///TODO: cart api error
      });
    });

    var body = {
      "company": GlobalVariables.myProfile.value.name,
      "delivery_date": selectedDeliveryDateTime.toString(),
      "payment_method": payment_method,
      "sub_total": cartController.totalPrice.toStringAsFixed(2),
      "tax": (cartController.totalTVAamount - cartController.totalPrice)
          .toStringAsFixed(2),
      "tax_amount": (cartController.totalTVAamount - cartController.totalPrice)
          .toStringAsFixed(2),
      "delivery_fee": deliveryFee.toStringAsFixed(2),
      "total": (cartController.totalPrice +
          (cartController.totalTVAamount - cartController.totalPrice) +
          deliveryFee).toStringAsFixed(2),
      "user_delivery_address_id": selectedAddress.id.toString(),
      "products": products
    };
    print("order controller init ${body}");

    var response = await ApiService().postApi(AppConfig.ORDER_PLACE, body);

    if (response.statusCode == 200) {
      getOrderList();
      //show success message
      await ApiService().deleteApi(AppConfig.ORDER_BULK_DELETE);
      Get.snackbar(
          "Success!", "Order Place success!", backgroundColor: Colors.green,
          colorText: Colors.white);
      cartController.cartList.value.data!.clear();
      cartController.cartCount.value = 0;
      cartController.priceList.value.clear();
      Get.to(OrderAccepted()); //navigate to order accepted screen
    } else {
      //show error message
      Get.snackbar(
          "Error!", "Something went wrong", backgroundColor: Colors.red,
          colorText: Colors.white);
    }
    isPlacingOrder.value = false;
  }

  //get order list
  void getOrderList()async {
    isLoading.value = true;
    var response = await ApiService().getApi(AppConfig.ORDER_GET_ALL);
    if (response.statusCode == 200) {
      orderModel.value = OrderModelNew.fromJson(jsonDecode(response.body));
    }
    isLoading.value = false;
  }



}

