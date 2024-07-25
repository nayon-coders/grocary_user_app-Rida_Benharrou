import 'dart:math';

import 'package:dropdown_search/dropdown_search.dart';
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

  final _address = TextEditingController();
  final _postCode = TextEditingController();
  final _cityController = TextEditingController();
  final _messages = TextEditingController();
  final _phone = TextEditingController();
  final _contact = TextEditingController();

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
      _contact.text = widget.addressModel!.contact!;
      _address.text = widget.addressModel!.address!;
      _messages.text = widget.addressModel!.messages!;
      _postCode.text = widget.addressModel!.postCode!;
      _cityController.text = widget.addressModel!.city!;
      _phone.text = widget.addressModel!.phone.toString();
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
        title: Text("Nouvelle adresse de Livraison",
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
        child: Container(
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
                Text("Adress *"),
                SizedBox(height: 10,),
                AppInput(
                    validator: (value)=>value!.isEmpty ? "Indiquez l'adresse":null,
                    controller: _address,
                    hintText: "Indiquez l'adresse *"),
                SizedBox(height: 20,),
                Text("Code Postal *"),
                SizedBox(height: 10,),
                StreamBuilder(
                 stream: AddressController.getAllPostCode(),
                    builder: (context, snapshot){
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return Container(height: 40, color: Colors.white,);
                      }
                      List<String> postCode = [];
                      for(var i in snapshot.data!.docs){
                        postCode.add(i.data()["name"].toString());
                      }
                      return DropdownSearch<String>(
                        popupProps: PopupProps.menu(
                          showSelectedItems: true,
                          disabledItemFn: (String s) => s.startsWith('I'),
                        ),
                        items: postCode,
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            hintText: "Code Postal",
                            hintStyle: TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                              fontWeight: FontWeight.w600
                            ),
                            contentPadding: EdgeInsets.only(left: 10, right: 10),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10)
                            ),
                            fillColor: Colors.grey.shade100,
                            filled: true
                          ),
                        ),
                        onChanged: (v){
                          _postCode.text = v.toString();
                        },
                        //selectedItem: "Code Postal",
                      );
                    }
                ),
                SizedBox(height: 20,),
                Text("Ville *"),
                SizedBox(height: 10,),
                AppInput(
                    validator: (value)=>value!.isEmpty ? "Indiquez la ville":null,
                    controller: _cityController, hintText: "Indiquez la ville"),
                SizedBox(height: 20,),
                Text("Message *"),
                SizedBox(height: 10,),
                AppInput(
                  maxLine: 4,
                  validator: (value)=>value!.isEmpty ? "Indiquez dans ce champs toutes information utile à la livraison, ex: rideau de fer ouvert, déposez les marchandises et refermez.":null,
                  controller: _messages,
                  hintText: "Indiquez dans ce champs toutes information utile à la livraison, ex: rideau de fer ouvert, déposez les marchandises et refermez.",
                ),
                SizedBox(height: 20,),
                Text("Contact Livraison *"),
                SizedBox(height: 10,),
                AppInput(
                  validator: (value)=>value!.isEmpty ? " Indiquez le nom et/ou prénom de la personne à contacter":null,
                  controller: _contact,
                  hintText: " Indiquez le nom et/ou prénom de la personne à contacter",
                ),
                SizedBox(height: 20,),
                Text("Mobile *"),
                SizedBox(height: 10,),
                AppInput(
                  validator: (value)=>value!.isEmpty ? "Indiquez le mobile de la personne à contacter":null,
                  controller: _phone,
                  hintText: "Mobile ",
                ),

                SizedBox(height: 20,),

              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar:Container(
        padding: const EdgeInsets.all(15.0),
        margin: const EdgeInsets.all(15.0),
        child: AppButton(name: widget.addressModel != null ? "Edit Address" : "Ajouter une Nouvelle Adresse", onClick: ()async{
          if(_addedAddressType.isEmpty){
            appSnackBar(context: context, text: "Sélectionnez votre type d'adresse", bgColor: Colors.red);
          }
          if(_formKey.currentState!.validate()){

            //
            if(_postCode.text.isEmpty){
               appSnackBar(context: context, text: "Select post code", bgColor: Colors.red);
               return;
            }

            var id = Random().nextInt(9999);
            var addressModel = AddressModel(
              id: id.toString(),
              address: _address.text,
              city: _cityController.text,
              postCode: _postCode.text,
              messages: _messages.text,
              contact: _contact.text,
              email: FirebaseAuth.instance.currentUser!.email.toString(),
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
