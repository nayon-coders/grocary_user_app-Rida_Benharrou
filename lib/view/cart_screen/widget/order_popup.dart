import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nectar/controller/order_controller.dart';
import 'package:nectar/model/address_model.dart';
import 'package:nectar/utility/app_const.dart';
import 'package:nectar/view/cart_screen/widget/select_payment_method.dart';
import 'package:nectar/view/cart_screen/widget/selecte_delivery_address.dart';

import '../../../model/product_model.dart';
import '../../../utility/app_color.dart';
import '../../../utility/fontsize.dart';
import '../../../widget/app_button.dart';
import '../../order_accepted/order_accepted.dart';
import 'bottomsheet_list.dart';

class OrderPopup extends StatefulWidget {
  final List<String> docId;
  final List<ProductModel> productList;
  final List qty;
  final List<double> totalPrice;
  const OrderPopup({super.key, required this.docId, required this.productList, required this.qty, required this.totalPrice});

  @override
  State<OrderPopup> createState() => _OrderPopupState();
}

class _OrderPopupState extends State<OrderPopup> {

  double totalPrice = 0.00;
  double itemPrice = 0.00;
  bool _deliveryAddressAlert = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.qty!.isNotEmpty){
      totalPrice = 0.00;
      for(var i = 0; i<widget.qty.length; i++){
        setState(() {
          totalPrice = totalPrice + (widget.totalPrice[i] * widget.qty![i]);
          itemPrice = widget.totalPrice[i];
        });
      }

    }
  }

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 400,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text("Récapitulatif",
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
          Container(
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: _deliveryAddressAlert ? Colors.red : Colors.transparent)
            ),
            child: ListbottomSheet(
              title: "Mode de livraison",
              subtitle: SizedBox(width: MediaQuery.of(context).size.width*.40, child: Text(_selectedAddress !=null ? "${_selectedAddress!.messages}, ${_selectedAddress!.postCode}, ${_selectedAddress!.city}, ${_selectedAddress!.address}, ${_selectedAddress!.contact}" : "Sélectionnez la méthode", overflow: TextOverflow.ellipsis, style: TextStyle(color: _deliveryAddressAlert ? Colors.red : Colors.black,fontSize: 15,fontWeight: FontWeight.w500,),)),
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
          ),
          Divider(color: Colors.grey.shade200,),
          ListbottomSheet(
            title: "Méthode de paiement ",
            subtitle: SizedBox(
              width: MediaQuery.of(context).size.width*.40,
              child: Row(
                children: [
                  Icon(Icons.credit_card,color: Colors.orange,),
                  SizedBox(width: 10,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*.30,
                    child: Text("Cash on delivery (COD)",
                        overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600
                      ),
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
          // Divider(color: Colors.grey.shade200,),
          // ListbottomSheet(
          //   title: "Code promo",
          //   subtitle: Text("Choisissez une remise",style: TextStyle(
          //       color: AppColors.textBlack,fontSize: normalFont,fontWeight: FontWeight.w500),),
          //   onClick: (){},
          // ),
          Divider(color: Colors.grey.shade200,),
          ListbottomSheet(
            title: "Total H.T.",
            subtitle: Text("\€${totalPrice}",style: TextStyle(color: AppColors.textBlack,fontSize: normalFont,fontWeight: FontWeight.w500),),
            onClick: (){},
          ),
          Divider(color: Colors.grey.shade200,),
          ListbottomSheet( ///TODO: if you want to add dynamic text by back office you car change it
            title: "TVA 5,5%",
            subtitle: Text("5.5%",style: TextStyle(color: AppColors.textBlack,fontSize: normalFont,fontWeight: FontWeight.w500),),
            onClick: (){},
          ),
          Divider(color: Colors.grey.shade200,),
          ListbottomSheet(
            title: "Total TTC.",
            subtitle: Text("\€${(totalPrice + (totalPrice / 100 * 5.5)).toStringAsFixed(2)}",style: TextStyle(color: AppColors.textBlack,fontSize: normalFont,fontWeight: FontWeight.w500),),
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
                    isLoading: _isLoading,
                    onClick: ()async{

                      //check _selectedAddress is empty or not 
                      if(_selectedAddress == null){
                        setState(() {
                          _deliveryAddressAlert = true;
                        });
                        return;
                      }

                      print("qty --- ${widget.qty}");
                      print("qty produt--- ${widget.productList.length}");

                      var id = Random().nextInt(9999);
                      List orderProducts = [];


                      setState(() => _isLoading = true);
                      for(var i = 0; i< widget.productList.length; i++){
                        orderProducts.add({
                          "product_info" :  widget.productList[i].toJson(),
                          "qty" : widget.qty[i],
                          "item_price" : itemPrice,
                        });
                      }
                      
                      
                      Map<String, dynamic> orders = {
                        "id" : id.toString(),
                        "products" : orderProducts,
                        "create_by" : FirebaseAuth.instance.currentUser!.email.toString(),
                        "create_at" : DateFormat("yyyy-dd-MM hh:mm a").format(DateTime.now()),
                        "order_status" : "Pending",
                        "address" : _selectedAddress!.toJson(),
                        "sub_total" : totalPrice.toStringAsFixed(2),
                        "tax" : "5.5%",
                        "total" : (totalPrice + (totalPrice / 100 * 5.5)).toStringAsFixed(2),
                        "payment_method" : "Cash on delivery (COD)", ///TODO: payment method need to make it dynamic

                      };
                     await OrderController.placeOrder(context, orders, widget.docId).then((value) {
                       // Navigator.push(context,
                       //     MaterialPageRoute(builder: (context)=>OrderAccepted()));
                     });

                      setState(() => _isLoading = false);


                    })),
          )
        ],
      ),
    );
  }

  AddressModel? _selectedAddress; 
  getSelectedAddress(AddressModel addressModel) {
    setState(() {
      _deliveryAddressAlert = false;
      _selectedAddress = addressModel; 
    });
  }
}
