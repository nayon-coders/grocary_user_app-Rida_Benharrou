import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nectar/controller/address_controller.dart';
import 'package:nectar/model/address_model.dart';
import 'package:nectar/utility/app_color.dart';
import 'package:nectar/utility/app_const.dart';
import 'package:nectar/utility/fontsize.dart';
import 'package:nectar/widget/app_button.dart';
import 'package:nectar/widget/app_input.dart';

class DeliveryAddress extends StatefulWidget {
  final AddressModel? addressModel;
  const DeliveryAddress({super.key, this.addressModel});

  @override
  State<DeliveryAddress> createState() => _DeliveryAddressState();
}

class _DeliveryAddressState extends State<DeliveryAddress> {
  bool onClick = false;
  final _formKey = GlobalKey<FormState>();

  final _countyController = TextEditingController();
  final _stateController = TextEditingController();
  final _cityController = TextEditingController();
  final _streetNumber = TextEditingController();
  final _phone = TextEditingController();
  final _zipController = TextEditingController();

  List addredssType = [
    "Home", "Others"
  ];
  List _addedAddressType = [];
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    //
    if(widget.addressModel != null){
      _zipController.text = widget.addressModel!.zip!;
      _countyController.text = widget.addressModel!.country!;
      _streetNumber.text = widget.addressModel!.streetNumber!;
      _stateController.text = widget.addressModel!.state!;
      _cityController.text = widget.addressModel!.city!;
      _addedAddressType.add(widget.addressModel!.addressType);
    }else{
      _addedAddressType.add(addredssType[0]);
    }
  }

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
            child: Icon(Icons.arrow_back_ios_sharp,color: AppColors.textBlack,size: 30,)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            ///ToDo two button home and other
            Center(
              child: SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: addredssType.length,
                  itemBuilder: (_, index){
                    return InkWell(
                      onTap: (){
                        _addedAddressType.clear();
                        setState(() {
                          _addedAddressType.add(addredssType[index]);
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 20),
                        width: 150,
                        decoration: BoxDecoration(
                          color: _addedAddressType.contains( addredssType[index]) ? AppColors.mainColor : Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text("${addredssType[index]}",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              //  border: Border.all(color: Colors.grey.shade200),
                
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20,),
                    AppInput(
                      validator: (value)=>value!.isEmpty ? 'Please add your county':null,
                        controller: _countyController,
                        hintText: "County*"),
                    SizedBox(height: 20,),
                    AppInput(
                        validator: (value)=>value!.isEmpty ? 'Please add your state':null,
                        controller: _stateController, hintText: "State*"),
                    SizedBox(height: 20,),
                    AppInput(
                        validator: (value)=>value!.isEmpty ? 'Please add your city':null,
                        controller: _cityController, hintText: "City*"),
                    SizedBox(height: 20,),
                    AppInput(
                        validator: (value)=>value!.isEmpty ? 'Please add your street number':null,
                        controller: _streetNumber,
                        hintText: "Street Number*",
                    ),
                    SizedBox(height: 20,),

                    AppInput(
                        validator: (value)=>value!.isEmpty ? 'Please add your zip':null,
                        controller: _zipController,
                        hintText: "ZIP*",
                    ),
                    SizedBox(height: 20,),
                    AppInput(
                      validator: (value)=>value!.isEmpty ? 'Please add your phone number':null,
                      controller: _phone,
                      hintText: "Phone Number*",
                    ),
                 
                    SizedBox(height: 20,),

                  ],
                ),
              ),
            ),

          ],
        ),
      ),
      bottomNavigationBar:Container(
        padding: const EdgeInsets.all(15.0),
        margin: const EdgeInsets.all(15.0),
        child: AppButton(name: widget.addressModel != null ? "Edit Address" : "Add Address", onClick: ()async{
          if(_addedAddressType.isEmpty){
            appSnackBar(context: context, text: "Sélectionnez votre type d'adresse", bgColor: Colors.red);
          }
          if(_formKey.currentState!.validate()){

            var id = Random().nextInt(9999);
            var addressModel = AddressModel(
              id: id.toString(),
              country: _countyController.text,
              city: _cityController.text,
              state: _stateController.text,
              streetNumber: _streetNumber.text,
              zip: _zipController.text,
              email: FirebaseAuth.instance.currentUser!.email.toString(),
              addressType: _addedAddressType[0],
              phone: _phone.text
            );
            //store address
            if(widget.addressModel != null){
              //edit
              await AddressController.editAddress(context, addressModel, widget.addressModel!.docId!);
            }else{
              //add
              await AddressController.addAddress(context, addressModel);
            }


          }

        }),
      ) ,
    );
  }
}
