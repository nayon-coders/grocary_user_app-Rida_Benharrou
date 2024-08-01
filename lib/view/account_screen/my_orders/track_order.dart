import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:nectar/model/orders_model.dart';
import 'package:nectar/utility/app_color.dart';
import 'package:nectar/utility/app_const.dart';
import 'package:nectar/utility/fontsize.dart';
import 'package:nectar/widget/app_network_images.dart';

import '../../../generated/assets.dart';

class TrackOrder extends StatefulWidget {
  final OrderModel orderModel;
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
  double totalTax = 0.00;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for(var i in widget.orderModel!.products!){
      totalTax = totalTax + double.parse(i!.tax.toString());
      setState(() {

      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: AppColors.bgWhite,
      appBar: AppBar(
        backgroundColor: AppColors.bgWhite,
        leading: InkWell(
          onTap: ()=>Navigator.pop(context),
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

                      return ListTile(
                        shape: Border(bottom:  BorderSide(color:Colors.grey.shade200)),
                        contentPadding: EdgeInsets.only(bottom: 5),
                        leading: Container(
                            width: 70, height:80,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: AppNetworkImage(src: data.productInfo!.images![0], width: 60, height:60,)),
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width*.50,
                              child: Text("${data.itemPrice}€ ",style: TextStyle(
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
                                    Text("${data.productInfo!.name}",
                                      style: TextStyle(fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black),
                                    ),
                                    Text("${data.itemPrice}€ / ${data.productInfo!.productType}",
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
                      Text("${widget.orderModel.subTotal}€",
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
                      Text("${totalTax.toStringAsFixed(2)}%",
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
                      Text("${widget.orderModel!.totalAmount}€",
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
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: orderStatus.length,
                    itemBuilder: (_, index){
                      return orderStatus[index].toString().toLowerCase() == widget.orderModel!.orderStatus!.toLowerCase()
                          ? OrderTrakingSteper(
                          status: widget.orderModel!.orderStatus!,
                          date: widget.orderModel!.createAt!,
                          number: (index+1).toString(),
                          color: AppColors.mainColor,
                        index: index,
                      ) : OrderTrakingSteper(
                          status: orderStatus[index],
                          date: "-----",
                          number: (index+1).toString(),
                          color: Colors.grey,
                        index: index,
                      );
                    },
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
