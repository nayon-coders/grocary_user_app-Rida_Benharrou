import 'package:flutter/material.dart';
import 'package:nectar/controller/address_controller.dart';
import 'package:nectar/generated/assets.dart';
import 'package:nectar/utility/app_color.dart';
import 'package:nectar/utility/app_const.dart';
import 'package:nectar/utility/fontsize.dart';
import 'package:nectar/view/account_screen/delivery_address/delivery_address.dart';
import 'package:nectar/widget/app_dialog.dart';
import 'package:nectar/widget/dialog.dart';

import '../../../model/address_model.dart';

class AddressList extends StatefulWidget {
  const AddressList({super.key});

  @override
  State<AddressList> createState() => _AddressListState();
}

class _AddressListState extends State<AddressList> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgWhite,
      appBar: AppBar(
        backgroundColor: AppColors.bgWhite,
        elevation: 0,
        title:  Text("Delivery Address List",style: TextStyle(
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
        child: StreamBuilder(
          stream: AddressController.getAddress(),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),);
            }
            List<AddressModel> address = [];

            for(var i in snapshot.data!.docs){
              address.add(AddressModel.fromJson(i.data()));
            }
            return address.isNotEmpty 
                ? Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: ListView.builder(
                  itemCount: address.length,
                    itemBuilder: (context,index){
                    var data = address[index];
                  return  Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${data.addressType}",
                              style: TextStyle(
                                  fontSize: titleFont,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textBlack),
                            ),
                            SizedBox(height: 5,),
                            SizedBox(
                              width: MediaQuery.of(context).size.width*.60,
                              child: Text("${data.streetNumber} ${data.streetName}, ${data.state}, ${data.city}, ${data.country} ",
                                style: TextStyle(
                                    fontSize: smallFont,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textGrey),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                                onTap:()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> DeliveryAddress(addressModel: data, docId: snapshot.data!.docs[index].id,))),
                                child: Icon(Icons.edit,color: Colors.green,size: 30,)),
                            SizedBox(width: 20,),
                            InkWell(
                                onTap: ()=>AppDialog(
                                  context: context,
                                  title: "Es-tu sûr ?",
                                  subtitle: "Es-tu sûr ? Vous souhaitez supprimer l'adresse ?",
                                  onDelete: (){
                                    AddressController.deleteAddress(context, snapshot.data!.docs[index].id);
                                  }

                                ),

                                child: Icon(Icons.delete,color: Colors.red,size: 30,)),
                          ],
                        )
                      ],
                    ),
                  );
                }))

              ],
            ) 
                : Center(child: Image.asset(Assets.imagesNoPrd, width: 200,),);
          }
        ),
      ),
      floatingActionButton:FloatingActionButton(
        elevation: 0,
        backgroundColor: AppColors.mainColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(Icons.add,color: Colors.white,),
          onPressed: ()=>Navigator.push(context,MaterialPageRoute(builder: (_)=>DeliveryAddress(),),),
      )
    );
  }
}
