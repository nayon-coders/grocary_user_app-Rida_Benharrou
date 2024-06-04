import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nectar/controller/order_controller.dart';
import 'package:nectar/model/product_model.dart';
import 'package:nectar/utility/app_const.dart';
import 'package:nectar/view/cart_screen/widget/select_payment_method.dart';
import 'package:nectar/view/cart_screen/widget/selecte_delivery_address.dart';

import '../../../utility/app_color.dart';
import '../../../utility/fontsize.dart';
import '../../../widget/app_button.dart';
import '../../order_accepted/order_accepted.dart';
import 'bottomsheet_list.dart';

class OrderPopup extends StatefulWidget {
  final List orderInfo;
  final List docIds;
  const OrderPopup({super.key, required this.orderInfo, required this.docIds});

  @override
  State<OrderPopup> createState() => _OrderPopupState();
}

class _OrderPopupState extends State<OrderPopup> {

  var selectedAddress;
  getSelectedAddress(address){
    setState(() {
      selectedAddress = address;
    });
    print("selectedAddress --- ${selectedAddress}");
  }

  bool _isErrorForAddress =  false;


  var total = 0.00;
  getCalculet(){
    for(var i in widget.orderInfo){
      setState(() {
        total = total + double.parse("${i["price"]}") * double.parse("${i["qty"]}");
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCalculet();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 350,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text("Vérifier",
              style: TextStyle(
                fontSize: titleFont,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: InkWell(
                onTap: ()=>Navigator.pop(context),
                child: Icon(Icons.close,color: Colors.black,)),
          ),
          Divider(color: Colors.grey.shade200,),
          ListbottomSheet(
            title: "Livraison",
            subtitle: SizedBox(
              width: MediaQuery.of(context).size.width*.50,
              child: Text("${selectedAddress ?? "Sélectionnez la méthode" }",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w500),),
            ),
            onClick: (){
              showDialog<void>(
                context: context,
                barrierDismissible: false, // user must tap button!
                builder: (BuildContext context) {
                  return SelectDeliveryAddress(callback: getSelectedAddress,);
                },
              );
            },
          ),
          Divider(color: Colors.grey.shade200,),
          ListbottomSheet(
            title: "Paiement",
            subtitle: SizedBox(
              //width: 200,
              child: Row(
                children: [
                  Icon(Icons.credit_card,color: Colors.orange,),
                  SizedBox(width: 10,),
                  Text("Cash on delivery (COD)",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600
                    ),
                  )
                ],
              ),
            ),
            onClick: (){
                 showDialog<void>(
                  context: context,
                  barrierDismissible: false, // user must tap button!
                  builder: (BuildContext context) {
                    return SelectPaymentMethod();
                  },
                );
              }
          ),
          Divider(color: Colors.grey.shade200,),
          // ListbottomSheet(
          //   title: "Code promo",
          //   subtitle: Text("Choisissez une remise",style: TextStyle(
          //       color: AppColors.textBlack,fontSize: normalFont,fontWeight: FontWeight.w500),),
          //   onClick: (){},
          // ),
          // Divider(color: Colors.grey.shade200,),
          ListbottomSheet(
            title: "Coût total",
            subtitle: Text("\$${total}",style: TextStyle(color: AppColors.textBlack,fontSize: normalFont,fontWeight: FontWeight.w500),),
            onClick: (){},
          ),
          Divider(color: Colors.grey.shade200,),
          Spacer(),
          Center(
            child: Container(
              margin: EdgeInsets.only(bottom: 20),
                width:300,
                child:
                AppButton(
                    name: "Passer la commande",
                    onClick: (){
                      if(selectedAddress == null){
                        Navigator.pop(context);
                        appSnackBar(context: context, text: "Veuillez sélectionner votre adresse de livraison", bgColor: Colors.red);
                        return;
                      }
                      int id = Random().nextInt(99999);
                      Map<String, dynamic> orders = {
                        "id" : id.toString(),
                        "items" : widget.orderInfo,
                        "status" : "Pending",
                        "delivery_address" : selectedAddress,
                        "payment_method" : "Cash on delivery (COD)",
                        "date": DateFormat("dd-mm-yyyy h:m a").format(DateTime.now()),
                        "user" : FirebaseAuth.instance.currentUser!.email
                      };
                      OrderController.placeOrder(context, orders, widget.docIds);
                    })),
          )
        ],
      ),
    );
  }
}
