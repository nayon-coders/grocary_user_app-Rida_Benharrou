import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nectar/data/global/global_controller.dart';
import 'package:nectar/utility/fontsize.dart';
import 'package:nectar/view/account_screen/controller/address_controller.dart';
import 'package:nectar/view/cart_screen/controller/car_controller.dart';
import 'package:nectar/view/cart_screen/widget/order_popup.dart';
import 'package:nectar/view/cart_screen/widget/recomandation_products.dart';
import 'package:nectar/widget/app_network_images.dart';
import 'package:nectar/widget/app_shimmer.dart';
import '../../utility/app_color.dart';
import '../../widget/not_found.dart';
import 'controller/order_controller.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  CartControllerNew cartController = Get.find<CartControllerNew>();
  AddressControllerNew addressController = Get.put(AddressControllerNew());
  GlobalController globalController = Get.find<GlobalController>();
  OrderControllerNew orderControllerNew = Get.put(OrderControllerNew());


  var _cartProductId;

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(

      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            RecomandationProducts(),

            SizedBox(height: 0,),
            Divider(height: 1,),
            SizedBox(height: 10,),

            Text("Mon panier",
              style: TextStyle(
                fontSize: titleFont,
                fontWeight: FontWeight.w600,
                color: AppColors.textBlack,
              ),
            ),
            SizedBox(height: 10,),

            //show cart product
            Obx((){
              if(cartController.isCartLoading.value){
                return  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (context,index){
                      return Container(margin: EdgeInsets.only(bottom: 10), height: 70, child: AppShimmer());
                    });
              }else if(cartController.cartList.value.data == null || cartController.cartList.value.data!.isEmpty){
                return NotFound();
              }else{
                return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: cartController.cartList.value.data!.length,
                    itemBuilder: (context,index){
                      var data = cartController.cartList.value.data![index];


                      return ListTile(
                        shape: Border(bottom:  BorderSide(color:Colors.grey.shade200)),
                        contentPadding: EdgeInsets.only(bottom: 5),
                        leading: Container(
                            width: 70, height:80,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: AppNetworkImage(src: data.productImages!, width: 60, height:60,)),
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width*.50,
                              child: Text(
                                "${data.productName}",style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color:AppColors.textBlack,
                              ),
                              )
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment : CrossAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width*.40,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                  Obx(() {
                                    return Text(
                                      "${globalController.priceCalculat(data.productRegularPrice!.toDouble(), data.productSellingPrice!.toDouble(), data.productWholePrice!.toDouble())}€ ",style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color:AppColors.textBlack,
                                    ),
                                    );
                                  }
                                  )

                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: ()async{
                                            cartController.decrementQty(index); //decrement qty
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(3),
                                            decoration: BoxDecoration(
                                              border: Border.all(width: 1, color: Colors.grey.shade200),
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(5),
                                                topLeft: Radius.circular(5),
                                              ),
                                              color: AppColors.bgWhite,
                                            ),
                                            child: Center(
                                              child: Icon(Icons.remove,size: 20, color: AppColors.mainColor,),
                                            ),
                                          ),
                                        ),
                                        Obx(() {
                                            return Container(
                                                width: 25,
                                                height: 27,
                                                decoration: BoxDecoration(
                                                  border: Border.all(width: 1, color: AppColors.mainColor),
                                                  color: AppColors.mainColor,
                                                ),
                                                child: Center(child: Text("${cartController.qtyList.value[index]}",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15,color: Colors.white),)));
                                          }
                                        ),


                                        InkWell(
                                          onTap: (){
                                            cartController.incrementQty(index);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(3),
                                            decoration: BoxDecoration(
                                              border: Border.all(width: 1, color: Colors.grey.shade200),
                                              borderRadius: BorderRadius.only(
                                                bottomRight: Radius.circular(5),
                                                topRight: Radius.circular(5),
                                              ),
                                              color: AppColors.bgWhite,
                                            ),
                                            child: Center(
                                              child: Icon(Icons.add,size: 20, color: AppColors.mainColor,),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            )



                            ///TODO: Remove this block if need to show the tax
                            // Text("TVA: ${double.parse("${data.tax}")}%",
                            //   style: TextStyle(fontSize: 10,
                            //       fontWeight: FontWeight.w100,
                            //       color: Colors.black),
                            // ),
                          ],
                        ),

                      );
                    });
              }
            }),

          ],
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: (){
          if(cartController.cartList!.value! == null || cartController.cartList!.value!.data!.isEmpty){
            return;
          }
          showModalBottomSheet(context: context, builder:(BuildContext context){
            return Obx((){
                return OrderPopup(
                    qty: [1,1,1],
                    totalPrice: cartController.priceList.value
                );
              }
            );
          });
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          decoration: BoxDecoration(
            color: AppColors.mainColor,
            borderRadius: BorderRadius.circular(5)
          ),
          padding: const EdgeInsets.only(left: 20.0,right: 20.0),
          margin: const EdgeInsets.only(left: 10.0,right: 10.0, bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_shopping_cart, size: 20, color: Colors.white,),
                  SizedBox(width: 10,),
                  Text("Passer la commande",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Colors.white
                    ),
                  )
                ],
              ),
              Obx(() {
                  return Text("${cartController.totalPrice.toStringAsFixed(2)}€",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Colors.white
                    ),
                  );
                }
              )
            ],
          ),
        ),
      ),
    ));
  }


  // totalPriceGet(tax, itemPrice){
  //   for(var i =0; i < qty.length; i++){
  //       totalPrice = totalPrice + (itemPrice * qty[i]) + (totalPrice * qty[i]) / 100 * double.parse("${tax}");
  //   }
  // }


}


