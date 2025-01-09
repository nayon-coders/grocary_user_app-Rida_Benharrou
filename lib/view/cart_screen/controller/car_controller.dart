import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nectar/app_config.dart';
import 'package:nectar/data/models/product_model.dart';
import 'package:nectar/data/service/api.service.dart';

import '../../../data/global/global_controller.dart';
import '../../../data/models/cart_list_model.dart';

class CartControllerNew extends GetxController{

  //global controller
  GlobalController _globalController = Get.find();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCartProduct();
  }

  //goobal
  var cartCount = 0.obs;


  //add cart item
  RxBool isAddingCart = false.obs;
  void addToCart(qty, productId)async{
    isAddingCart.value = true;
    print('Add to cart');
    var body = {
      "product_id": "$productId",
      "quantity": "$qty"
    };
    var response = await ApiService().postApi(AppConfig.CART_ADD, body);

    if(response.statusCode == 200){
      getCartProduct();
      //show success message
      Get.snackbar("Success!", "Product added to cart", backgroundColor: Colors.green, colorText: Colors.white);
    }else{
      //show error message
      Get.snackbar("Error!", "Something went wrong", backgroundColor: Colors.red, colorText: Colors.white);
    }
    isAddingCart.value = false;

  }


  //get cart
  RxBool isCartLoading = false.obs;
  Rx<CartListModel> cartList = CartListModel().obs;
  void getCartProduct()async{
    priceList.clear();
    qtyList.clear();
    isCartLoading.value = true;
    var response = await ApiService().getApi(AppConfig.CART_GET);
    if(response.statusCode == 200){
      cartList.value = CartListModel.fromJson(jsonDecode(response.body));
      cartCount.value = cartList.value.totalProducts!;
      for(var i in cartList.value.data!){
        print("i.productTax! -- ${i.productTax!}");
        qtyList.add(i.quantity!);
        ///TODO: Card api error
        priceList.add(_globalController.priceCalculat(i.productRegularPrice!.toDouble(), i.productSellingPrice!.toDouble(), i.productWholePrice!.toDouble(), double.parse("${ i.productSupperMarcent}")));
        productTax.add(i.productTax!.toDouble());
      }
    //  cartList.value = response.body['data'];
    }
    isCartLoading.value = false;
  }



  //get recommended product
  RxBool isRecomandationLoading = false.obs;
  RxList<SingleProduct> recomandationProduct = <SingleProduct>[].obs;
  void getRecomandationProduct()async{
    recomandationProduct.clear();//clear previous data
    isRecomandationLoading.value = true;
    var response = await ApiService().getApi(AppConfig.RECOMANDATION_PRODUCT);
    if(response.statusCode == 200){
      for(var i in jsonDecode(response.body)["data"]){
        recomandationProduct.add(SingleProduct.fromJson(i));
      }
    }
    isRecomandationLoading.value = false;
  }




  //---------------------------------------------------///
  //remove cart item
  RxBool isRemovingCart = false.obs;
  void removeCartProduct(productId, index)async{
    isRemovingCart.value = true;
    var response = await ApiService().deleteApi("${AppConfig.CART_REMOVE}$productId");
    if(response.statusCode == 200){
      qtyList.clear();
      priceList.clear();
      getCartProduct();
      //show success message
     // Get.snackbar("Success!", "Product removed from cart", backgroundColor: Colors.green, colorText: Colors.white);
    }else{
      //show error message
    //  Get.snackbar("Error!", "Something went wrong", backgroundColor: Colors.red, colorText: Colors.white);
    }
    isRemovingCart.value = false;
  }


  //increase cart item
  RxInt qty = 1.obs;
  RxList<int> qtyList = <int>[].obs; //for cart item quantity
  RxList<double> priceList = <double>[].obs; //for cart item quantity
  RxList<double> productTax = <double>[].obs; //for cart item quantity
  double get totalPrice {
    if (priceList.length != qtyList.length) {
      // Handle the case where the lists are not synchronized
      return 0.0;
    }

    return List.generate(priceList.length, (index) {
      print("priceList[index] ------ ${priceList[index]}"); // Print the price for each product
      return priceList[index] * qtyList[index];
    }).fold(0, (sum, element) => sum + element);
  }
  // Getter for calculating the total amount including tax (TVA)
  double get totalTVAamount {
    double totalTax = 0.0;
    print("priceList.length -- ${productTax}");

    for (int i = 0; i < priceList.length; i++) {
      double subtotal = priceList[i] * qtyList[i]; // Subtotal for each product
      double taxAmount = (subtotal / 100) * double.parse(productTax[i].toString()); // Tax for each product
      totalTax += taxAmount; // Sum up the taxes
    }

    return totalPrice + totalTax; // Return totalPrice + totalTax
  }




  // Increment the quantity for a specific index
  void incrementQty(int index) {
    qtyList[index]++; // Increase the quantity
  }

  // Decrement the quantity for a specific index (ensure it doesn’t go below 1)
  void decrementQty(int index) {
    if (qtyList[index] > 1) {
      qtyList[index]--; // Decrease the quantity
    }else{
      qtyList[index] = 0;
      removeCartProduct(cartList.value.data![index].id.toString(), index);
    }
  }







}