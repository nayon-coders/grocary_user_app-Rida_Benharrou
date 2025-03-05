
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nectar/view/account_screen/controller/address_controller.dart';
import 'package:nectar/view/cart_screen/widget/selecte_delivery_address.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import '../../../data/models/delivery_address_model.dart';
import '../../../utility/app_color.dart';
import '../../../utility/fontsize.dart';
import '../../../widget/app_button.dart';
import '../controller/car_controller.dart';
import '../controller/order_controller.dart';
import 'bottomsheet_list.dart';

class OrderPopup extends StatefulWidget {

  final List qty;
  final List<double> totalPrice;
  const OrderPopup({super.key,required this.qty, required this.totalPrice});

  @override
  State<OrderPopup> createState() => _OrderPopupState();
}

class _OrderPopupState extends State<OrderPopup> {


  //cart controller init
   CartControllerNew _cartController = Get.find();
   AddressControllerNew addressControllerNew = Get.find();
   OrderControllerNew orderController = Get.find();



  double deliveryFeeMinmum = 66.00;
  double deliveryFee = 0.00;
  bool _deliveryAddressAlert = false;

  DateTime getInitialDate() {
    DateTime initialDate = DateTime.now().add(const Duration(days: 10));
    while (initialDate.weekday == DateTime.saturday || initialDate.weekday == DateTime.sunday) {
      if(initialDate.weekday == DateTime.friday){
        setState(() {
          initialDate = initialDate.add(const Duration(days: 3));
        });
      }else if(initialDate.weekday == DateTime.saturday){
        setState(() {
          initialDate = initialDate.add(const Duration(days: 2));
        });
      }else{
        setState(() {
          initialDate = initialDate.add(const Duration(days: 1));
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

    if(_cartController.totalPrice < 61){
      deliveryFee = 15.00;
    }else{
      deliveryFee = 0.00;
    }

    //get init address
    setState(() {
      _selectedAddress = addressControllerNew.address.value.data != null ? addressControllerNew.address.value.data!.first : null;
    });

    //init date
    selectedDeliveryDateTime = DateFormat("dd/MM/yyyy").format(DateTime.now().add(Duration(days: 1)));


    //init payment method
    paymentMethod = "Virement";
  }

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 500,
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
                child: const Icon(Icons.close,color: Colors.black,)),
          ),
          Divider(color: Colors.grey.shade200,),
          Container(
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: _deliveryAddressAlert ? Colors.red : Colors.transparent)
            ),
            child: ListbottomSheet(
              title: "Adresse de livraison",
              subtitle: SizedBox(width: MediaQuery.of(context).size.width*.40, child: Text(_selectedAddress != null ? "${_selectedAddress!.postCode}, ${_selectedAddress!.city}, ${_selectedAddress!.address}, ${_selectedAddress!.contact}" : "Ajoutez une adresse",style: TextStyle(color: _deliveryAddressAlert ? Colors.red : Colors.black,fontSize: 15,fontWeight: FontWeight.w500,),)),
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
            onClick: () async {
              var selectedDate = await showDatePicker(
                context: context,
                initialDate: getInitialDate(),
                firstDate: DateTime(1600),
                lastDate: DateTime.now().add(const Duration(days: 10000)),
                locale: const Locale("fr", "FR"), // French Language
                selectableDayPredicate: (dateTime) {
                  return dateTime.weekday != DateTime.saturday &&
                      dateTime.weekday != DateTime.sunday;
                },
              );

              if (selectedDate != null) {
                setState(() {
                  selectedDeliveryDateTime =
                      DateFormat("dd MMMM yyyy").format(selectedDate);
                });
              }
            },

            isOpen: false,
          ),
          // Divider(color: Colors.grey.shade200,),
          // ListbottomSheet(
          //   title: "Méthode de paiement ",
          //   subtitle: SizedBox(
          //     width: MediaQuery.of(context).size.width*.40,
          //     child: Row(
          //       children: [
          //         Icon(Icons.credit_card,color: Colors.orange,),
          //         SizedBox(width: 10,),
          //         SizedBox(
          //           width: MediaQuery.of(context).size.width*.30,
          //           child: Text("${paymentMethod ?? "Méthode de paiement"}",
          //               overflow: TextOverflow.ellipsis,
          //             textAlign: TextAlign.right,
          //             style: TextStyle(
          //               fontSize: 15,
          //               fontWeight: FontWeight.w600
          //             ),
          //           ),
          //         )
          //       ],
          //     ),
          //   ),
          //   onClick: (){
          //        showDialog<void>(
          //         context: context,
          //         barrierDismissible: false, // user must tap button!
          //         builder: (BuildContext context) {
          //           return SelectPaymentMethod(callback: getPaymentMethod,);
          //         },
          //       );
          //     }
          // ),

          Divider(color: Colors.grey.shade200,),
          ListbottomSheet(
            title: "Total H.T.",
            subtitle: Text("${_cartController.totalPrice.toStringAsFixed(2)}€",style: TextStyle(color: AppColors.textBlack,fontSize: normalFont,fontWeight: FontWeight.w500),),
            onClick: (){},
            isOpen: false,
          ),


          Divider(color: Colors.grey.shade200,),
          ListbottomSheet( ///TODO: if you want to add dynamic text by back office you car change it
            title: "Frais de livraison",
            subtitle: Text("${deliveryFee == 0.00 ? "Livraison gratuite" : "${deliveryFee.toStringAsFixed(2)}€"}",
              style: TextStyle(color: deliveryFee == 0.00 ? Colors.green : AppColors.textBlack, fontSize: normalFont,fontWeight: FontWeight.w500),
            ),
            onClick: (){},
            isOpen: false,
          ),
          const Text("Livraison gratuite à partir de 60€ ht",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.black,
              fontSize: 11,
              fontStyle: FontStyle.italic
            ),
          ),
          Divider(color: Colors.grey.shade200,),
          Obx((){
            var productVAT = (_cartController.totalTVAamount - _cartController.totalPrice);
            var deliveryVAT = 3.00; // its statics 20%
            var totalTVA = productVAT;
            if(deliveryFee != 0.00){
              totalTVA = totalTVA + deliveryVAT;
            }
            return ListbottomSheet( ///TODO: if you want to add dynamic text by back office you car change it
                title: "Total TVA",
                subtitle: Text("${(totalTVA).toStringAsFixed(2)}€",style: TextStyle(color: AppColors.textBlack,fontSize: normalFont,fontWeight: FontWeight.w500),),
                onClick: (){},
                isOpen: false,
              );
            }
          ),
          Divider(color: Colors.grey.shade200,),
          ListbottomSheet(
            title: "Total TTC ",
            subtitle: Obx(() {
              var deliveryVAT = 0.00; // its statics 20%
              if(deliveryFee != 0.00){
                deliveryVAT = 3.00;
              }
                return Text("${(_cartController.totalTVAamount + deliveryFee+deliveryVAT).toStringAsFixed(2)}€",style: TextStyle(color: AppColors.textBlack,fontSize: normalFont,fontWeight: FontWeight.w500),);
              }
            ),
            onClick: (){},
            isOpen: false,
          ),
          Divider(color: Colors.grey.shade200,),
          const Spacer(),
          Center(
            child: Container(
              margin: const EdgeInsets.only(bottom: 20),
                width:300,
                child:
                Obx(() {
                    return AppButton(
                        name: "Passer la commande",
                        isLoading: orderController.isPlacingOrder.value,
                        onClick: ()async{
                          if(_selectedAddress == null){
                            Get.snackbar("Désolé!", "Veuillez ajouter une adresse de livraison",backgroundColor: Colors.red,colorText: Colors.white);
                            return;
                          }
                          orderController.placeOrder(selectedDeliveryDateTime, paymentMethod, deliveryFee, _selectedAddress!);

                        });
                  }
                )),
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
