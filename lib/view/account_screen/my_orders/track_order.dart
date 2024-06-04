import 'package:another_stepper/dto/stepper_data.dart';
import 'package:another_stepper/widgets/another_stepper.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:nectar/model/orders_model.dart';
import 'package:nectar/utility/app_color.dart';
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

  List orderStatus = [
    "Pending",
    "Accept",
    "Ready to ship",
    "Delivered",
    "Cancel",
    "Reject"
  ];

  //order status set
  orderSatatusSet(){
    for(var i=0; i<orderStatus.length; i++){

      stepperData.add(StepperData(
          title: StepperText(
            "${orderStatus[i]}",
            textStyle:  TextStyle(
              color:  orderStatus[i] == widget.orderModel!.status ?  Colors.black : Colors.grey,
            ),
          ),
          subtitle: StepperText("Your order has been ${orderStatus[i]}") ,
          iconWidget: Container(
            padding: const EdgeInsets.all(8),
            decoration:  BoxDecoration(
                color:  orderStatus[i] == widget.orderModel!.status ? Colors.green : Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: Center(child:  Text("${i+1}",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Colors.white
              )
            )),
          )),);


    }
  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    orderSatatusSet();
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
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Track Orders",
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
                    child: Text("Order# : ${widget.orderModel!.id}",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: titleFont,
                          color: AppColors.textBlack),
                    ),
                  ),
                  Divider(color: Colors.grey.shade200,),
                  SizedBox(height: 10,),

                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: widget.orderModel!.items!.length,
                    itemBuilder: (_, index){
                      var items = widget.orderModel!.items![index];
                      return Container(
                        margin: EdgeInsets.only(bottom: 10),
                        padding: EdgeInsets.only(bottom: 4),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: 1, color: Colors.grey.shade200)
                          )
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                SizedBox(
                                  width: MediaQuery.of(context).size.width*.60,
                                  child: Text("${items.product!.name}",
                                    style: TextStyle(
                                        fontSize:14,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.textBlack),
                                  ),
                                ),
                                SizedBox(height: 3,),
                                Text("\$${items.price} (${items.product!.productType}) X ${items.qty}",
                                  style: TextStyle(fontWeight: FontWeight.w400,
                                      fontSize: smallFont,
                                      color: AppColors.textGrey),
                                ),


                              ],
                            ),
                            AppNetworkImage(src: items.product!.images![0],height: 50,width: 50,fit: BoxFit.cover,),

                          ],
                        ),
                      );
                    },
                  ),


                ],
              ),
            ),
            SizedBox(height: 10,),


            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(10),
              ),
              child: AnotherStepper(
                stepperList: stepperData,
                stepperDirection: Axis.vertical,
                iconWidth: 40, // Height that will be applied to all the stepper icons
                iconHeight: 40, // Width that will be applied to all the stepper icons
              )

            ),

          ],
        ),
      ),
    );
  }


  List<StepperData> stepperData = [
  ];
}
