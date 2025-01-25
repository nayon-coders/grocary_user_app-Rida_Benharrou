import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:nectar/app_config.dart';
import 'package:nectar/data/models/order_model.dart';
import 'package:nectar/data/service/api.service.dart';

class InvoiceController extends GetxController{

  RxString startDate = "".obs;
  RxString endDate = "".obs;

  RxList<SingleOrder> invoiceOrderList = <SingleOrder>[].obs;
  
  RxBool isLoading = false.obs; 
  //get order 
  getMyInvoice()async{
    isLoading.value = true;
    var response = await ApiService.getApi(AppConfig.ORDER_GET_ALL+"?fromDate=${startDate.value}&toDate=${endDate.value}");
    invoiceOrderList.clear();
    if(response.statusCode == 200){
      for(var i in OrderModelNew.fromJson(jsonDecode(response.body)).data!){
        if(i.orderStatus == "Livré"){
          invoiceOrderList.add(i);
        }

      }
    }
    isLoading.value = false;
  }


}