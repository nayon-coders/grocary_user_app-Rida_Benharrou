import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nectar/utility/app_color.dart';
import 'package:nectar/utility/fontsize.dart';
import 'package:nectar/view/account_screen/delivery_address/delivery_address.dart';
import 'package:nectar/widget/app_dialog.dart';
import 'package:nectar/widget/not_found.dart';

import '../../../routes/app_routes.dart';
import '../controller/address_controller.dart';

class AddressList extends GetView<AddressControllerNew> {
  const AddressList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgWhite,
      appBar: AppBar(
        backgroundColor: AppColors.bgWhite,
        elevation: 0,
        title:  Text("Mes adresses de livraison",style: TextStyle(
          fontWeight: FontWeight.w600,
          color: AppColors.textBlack,
          fontSize: titleFont,
        ),),
        leading: InkWell(
          onTap: ()=>Navigator.pop(context),
            child: Icon(Icons.arrow_back_ios_sharp,color: AppColors.textBlack,size: 30,)),

      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child:   Obx(() {
          if(controller.isLoading.value){
            return Center(child: CircularProgressIndicator.adaptive(),);
          }else if(controller.address.value.data!.isEmpty){
            return NotFound();
          }else{
            return ListView.builder(
                itemCount: controller.address.value.data!.length,
                itemBuilder: (context,index){
                  var data = controller.address.value.data![index];
                  return  Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${data.city}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                        SizedBox(height: 3,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width*.60,
                              child: Text("${data.postCode}, ${data.city}, ${data.address}, ${data.contact}",
                                style: TextStyle(
                                    fontSize: smallFont,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                InkWell(
                                    onTap:(){
                                      //init data
                                      controller.addressText.value.text = data.address!;
                                      controller.villeText.value.text = data.city!;
                                      controller.messageText.value.text = data.message!;
                                      controller.contactText.value.text = data.contact!;
                                      controller.phoneText.value.text = data.phone!;
                                      controller.postCodeText.value = data.postCode!;
                                      Get.toNamed(AppRoutes.addressAdd,arguments: data);
                                    },
                                    child: Icon(Icons.edit,color: Colors.green,size: 30,)),
                                SizedBox(width: 20,),
                                InkWell(
                                    onTap: ()=>AppDialog(
                                        context,
                                        "Delete this address",
                                        "Are you sure you want delete this?",
                                            ()async{
                                          await controller.deleteAddress(data.id.toString());
                                        }

                                    ),
                                    child: Icon(Icons.delete,color: Colors.red,size: 30,)),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                });
          }
          }
        )
      ),
      floatingActionButton:FloatingActionButton(
        elevation: 0,
        backgroundColor: AppColors.mainColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(Icons.add,color: Colors.white,),
          onPressed: ()=>Get.toNamed(AppRoutes.addressAdd)
      )
    );
  }
}
