import 'package:flutter/material.dart';
import 'package:nectar/controller/address_controller.dart';

import '../../../model/address_model.dart';
import '../../../utility/fontsize.dart';

class SelectDeliveryAddress extends StatelessWidget {
  final Function(String) callback;
  const SelectDeliveryAddress({super.key, required this.callback});

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
              body: Padding(
                padding: const EdgeInsets.all(20.0),
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
                    return ListView.builder(
                      itemCount: address.length,
                      itemBuilder: (context, index){
                        var data = address[index];
                        return InkWell(
                          onTap: (){
                            callback("${data.zip}, ${data.streetNumber}, ${data.streetName}, ${data.state}, ${data.city}, ${data.country}");
                            Navigator.pop(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(width: 1, color: Colors.grey)
                            ),
                            child: ListTile(
                              title: Text("${data.addressType}"),
                              subtitle: Text("${data.zip}, ${data.streetNumber}, ${data.streetName}, ${data.state}, ${data.city}, ${data.country}"),
                            ),
                          ),
                        );
                      },
                    );
                  }
                ),
              )
          ),
        ),
      ),
    );
  }
}
