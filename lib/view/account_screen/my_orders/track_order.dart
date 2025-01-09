import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nectar/routes/app_routes.dart';
import 'package:nectar/utility/app_color.dart';
import 'package:nectar/utility/app_const.dart';
import 'package:nectar/utility/fontsize.dart';
import 'package:nectar/view/navigation_screen/navigation_screen.dart';
import 'package:nectar/widget/app_network_images.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../../data/models/order_model.dart';
import '../../../generated/assets.dart';

class TrackOrder extends StatefulWidget {
  final SingleOrder orderModel;
  const TrackOrder({super.key, required this.orderModel});

  @override
  State<TrackOrder> createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {
  int activeStep = 0;
  continueStep(){
    if(activeStep<4){
      setState(() {
        activeStep = activeStep+1;
      });
    }
  }
  cancelStep(){
    if(activeStep>0){
      setState(() {
        activeStep = activeStep-1;
      });
    }
  }

  var totalTax;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: AppColors.bgWhite,
      appBar: AppBar(
        backgroundColor: AppColors.bgWhite,
        leading: InkWell(
          onTap: ()=>Get.back(),
            child: Icon(Icons.arrow_back,color:AppColors.textBlack,size: 30,)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Suivi de commande",
              style: TextStyle(
                  fontSize: bigFont,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textBlack),
            ),
            SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height:30,
                    child: Text("Commande : ${widget.orderModel!.id}",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: titleFont,
                          color: AppColors.textBlack),
                    ),
                  ),
                  Divider(color: Colors.grey.shade200,),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: widget.orderModel.products!.length,
                    itemBuilder: (_, index){
                      var data = widget.orderModel.products![index];

                      print("data.images![0].imageUrl! --- ${data.images!.length}");
                      return ListTile(
                          shape: Border(bottom:  BorderSide(color:Colors.grey.shade200)),
                          contentPadding: EdgeInsets.only(bottom: 5),
                          leading: Container(
                              width: 70, height:80,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: AppNetworkImage(src: data.images![0].imageUrl! ?? "", width: 60, height:60,)),
                          title: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width*.50,
                                  child: Text("${data.price}€ X ${data.quantity.toString()}",style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color:AppColors.textBlack,
                                  ),
                                  ),
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("${data.name}",
                                          style: TextStyle(fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black),
                                        ),
                                        Text("${data.price}€",
                                          style: TextStyle(fontSize: 10,
                                              fontWeight: FontWeight.w100,
                                              color: Colors.black),
                                        ),

                                      ],
                                    ),

                                  ],
                                )
                              ]
                          )
                      );
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Mode de livrasion: ",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: Text("${widget.orderModel!.userDeliveryAddress!.postCode}, ${widget.orderModel!.userDeliveryAddress!.city}, ${widget.orderModel!.userDeliveryAddress!.address}, ${widget.orderModel!.userDeliveryAddress!.contact}",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.black
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 7,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Date de livraison: ",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                      Text("${widget.orderModel.deliveryDate}",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.black
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 7,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Lieu de livraison: ",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                      Text("${widget.orderModel.paymentMethod}",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.black
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 7,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total H.T. : ",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                      Text("${widget.orderModel.subTotal!.toStringAsFixed(2)}€",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.black
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 7,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Frais de livraison : ",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                      Text("${widget.orderModel!.deliveryFee == "0.00" ? "Fee Delivery" : "${widget.orderModel!.deliveryFee}€"}",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: widget.orderModel!.deliveryFee == "0.00" ? Colors.green : Colors.black
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 7,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total TVA : ",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                      Text("${widget.orderModel.taxAmount!.toStringAsFixed(2)}€",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 7,),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total TTC. : ",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                      Text("${(double.parse("${widget.orderModel.subTotal}") + double.parse("${widget.orderModel!.taxAmount}") + double.parse("${widget.orderModel!.deliveryFee!}"))!.toStringAsFixed(2)}€",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 5,),

                ],
              ),
            ),
            SizedBox(height: 10,),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Statut de la commande",
                    style: TextStyle(
                      fontSize: 17, fontWeight: FontWeight.w600,
                    )
                  ),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: orderStatus.length,
                      itemBuilder: (_, index){

                        return TimelineTile(
                          isFirst: index==0,
                          beforeLineStyle: LineStyle(
                            color: isPastOrder(orderStatus[index], widget.orderModel.orderStatus!) ?  Colors.green : Colors.black,
                          ),
                          indicatorStyle: IndicatorStyle(
                            width: 30,
                            height: 30,
                            color: isPastOrder(orderStatus[index], widget.orderModel.orderStatus!) ?  Colors.green : Colors.black,
                            indicator: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: isPastOrder(orderStatus[index], widget.orderModel.orderStatus!) ?  Colors.green : Colors.black,
                              ),
                              child: Icon(Icons.check, color: Colors.grey.shade200,),
                            )
                          ),
                          isLast: index==orderStatus.length-1,
                          endChild: Container(
                            padding: EdgeInsets.all(20),
                            margin: EdgeInsets.only(left: 10, bottom: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey.shade200)
                            ),
                            child: Column(
                              children: [
                                Text("${orderStatus[index]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textBlack
                                  ),
                                ),
                                SizedBox(height: 4,),
                                Text("${DateFormat('dd-MM-yyyy hh:mm a').format(DateTime.now())}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.textGrey
                                  ),
                                )
                              ],
                            ),

                          )
                        );
                      },
                    ),
                  )


                ],
              )
            ),

          ],
        ),
      ),
    );
  }
}

class OrderTrakingSteper extends StatelessWidget {
  const OrderTrakingSteper({
    super.key, required this.status, required this.date, required this.number, required this.color, required this.index,
  });

  final String status;
  final String date;
  final String number;
  final Color color;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: Container(
            width: 40, height: 40,
            decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(100)
            ),
            child: Center(child: Text("$number",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 17
              ),
            ),),

          ),
          title: Text("${status}",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          subtitle: Text("$date"),
        ),
       index == 5 ? Center() : Container(
          margin: EdgeInsets.only(left: 35),
          width: 1.5,
          height: 50,
          color: color,
        )
      ],
    );
  }
}
