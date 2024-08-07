import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nectar/controller/address_controller.dart';
import 'package:nectar/controller/order_controller.dart';
import 'package:nectar/model/address_model.dart';
import 'package:nectar/utility/app_const.dart';
import 'package:nectar/view/cart_screen/widget/select_payment_method.dart';
import 'package:nectar/view/cart_screen/widget/selecte_delivery_address.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

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
  double subTotal = 0.00;
  double itemPrice = 0.00;
  double deliveryFeeMinmum = 66.00;
  double deliveryFee = 0.00;
  double tax = 0.0;
  bool _deliveryAddressAlert = false;
  double totalTVA = 0.00;
  double totalTVAamount = 0.00;

  DateTime getInitialDate() {
    DateTime initialDate = DateTime.now().add(Duration(days: 10));
    while (initialDate.weekday == DateTime.saturday || initialDate.weekday == DateTime.sunday) {
      if(initialDate.weekday == DateTime.friday){
        setState(() {
          initialDate = initialDate.add(Duration(days: 3));
        });
      }else if(initialDate.weekday == DateTime.saturday){
        setState(() {
          initialDate = initialDate.add(Duration(days: 2));
        });
      }else{
        setState(() {
          initialDate = initialDate.add(Duration(days: 1));
        });
      }



    }
    return initialDate;
  }

  var _onSelectionChanged;

  var selectedDeliveryDateTime;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.qty!.isNotEmpty){
      totalPrice = 0.00;
      tax = 0.00;
      subTotal = 0.00;
      print("priduct price === ${widget.productList.length}");
      print("priduct price === ${widget.qty.length}");
      for(var i = 0; i<widget.qty.length; i++){

        setState(() {
          totalPrice = totalPrice + (widget.totalPrice[i] * widget.qty[i]) + ((widget.totalPrice[i] * widget.qty[i]) / 100 * double.parse("${widget.productList[i].tax}"));

          totalTVAamount = (widget.totalPrice[i] * widget.qty[i]) + ((widget.totalPrice[i] * widget.qty[i]) / 100 * double.parse("${widget.productList[i].tax}"));
          subTotal = subTotal + (widget.totalPrice[i] * widget.qty[i]);
          totalTVA = totalTVA + double.parse("${widget.productList[i].tax}");
          print("totalPrice --- ${totalPrice}");
          itemPrice = widget.totalPrice[i];
          //tax = double.parse("${widget.productList[i].tax}");
          //delivery fee
          if(subTotal > deliveryFeeMinmum){
            deliveryFee = 15.00;
          }else{
            deliveryFee = 0.00;
          }
        });



      }

    }

    print("total price -- ${tax}");
    //get init address
    getAddress();

    //init date
    selectedDeliveryDateTime = DateFormat("dd/MM/yyyy HH'h'mm").format(DateTime.now().add(Duration(days: 1)));


    //init payment method
    paymentMethod = "Virement";
  }

  getAddress()async{
    var initAddress = await AddressController.getInitAddress();
    if(initAddress.isNotEmpty){
      setState(() {
        _selectedAddress = initAddress[0];
      });
    }

  }

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 470,
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
              subtitle: SizedBox(width: MediaQuery.of(context).size.width*.40, child: Text(_selectedAddress != null ? "${_selectedAddress!.postCode}, ${_selectedAddress!.city}, ${_selectedAddress!.address}, ${_selectedAddress!.contact}" : "Sélectionnez la méthode", overflow: TextOverflow.ellipsis, style: TextStyle(color: _deliveryAddressAlert ? Colors.red : Colors.black,fontSize: 15,fontWeight: FontWeight.w500,),)),
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
            title: "Date de livraison",
            subtitle:  Text("${ selectedDeliveryDateTime  ?? "Date de livraison"}",style: TextStyle(color: AppColors.textBlack,fontSize: normalFont,fontWeight: FontWeight.w500),),
            onClick: ()async{
              var selectedTime =  await showOmniDateTimePicker(
              context: context,
              initialDate: getInitialDate(),
              firstDate: DateTime(1600).subtract(const Duration(days: 10000)),
              lastDate: DateTime.now().add(
                const Duration(days: 10000),
              ),
              is24HourMode: false,
              isShowSeconds: false,
              minutesInterval: 1,
              secondsInterval: 1,
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              constraints: const BoxConstraints(
                maxWidth: 350,
                maxHeight: 650,
              ),
              transitionBuilder: (context, anim1, anim2, child) {
                return FadeTransition(
                  opacity: anim1.drive(
                    Tween(
                      begin: 0,
                      end: 1,
                    ),
                  ),
                  child: child,
                );
              },
              transitionDuration: const Duration(milliseconds: 200),
              barrierDismissible: true,
              selectableDayPredicate: (dateTime) {
                if (dateTime.weekday == DateTime.saturday || dateTime.weekday == DateTime.sunday) {
                  return false;
                } else {
                  return true;
                }
              }

              );




              setState(() {
                selectedDeliveryDateTime = DateFormat("dd/MM/yyyy HH'h'mm ").format(selectedTime!);
              });

            },
            isOpen: false,
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
                    child: Text("${paymentMethod ?? "Méthode de paiement"}",
                        overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.right,
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
                    return SelectPaymentMethod(callback: getPaymentMethod,);
                  },
                );
              }
          ),

          Divider(color: Colors.grey.shade200,),
          ListbottomSheet(
            title: "Total H.T.",
            subtitle: Text("${subTotal.toStringAsFixed(2)}€",style: TextStyle(color: AppColors.textBlack,fontSize: normalFont,fontWeight: FontWeight.w500),),
            onClick: (){},
            isOpen: false,
          ),


          Divider(color: Colors.grey.shade200,),
          ListbottomSheet( ///TODO: if you want to add dynamic text by back office you car change it
            title: "Frais de livraison",
            subtitle: Text("${deliveryFee == 0.00 ? "Livraison gratuite" : "${deliveryFee}€"}",style: TextStyle(color: deliveryFee == 0.00 ? Colors.green : AppColors.textBlack, fontSize: normalFont,fontWeight: FontWeight.w500),),
            onClick: (){},
            isOpen: false,
          ),
          Text("Livraison gratuite à partir de 60€",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.black,
              fontSize: 11,
              fontStyle: FontStyle.italic
            ),
          ),
          Divider(color: Colors.grey.shade200,),
          ListbottomSheet( ///TODO: if you want to add dynamic text by back office you car change it
            title: "Total TVA",
            subtitle: Text("${totalTVAamount.toStringAsFixed(2)}€",style: TextStyle(color: AppColors.textBlack,fontSize: normalFont,fontWeight: FontWeight.w500),),
            onClick: (){},
            isOpen: false,
          ),
          Divider(color: Colors.grey.shade200,),
          ListbottomSheet(
            title: "Total TTC.",
            subtitle: Text("${(totalPrice + deliveryFee).toStringAsFixed(2)}€",style: TextStyle(color: AppColors.textBlack,fontSize: normalFont,fontWeight: FontWeight.w500),),
            onClick: (){},
            isOpen: false,
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
                          "tax" : double.parse("${widget.productList[i].tax.toString()}").toStringAsFixed(2)
                        });
                      }
                      
                      
                      Map<String, dynamic> orders = {
                        "id" : id.toString(),
                        "products" : orderProducts,
                        "create_by" : FirebaseAuth.instance.currentUser!.email.toString(),
                        "create_at" : DateFormat("dd-MM-yyyy HH'h'mm").format(DateTime.now()),
                        "order_status" : orderStatus[0],
                        "address" : _selectedAddress!.toJson(),
                        "sub_total" : subTotal.toStringAsFixed(2),
                        "tax" : totalTVA.toStringAsFixed(2),
                        "tax_amount" : totalTVAamount.toStringAsFixed(2),
                        "delivery_date" : selectedDeliveryDateTime.toString(),
                        "total" : (totalPrice).toStringAsFixed(2),
                        "delivery_fee" : deliveryFee.toStringAsFixed(2),
                        "payment_method" : "$paymentMethod", ///TODO: payment method need to make it dynamic
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

  //get payment method
  var paymentMethod;
  getPaymentMethod(data){
    setState(() {
      paymentMethod = data;
    });
  }
}
