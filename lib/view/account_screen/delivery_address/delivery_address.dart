
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nectar/utility/app_color.dart';
import 'package:nectar/utility/fontsize.dart';
import 'package:nectar/widget/app_button.dart';
import 'package:nectar/widget/app_input.dart';

import '../controller/address_controller.dart';

class DeliveryAddress extends StatefulWidget {
  const DeliveryAddress({super.key});


  @override
  State<DeliveryAddress> createState() => _DeliveryAddressState();
}

class _DeliveryAddressState extends State<DeliveryAddress> {
  final dropDownKey = GlobalKey<DropdownSearchState>();

  bool onClick = false;
  final _formKey = GlobalKey<FormState>();
  final addressModel = Get.arguments;


  AddressControllerNew addressController = Get.find();


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
            child: const Icon(Icons.arrow_back_ios_sharp,color: AppColors.textBlack,size: 30,)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
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
                const SizedBox(height: 20,),
                const Text("Adress *"),
                const SizedBox(height: 10,),
                AppInput(
                    validator: (value)=>value!.isEmpty ? "Indiquez l'adresse":null,
                    controller: addressController.addressText.value,
                    hintText: "Indiquez l'adresse *"),
                const SizedBox(height: 20,),
                const Text("Code Postal *"),
                const SizedBox(height: 10,),
                Obx((){
                  return DropdownSearch<String>(
                    key: dropDownKey,
                    selectedItem: "Menu",
                    items: (filter, infiniteScrollProps) =>addressController.postCodeList.value,
                    decoratorProps: DropDownDecoratorProps(
                      decoration: InputDecoration(
                        labelText: 'Examples for: ',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    popupProps: PopupProps.menu(fit: FlexFit.loose, constraints: BoxConstraints()),
                  );
                }),
                const SizedBox(height: 20,),
                const Text("Ville *"),
                const SizedBox(height: 10,),
                AppInput(
                    validator: (value)=>value!.isEmpty ? "Indiquez la ville" : null,
                    controller: addressController.villeText.value,
                    hintText: "Indiquez la ville"
                ),
                const SizedBox(height: 20,),
                const Text("Message *"),
                const SizedBox(height: 10,),
                AppInput(
                  maxLine: 4,
                  validator: (value)=>value!.isEmpty ? "Indiquez dans ce champs toutes information utile à la livraison, ex: rideau de fer ouvert, déposez les marchandises et refermez.":null,
                  controller: addressController.messageText.value,
                  hintText: "Indiquez dans ce champs toutes information utile à la livraison, ex: rideau de fer ouvert, déposez les marchandises et refermez.",
                ),
                const SizedBox(height: 20,),
                const Text("Contact Livraison *"),
                const SizedBox(height: 10,),
                AppInput(
                  validator: (value)=>value!.isEmpty ? " Indiquez le nom et/ou prénom de la personne à contacter":null,
                  controller: addressController.contactText.value,
                  hintText: " Indiquez le nom et/ou prénom de la personne à contacter",
                ),
                const SizedBox(height: 20,),
                const Text("Mobile *"),
                const SizedBox(height: 10,),
                AppInput(
                  validator: (value)=>value!.isEmpty ? "Indiquez le mobile de la personne à contacter":null,
                  controller: addressController.phoneText.value,
                  hintText: "Mobile ",
                ),

                const SizedBox(height: 20,),

              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar:Container(
        padding: const EdgeInsets.all(15.0),
        margin: const EdgeInsets.all(15.0),
        child: Obx(() {
            return AppButton(
              isLoading: addressController.isLoading.value,
                name: addressModel != null ? "Modifier Adresse" : "Ajouter une Nouvelle Adresse", onClick: ()async{
                  if(_formKey.currentState!.validate()){
                    if(addressModel != null){
                      await addressController.updateAddress(addressModel!.id.toString());
                    }else{
                      await addressController.addAddress();
                    }

              }

            });
          }
        ),
      ) ,
    );
  }
}
