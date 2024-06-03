import 'package:flutter/material.dart';
import 'package:nectar/view/cart_screen/widget/select_payment_method.dart';
import 'package:nectar/view/cart_screen/widget/selecte_delivery_address.dart';

import '../../../utility/app_color.dart';
import '../../../utility/fontsize.dart';
import '../../../widget/app_button.dart';
import '../../order_accepted/order_accepted.dart';
import 'bottomsheet_list.dart';

class OrderPopup extends StatefulWidget {
  const OrderPopup({super.key});

  @override
  State<OrderPopup> createState() => _OrderPopupState();
}

class _OrderPopupState extends State<OrderPopup> {
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
            subtitle: Text("Sélectionnez la méthode",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w500),),
            onClick: (){
              showDialog<void>(
                context: context,
                barrierDismissible: false, // user must tap button!
                builder: (BuildContext context) {
                  return SelectDeliveryAddress();
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
          ListbottomSheet(
            title: "Code promo",
            subtitle: Text("Choisissez une remise",style: TextStyle(
                color: AppColors.textBlack,fontSize: normalFont,fontWeight: FontWeight.w500),),
            onClick: (){},
          ),
          Divider(color: Colors.grey.shade200,),
          ListbottomSheet(
            title: "Coût total",
            subtitle: Text("\$13.97",style: TextStyle(color: AppColors.textBlack,fontSize: normalFont,fontWeight: FontWeight.w500),),
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
                      Navigator.pop(context);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context)=>OrderAccepted()));

                    })),
          )
        ],
      ),
    );
  }
}
