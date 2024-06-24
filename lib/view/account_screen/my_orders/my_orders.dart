import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nectar/utility/app_color.dart';
import 'package:nectar/utility/assets.dart';
import 'package:nectar/utility/fontsize.dart';
import 'package:nectar/view/account_screen/my_orders/track_order.dart';

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
          onTap: ()=>Navigator.pop(context),
            child: Icon(Icons.arrow_back,size: 30,)),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: InkWell(
              onTap: (){},
                child: Icon(Icons.search,color: Colors.black,size: 30,)),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: InkWell(
              onTap: (){},
                child: Icon(Icons.lock_clock_sharp,color: Colors.black,size: 30,)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              // flex: 1,
                child: Text("My Order",
                            style: TextStyle(
                  fontSize:bigFont,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textBlack,
                            ),
                          )
            ),
            Expanded(
              flex: 10,
                child: ListView.builder(

              itemCount: 20,
                itemBuilder: (_,index){
                return GestureDetector(
                  onTap: ()=>Navigator.push(context,MaterialPageRoute(builder: (_)=>TrackOrder())),
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
                                  Text("Order#:087394",
                                    style: TextStyle(
                                        fontSize:titleFont,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.textBlack),
                                  ),
                                  SizedBox(height: 8,),
                                  Text("02-Jun-2026,05:30 pm",
                                    style: TextStyle(fontWeight: FontWeight.w400,
                                        fontSize: smallFont,
                                        color: AppColors.textGrey),
                                  ),


                                ],
                              ),
                              Image.asset(Assets.potato,height: 60,width: 80,fit: BoxFit.cover,),
                            ],

                            ),

                          SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Delivery on 15 Jun",
                                style: TextStyle(
                                    fontSize: normalFont,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.red),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Rating",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: normalFont,
                                        color: Colors.green),
                                  ),
                                  SizedBox(width: 5,),
                                  Icon(Icons.star,color: Colors.orange,),
                                  Icon(Icons.star,color: Colors.orange,),
                                  Icon(Icons.star,color: Colors.orange,),
                                  Icon(Icons.star,color: Colors.orange,),
                                ],
                              )
                            ],
                          )

                        ],
                      ),
                    ),
                  ),
                );

            }))
          ],
        ),
      ),
    );
  }
}
