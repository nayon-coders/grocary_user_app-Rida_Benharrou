import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nectar/view/account_screen/delivery_address/delivery_address.dart';
import '../../../data/models/delivery_address_model.dart';
import '../../account_screen/controller/address_controller.dart';

class SelectDeliveryAddress extends GetView<AddressControllerNew> {
  const SelectDeliveryAddress({super.key, required this.callback});

  final Function(AddressModel) callback;

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: AlertDialog(
        backgroundColor: Colors.white,
        titlePadding: EdgeInsets.zero,
        insetPadding: EdgeInsets.zero, // Removes padding
        contentPadding: EdgeInsets.zero,
        iconPadding: EdgeInsets.zero,
        actionsPadding: EdgeInsets.zero,
        buttonPadding: EdgeInsets.zero,
        content: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Scaffold(
              appBar: AppBar(
                title: Text("Sélectionnez l'adresse de livraison"),
              ),
              body: Obx((){
                if(controller.isLoading.value){
                  return Center(child: CircularProgressIndicator.adaptive(),);
                }else if(controller.address.value.data!.isEmpty){
                  return TextButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>DeliveryAddress()));
                          },
                          child: Text("Ajouter une nouvelle adress")
                        );
                }else{
                 return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ListView.builder(
                      itemCount: controller.address.value.data!.length,
                      itemBuilder: (context, index){
                        var data = controller.address.value.data![index];
                        return InkWell(
                          onTap: (){
                            callback(data);
                            Navigator.pop(context);

                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(width: 1, color: Colors.grey)
                            ),
                            child: ListTile(
                              title: Text("${data.postCode}, ${data.city}, ${data.address}, ${data.contact}"),
                              subtitle: Text("${data.message}"),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              }),

          ),
        ),
      ),
    );
  }
}
