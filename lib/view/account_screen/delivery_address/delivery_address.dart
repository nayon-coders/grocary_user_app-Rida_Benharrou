import 'package:flutter/material.dart';
import 'package:nectar/utility/app_color.dart';
import 'package:nectar/utility/fontsize.dart';
import 'package:nectar/widget/app_button.dart';
import 'package:nectar/widget/app_input.dart';

class DeliveryAddress extends StatefulWidget {
  const DeliveryAddress({super.key});

  @override
  State<DeliveryAddress> createState() => _DeliveryAddressState();
}

class _DeliveryAddressState extends State<DeliveryAddress> {
  final _formKey = GlobalKey<FormState>();
  void validateAndSave(){
    final form = _formKey.currentState;
    if(form!.validate())
    {
      print ('Form is valid');
    }
    else
    {
      print('form is invalid');
    }
  }
  final _countyController = TextEditingController();
  final _stateController = TextEditingController();
  final _cityController = TextEditingController();
  final _streetNumber = TextEditingController();
  final _streetName = TextEditingController();
  final _zipController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgWhite,
      appBar: AppBar(
        elevation: 0,
        title: Text("Your Delivery Address",
          style: TextStyle(
              fontSize: bigFont,
              fontWeight: FontWeight.w600,
              color: AppColors.textBlack),
        ),
        centerTitle: true,
        backgroundColor: AppColors.bgWhite,
        leading: InkWell(
          onTap: ()=>Navigator.pop(context),
            child: Icon(Icons.arrow_back,color: AppColors.textBlack,size: 30,)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade200),
                
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20,),
                    AppInput(
                      validator: (value)=>value!.isEmpty ? 'Please select your county':null,
                        controller: _countyController,
                        hintText: "County*"),
                    SizedBox(height: 20,),
                    AppInput(
                        validator: (value)=>value!.isEmpty ? 'Please select your state':null,
                        controller: _stateController, hintText: "State*"),
                    SizedBox(height: 20,),
                    AppInput(
                        validator: (value)=>value!.isEmpty ? 'Please select your city':null,
                        controller: _cityController, hintText: "City*"),
                    SizedBox(height: 20,),
                    AppInput(
                        validator: (value)=>value!.isEmpty ? 'Please select your street number':null,
                        controller: _streetNumber,
                        hintText: "Street Number*",
                    ),
                    SizedBox(height: 20,),
                    AppInput(
                        validator: (value)=>value!.isEmpty ? 'Please select your street name':null,
                        controller: _streetName,
                        hintText: "Street Name*",
                    ),
                    SizedBox(height: 20,),
                    AppInput(
                        validator: (value)=>value!.isEmpty ? 'Please select your zip':null,
                        controller: _zipController,
                        hintText: "ZIP*",
                    ),
                    SizedBox(height: 20,),

                  ],
                ),
              ),
            ),

          ],
        ),
      ),
      bottomNavigationBar:Padding(
        padding: const EdgeInsets.all(15.0),
        child: AppButton(name: "Order", onClick: validateAndSave),
      ) ,
    );
  }
}
