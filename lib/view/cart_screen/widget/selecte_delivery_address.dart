import 'package:flutter/material.dart';
import 'package:nectar/controller/address_controller.dart';
import 'package:nectar/model/address_model.dart';
import 'package:nectar/view/account_screen/delivery_address/delivery_address.dart';

import '../../../utility/fontsize.dart';

class SelectDeliveryAddress extends StatelessWidget {
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
              body: StreamBuilder(
                stream: AddressController.getAddress(),
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Center(child: CircularProgressIndicator.adaptive(),);
                  }

                  List<AddressModel> _addressList = [];
                  for(var i in snapshot.data!.docs){
                    _addressList.add(AddressModel.fromSnapshot(i));
                  }

                  return _addressList.isNotEmpty
                      ? Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ListView.builder(
                      itemCount: _addressList.length,
                      itemBuilder: (context, index){
                        var data = _addressList[index];
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
                              title: Text("${data.addressType}"),
                              subtitle: Text("${data.streetNumber}, ${data.state}, ${data.city}, ${data.country}, ${data.zip}"),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                      : TextButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>DeliveryAddress()));
                        },
                        child: Text("Add new address")
                      );
                }
              )
          ),
        ),
      ),
    );
  }
}
