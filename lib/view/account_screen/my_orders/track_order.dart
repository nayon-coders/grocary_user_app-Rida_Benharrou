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
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: widget.orderModel.products!.length,
                    itemBuilder: (_, index){
                      var data = widget.orderModel.products![index];
                      return Container(
                        padding: EdgeInsets.all(10),
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

                                Text("${data.productInfo!.name}",
                                  style: TextStyle(
                                      fontSize:titleFont,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textBlack),
                                ),
                                SizedBox(height: 8,),
                                Text("${data.productInfo!.productType}",
                                  style: TextStyle(fontWeight: FontWeight.w400,
                                      fontSize: smallFont,
                                      color: AppColors.textGrey),
                                ),


                              ],
                            ),
                            AppNetworkImage(src: data.productInfo!.images![0].toString(), height: 60, width: 60,)
                          ],

                        ),
                      );
                    },
                  )

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
                  Text("Order track",
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
       index == 4 ? Center() : Container(
          margin: EdgeInsets.only(left: 35),
          width: 1.5,
          height: 50,
          color: color,
        )
      ],
    );
  }
}
