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
  final String? docId;
  const DeliveryAddress({super.key,  this.addressModel, this.docId});

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
  final _streetName = TextEditingController();
  final _zipController = TextEditingController();


  List addressType = ["Maison", "Autres"];
  List selectedAddressType = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedAddressType.add(addressType[0]);

    if(widget.addressModel != null){
      _zipController.text = widget.addressModel!.zip!;
      _countyController.text = widget.addressModel!.country!;
      _stateController.text = widget.addressModel!.state!;
      _streetNumber.text = widget.addressModel!.streetNumber!;
      _streetName.text = widget.addressModel!.streetName!;
      _cityController.text = widget.addressModel!.city!;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgWhite,
      appBar: AppBar(
        elevation: 0,
        title: Text( " ${widget.addressModel == null ? "Votre adresse de livraison" : "Modifier l'adresse" } ",
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
            SizedBox(
              height: 50,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: addressType.length,
                itemBuilder: (_, index){
                  return  Container(
                    margin: EdgeInsets.only(right: 20),
                    width: 150,
                    child: InkWell(
                      onTap: (){
                        setState(() {
                          selectedAddressType.clear();
                          selectedAddressType.add(addressType[index]);
                        });
                      },
                      child: Container(

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: selectedAddressType.contains(addressType[index])?AppColors.mainColor:Colors.white,
                          border: Border.all(width: 1, color: selectedAddressType.contains(addressType[index])?AppColors.mainColor:Colors.green,)
                        ),
                        child: Center(child: Text("${addressType[index]}",
                          style: TextStyle(
                            color:  selectedAddressType.contains(addressType[index]) ? Colors.white : Colors.green,
                            fontWeight: FontWeight.w600,
                            fontSize: 15
                          ),
                        )),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20,),
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
                        //validator: (value)=>value!.isEmpty ? 'Please select your street number':null,
                        controller: _streetNumber,
                        hintText: "Street Number",
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
      bottomNavigationBar:Container(
        margin: const EdgeInsets.all(30.0),
        child: AppButton(name: "${widget.addressModel != null ? "Edit" : "Add"}", onClick:(){
          if(selectedAddressType.isEmpty){
            appSnackBar(context: context, text: "Sélectionnez où vous êtes?", bgColor: Colors.red);
            return;
          }
          if(_formKey.currentState!.validate()){
            int id = Random().nextInt(9999);
            var addressModel = AddressModel(
              id: id.toString(),
              country: _countyController.text,
              state: _stateController.text,
              city: _cityController.text,
              streetName: _streetName.text,
              streetNumber: _streetNumber.text,
              email: FirebaseAuth.instance.currentUser!.email,
              zip: _zipController.text,
              addressType: selectedAddressType[0]
            );
            widget.addressModel != null ? AddressController.editAddress(context, addressModel, widget.docId!) : AddressController.addAddress(context, addressModel);
          }
        }),
      ) ,
    );
  }
}
