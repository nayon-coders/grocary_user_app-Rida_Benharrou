import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nectar/controller/order_controller.dart';
import 'package:nectar/model/orders_model.dart';
import 'package:nectar/utility/app_color.dart';
import 'package:nectar/utility/assets.dart';
import 'package:nectar/utility/fontsize.dart';
import 'package:nectar/view/account_screen/my_orders/track_order.dart';
import 'package:nectar/widget/app_button.dart';

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
        title: Text("Mes commandes"),
        backgroundColor: AppColors.bgWhite,
        leading: InkWell(
          onTap: ()=>Navigator.pop(context),
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
            SizedBox(height: 10,),
            Expanded(
              child: StreamBuilder(
                stream: OrderController.getOrders(),
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Center(child: CircularProgressIndicator(color: Colors.blue,),);
                  }

                  print("orders ---- ${snapshot.data!.docs}");
                  List<OrderModel> orders = [];
                  for(var i in snapshot.data!.docs){
                    orders.add(OrderModel.fromJson(i.data()));
                  }
                  return ListView.builder(
                      itemCount: orders.length,
                  itemBuilder: (_,index){
                        var data = orders[index];
                  return GestureDetector(
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(5),
                      height: 150,
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade200)
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Order#: ${data.id}",
                                      style: TextStyle(
                                          fontSize:titleFont,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.textBlack),
                                    ),
                                    SizedBox(height: 8,),
                                    Text("${data.date}",
                                      style: TextStyle(fontWeight: FontWeight.w400,
                                          fontSize: smallFont,
                                          color: AppColors.textGrey),
                                    ),
                                    SizedBox(height: 10,),
                                    Row(
                                      children: [
                                        Text("Statut: ",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 8,),
                                        Text("${data.status}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        )
                                      ],
                                    ),




                                  ],
                                ),
                                AppButton(name: "Track Order", onClick: ()=>Navigator.push(context,MaterialPageRoute(builder: (_)=>TrackOrder(orderModel: data,))),)

                              ],

                              ),

                          ],
                        ),
                      ),
                    ),
                  );

                              });
                }
              ),
            )
          ],
        ),
      ),
    );
  }
}
