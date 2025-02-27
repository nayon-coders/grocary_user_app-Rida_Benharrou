import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nectar/utility/app_color.dart';
import 'package:nectar/view/account_screen/delivery_address/delivery_address.dart';
import '../../../data/models/delivery_address_model.dart';
import '../../account_screen/controller/address_controller.dart';

class SelectDeliveryAddress extends GetView<AddressControllerNew> {
  const SelectDeliveryAddress({super.key, required this.callback});

  final Function(AddressModel) callback;


  @override
  Widget build(BuildContext context) {
    RxInt selectedIndex = (-1).obs;
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
            backgroundColor: Colors.white,
              appBar: AppBar(
                title: const Text("Sélectionnez l'adresse de livraison"),
              ),
              body: Obx((){
                if(controller.isLoading.value){
                  return const Center(child: CircularProgressIndicator.adaptive(),);
                }else if(controller.address.value.data == null){
                  return Center(
                    child: TextButton(
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>DeliveryAddress()));
                            },
                            child: const Text("Ajouter une nouvelle adresse+")
                          ),
                  );
                }else{
                 return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ListView.builder(
                      itemCount: controller.address.value.data!.length,
                      itemBuilder: (context, index){
                        var data = controller.address.value.data![index];
                        return Obx((){
                            return InkWell(
                              onTap: (){
                                selectedIndex.value = index;
                                callback(data);
                                Navigator.pop(context);

                              },
                              child: Container(
                                    margin: const EdgeInsets.only(bottom: 10),
                                    decoration: BoxDecoration(
                                        color:selectedIndex.value ==index?AppColors.mainColor: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(width: 1, color: Colors.grey)
                                    ),
                                    child: ListTile(
                                      title: Text("${data.postCode}, ${data.city}, ${data.address}, ${data.contact}",style: TextStyle(
                                        color: selectedIndex.value == index ? Colors.white : Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),),
                                      subtitle: Text("${data.message}", style: TextStyle(
                                      color: selectedIndex.value == index ? Colors.white70 : Colors.black54,
                                      ),),
                                    ),
                                  ),

                            );
                          }
                        );
                      },
                    ),
                  );
                }
              }),
            floatingActionButton: FloatingActionButton(
              backgroundColor: AppColors.mainColor,
                child: Icon(Icons.add,color: Colors.white,),
                onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>DeliveryAddress()));}),

          ),
        ),
      ),
    );
  }
}
