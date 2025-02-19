import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nectar/data/global/global_controller.dart';
import 'package:nectar/data/global/global_variable.dart';
import 'package:nectar/data/models/delivery_address_model.dart';
import 'package:nectar/data/models/myprofile_model.dart';
import 'package:nectar/data/models/order_model.dart';
import 'package:nectar/view/order_accepted/order_accepted.dart';

import '../../../app_config.dart';
import '../../../data/service/api.service.dart';
import '../../auth/controller/auth_controller.dart';
import 'car_controller.dart';

class OrderControllerNew extends GetxController {

  final AuthController authController = Get.put(AuthController());
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
    print('Place order -- ${ GlobalVariables.myProfile.value.status}');
    await authController.getMyProfile(); //geting my profile first then cehck...

    //check user is active or deactive?
    if( GlobalVariables.myProfile.value.status != "Actif"){
      Get.snackbar("Désolé !", "Votre compte n'est pas encore actif. Nous allons vous contacter. Vous pouvez écrire à  commande@commandespros.com", backgroundColor: Colors.red,colorText: Colors.white);
      isPlacingOrder.value = false;
      return null;
    }


    List<Map<String, dynamic>> products = [];
    for(var i = 0; i < cartController.cartList.value.data!.length; i++){
      products.add({
        "product_id": cartController.cartList.value.data![i].productId.toString(),
        "quantity": cartController.qtyList[i],
        "price": _globalController.priceCalculat(
            cartController.cartList.value.data![i].productRegularPrice,  cartController.cartList.value.data![i].productSellingPrice,
            cartController.cartList.value.data![i].productWholePrice,  cartController.cartList.value.data![i].productSupperMarcent) ///TODO: cart api error
      });
    }
    cartController.cartList.value.data!.forEach((element) {
      print("element.quantity -- ${element.quantity}");
      products.add({
        "product_id": element.productId.toString(),
        "quantity": element.quantity,
        "price": _globalController.priceCalculat(
            element.productRegularPrice, element.productSellingPrice,
            element.productWholePrice, element.productSupperMarcent) ///TODO: cart api error
      });
    });

    print("products -- ${products}");

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
    print("order controller init ${products}");

    var response = await ApiService.postApi(AppConfig.ORDER_PLACE, body);

    if (response.statusCode == 200) {
      Get.back();
      getOrderList();
      //show success message
      await ApiService.deleteApi(AppConfig.ORDER_BULK_DELETE);
      Get.snackbar(
          "Bravo !", "Commande passée avec succès!", backgroundColor: Colors.green,
          colorText: Colors.white);
      cartController.cartList.value.data!.clear();
      cartController.cartCount.value = 0;
      cartController.priceList.value.clear();
      Get.to(OrderAccepted()); //navigate to order accepted screen
    } else {
      //show error message
      Get.snackbar(
          "Désolé!", "Quelque chose s'est mal passé", backgroundColor: Colors.red,
          colorText: Colors.white);
    }
    isPlacingOrder.value = false;
  }

  //get order list
  Future getOrderList()async {
    isLoading.value = true;
    var response = await ApiService.getApi(AppConfig.ORDER_GET_ALL);
    if (response.statusCode == 200) {
      orderModel.value = OrderModelNew.fromJson(jsonDecode(response.body));
    }
    isLoading.value = false;
  }



}

