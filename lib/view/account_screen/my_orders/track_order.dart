import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:nectar/utility/app_color.dart';
import 'package:nectar/utility/fontsize.dart';

import '../../../generated/assets.dart';

class TrackOrder extends StatefulWidget {
  const TrackOrder({super.key});

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
    return SafeArea(child: Scaffold(
      backgroundColor: AppColors.bgWhite,
      appBar: AppBar(
        backgroundColor: AppColors.bgWhite,
        leading: InkWell(
          onTap: ()=>Navigator.pop(context),
            child: Icon(Icons.arrow_back,color:AppColors.textBlack,size: 30,)),
        actions: [
          InkWell(
            onTap: (){},
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Icon(Icons.search,color: AppColors.textBlack,size: 30,),
              )),
          InkWell(
              onTap: (){},
              child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(Icons.lock_clock_sharp,color: AppColors.textBlack,size: 30,),
          )),
        ],
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
                    child: Text("Order# : 94584",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: titleFont,
                          color: AppColors.textBlack),
                    ),
                  ),
                  Divider(color: Colors.grey.shade200,),
                  SizedBox(height: 10,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text("Potatoes",
                            style: TextStyle(
                                fontSize:titleFont,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textBlack),
                          ),
                          SizedBox(height: 8,),
                          Text("Rs.55 kg",
                            style: TextStyle(fontWeight: FontWeight.w400,
                                fontSize: smallFont,
                                color: AppColors.textGrey),
                          ),


                        ],
                      ),
                      Image.asset(Assets.imagesPotato,height: 60,width: 80,fit: BoxFit.cover,),
                    ],

                  ),

                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Rating",
                        style: TextStyle(
                            fontSize: normalFont,
                            fontWeight: FontWeight.w500,
                            color: Colors.red),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stepper(
                onStepCancel: cancelStep,
                onStepContinue: continueStep,
                currentStep: activeStep,
                  steps:[
                    Step(
                      isActive: activeStep>=0,
                      state: activeStep>=0?StepState.complete:StepState.disabled,
                      //
                        title: const Text("Order Placed"),
                        subtitle: const Text("we have Placed your order"),
                      content: Icon(Icons.delivery_dining,color: Colors.orange,size: 40,),
              
                    ),
                    Step(
                      isActive: activeStep>=1,
                      state: activeStep>=1?StepState.complete:StepState.disabled,
                      title: const Text("Order Confirmed"),
                      subtitle: const Text("we have Confirmed your order"),
                      content: Icon(Icons.delivery_dining,color: Colors.orange,size: 40,),
                    ),
                    Step(
                      isActive: activeStep>=2,
                      state: activeStep>=2?StepState.complete:StepState.disabled,
                      title: const Text("Order Processed"),
                      subtitle: const Text("we have Process your order"),
                      content: Icon(Icons.delivery_dining,color: Colors.orange,size: 40,),
                    ),
                    Step(
                      isActive: activeStep>=3,
                      state: activeStep>=3?StepState.complete:StepState.disabled,
                      title: const Text("Ready to Shift"),
                      subtitle: const Text("we have Shift your order"),
                      content: Icon(Icons.delivery_dining,color: Colors.orange,size: 40,),
                    ),
                    Step(
                      isActive: activeStep>=4,
                      state: activeStep>=4?StepState.complete:StepState.disabled,
                      title: const Text("Out of delivery"),
                      subtitle: const Text("we have recived your order"),
                      content: Icon(Icons.delivery_dining,color: Colors.orange,size: 40,),
                    ),
              
              
              ]),
            ),

          ],
        ),
      ),
    ));
  }
}
