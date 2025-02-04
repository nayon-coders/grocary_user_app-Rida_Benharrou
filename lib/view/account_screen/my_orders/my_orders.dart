
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nectar/routes/app_routes.dart';
import 'package:nectar/utility/app_color.dart';
import 'package:nectar/utility/fontsize.dart';
import 'package:nectar/view/account_screen/my_orders/track_order.dart';
import 'package:nectar/view/cart_screen/controller/car_controller.dart';
import 'package:nectar/view/cart_screen/controller/order_controller.dart';
import 'package:nectar/view/navigation_screen/navigation_screen.dart';
import 'package:nectar/widget/app_button.dart';
import 'package:nectar/widget/not_found.dart';

import '../../../data/global/global_controller.dart';
import '../../../utility/app_const.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {

  //order controller init getx
  OrderControllerNew orderController = Get.put(OrderControllerNew());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async {
        Get.toNamed(AppRoutes.HOME);
        return true;
        // Returning false prevents the back action
        // Returning true allows the back action
        //return false; // Prevent back navigation
      },
      child: Scaffold(
        backgroundColor: AppColors.bgWhite,
        appBar: AppBar(
          backgroundColor: AppColors.bgWhite,
          surfaceTintColor: Colors.transparent,
          leading: InkWell(
            onTap: (){
              Get.toNamed(AppRoutes.HOME);
            },
              child: const Icon(Icons.arrow_back_ios,size: 30,)),
      
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await orderController.getOrderList();
          },
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Mes commandes",
                  style: TextStyle(
                    fontSize:bigFont,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textBlack,
                  ),
                ),

                Obx((){
                  if(orderController.isLoading.value){
                    return const Center(child: CircularProgressIndicator.adaptive(),);
                  }else if(orderController.orderModel.value.data!.isEmpty){
                    return const NotFound();
                  }else{

                    return  Expanded(
                        flex: 10,
                        child: ListView.builder(
                            itemCount: orderController.orderModel.value.data!.length,
                            itemBuilder: (_,index){
                              var data =  orderController.orderModel.value.data![index];
                              return GestureDetector(
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(15),
                                  margin: const EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Colors.grey.shade200)
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text("Commande: ${data.id}",
                                                  style: const TextStyle(
                                                      fontSize:18,
                                                      fontWeight: FontWeight.w600,
                                                      color: AppColors.textBlack),
                                                ),
                                                const SizedBox(height: 8,),
                                                Text("${data.createdAt.toString()}",
                                                  style: const TextStyle(fontWeight: FontWeight.w400,
                                                      fontSize: 12,
                                                      color: AppColors.textGrey),
                                                ),
                                                const SizedBox(height: 3,),
                                                SizedBox(
                                                  width: 160,
                                                  child: Text("Expected delivery on: ${data.deliveryDate.toString()}",
                                                    style: const TextStyle(fontWeight: FontWeight.w400,
                                                        fontSize: 12,
                                                        color: Colors.black),
                                                  ),
                                                ),


                                              ],
                                            ),
                                            const SizedBox(width: 5,),
                                            AppButton(name: "Suivi",
                                                onClick: ()=> Navigator.push(context,MaterialPageRoute(builder: (_)=>TrackOrder(orderModel: data,))))
                                          ],

                                        ),

                                        const SizedBox(height: 20,),
                                        RichText(text: TextSpan(
                                            children: [
                                              const TextSpan(
                                                  text: "Statut de la commande: ",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black38,
                                                    fontSize: 15,
                                                  )
                                              ),
                                              TextSpan(
                                                  text: "${data.orderStatus == "Pending" ? "En attente" :data.orderStatus }",
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                  )
                                              )
                                            ]
                                        ))

                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                        )
                    );
                  }
                })

              ],
            ),
          ),
        ),
      ),
    );
  }
}
