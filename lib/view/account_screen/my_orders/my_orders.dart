import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nectar/controller/order_controller.dart';
import 'package:nectar/model/orders_model.dart';
import 'package:nectar/utility/app_color.dart';
import 'package:nectar/utility/assets.dart';
import 'package:nectar/utility/fontsize.dart';
import 'package:nectar/view/account_screen/account_screen.dart';
import 'package:nectar/view/account_screen/my_orders/track_order.dart';
import 'package:nectar/view/navigation_screen/navigation_screen.dart';
import 'package:nectar/widget/app_button.dart';
import 'package:nectar/widget/not_found.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.bgWhite,
      appBar: AppBar(
        backgroundColor: AppColors.bgWhite,
        leading: InkWell(
          onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>NavigationScreen(pageIndex: 4,))),
            child: Icon(Icons.arrow_back,size: 30,)),

      ),
      body: Padding(
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
            StreamBuilder(
              stream: OrderController.getOrders(),
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator.adaptive(),);
                }

                List<OrderModel> orderList = [];
                for(var i in snapshot.data!.docs){
                  orderList.add(OrderModel.fromJson(i));
                }
                return orderList.isNotEmpty ? Expanded(
                  flex: 10,
                    child: ListView.builder(
                    itemCount: orderList.length,
                    itemBuilder: (_,index){
                      var data = orderList[index];
                     return GestureDetector(
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(15),
                          margin: EdgeInsets.only(bottom: 10),
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
                                          style: TextStyle(
                                              fontSize:18,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.textBlack),
                                        ),
                                        SizedBox(height: 8,),
                                        Text("${data.createAt.toString()}",
                                          style: TextStyle(fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              color: AppColors.textGrey),
                                        ),
                                        SizedBox(height: 3,),
                                        Text("Expected delivery on: ${data.createAt.toString()}",
                                          style: TextStyle(fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              color: Colors.black),
                                        ),


                                      ],
                                    ),
                                    SizedBox(width: 5,),
                                    AppButton(name: "Suivi",
                                        onClick: ()=> Navigator.push(context,MaterialPageRoute(builder: (_)=>TrackOrder(orderModel: data,))))
                                    ],

                                  ),

                                SizedBox(height: 20,),
                                RichText(text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Statut de la commande: ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black38,
                                        fontSize: 15,
                                      )
                                    ),
                                    TextSpan(
                                        text: "${data.orderStatus == "Pending" ? "En attente" :data.orderStatus }",
                                        style: TextStyle(
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
                  ) : Center(child: NotFound());
              }
            )
          ],
        ),
      ),
    );
  }
}
