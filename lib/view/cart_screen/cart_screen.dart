import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nectar/controller/cart_controller.dart';
import 'package:nectar/model/product_model.dart';
import 'package:nectar/utility/fontsize.dart';
import 'package:nectar/view/cart_screen/widget/bottomsheet_list.dart';
import 'package:nectar/view/cart_screen/widget/order_popup.dart';
import 'package:nectar/view/cart_screen/widget/recomandation_products.dart';
import 'package:nectar/view/order_accepted/order_accepted.dart';
import 'package:nectar/widget/app_button.dart';
import 'package:nectar/widget/app_network_images.dart';

import '../../controller/auth_controller.dart';
import '../../utility/app_color.dart';
import '../../utility/app_const.dart';
import '../../utility/assets.dart';
import '../../widget/not_found.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int _initial = 1;

  List qty = [];


  double totalPrice = 0;
  List<double> itemPrice = [];

  List<ProductModel> productModel = [];
  List<String> _cartProductId = [];

  Future<List<ProductModel>>? carFuture;

  Future getCartFuture()async{
    carFuture = CartController.getCartProduct();
    getCartItems();
  }

  getCartItems(){
    _cartProductId.clear();
    qty.clear();
    FirebaseFirestore.instance.collection(cartCollection).where("email", isEqualTo: FirebaseAuth.instance.currentUser!.email).get().then((value) {
      for(var i in value.docs){
        if(i.exists){
          setState(() {
            _cartProductId.add(i.id);
            qty.add(int.parse("${i.data()["qty"]}"));
          });
          print("_cartProductId --------- id --- ${_cartProductId}");

        }
      }
    });
    setState(() {

    });
  }

  String? role;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCartFuture();
    AuthController.accountRole().then((value) => setState(()=> role = value ));

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      //backgroundColor: AppColors.bgWhite,
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   elevation: 0,
      //   backgroundColor: AppColors.bgWhite,
      //   title: Text("Mon panier",
      //     style: TextStyle(
      //         fontSize: titleFont,
      //         fontWeight: FontWeight.w600,
      //         color: AppColors.textBlack,
      //     ),
      //   ),
      //   centerTitle: false,
      // ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            RecomandationProducts(),

            SizedBox(height: 0,),
            Divider(height: 1,),
            SizedBox(height: 10,),

            Text("Mon panier",
              style: TextStyle(
                fontSize: titleFont,
                fontWeight: FontWeight.w600,
                color: AppColors.textBlack,
              ),
            ),
            SizedBox(height: 10,),
            FutureBuilder(
              future: carFuture,
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator(),);
                }


                productModel.clear();

                for(var i in snapshot!.data!){
                  productModel.add(i);
                }



                return snapshot.data!.isNotEmpty ? ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.length,
                    itemBuilder: (context,index){
                    var data = snapshot.data![index];

                    totalPrice = 0.0;




                    //totalPrice = 0.0;
                    if(role != null && role == restaurantAccount){
                      itemPrice.add(double.parse(data.regularPrice!));
                      //totalPriceGet(double.parse(data.regularPrice!), double.parse("${data.tax}"));
                    }else if( role == sellerAccount){
                      itemPrice.add(double.parse(data.sellingPrice!));

                    }else{
                      itemPrice.add(double.parse(data.wholePrice!));

                    }

                    return ListTile(
                    shape: Border(bottom:  BorderSide(color:Colors.grey.shade200)),
                    contentPadding: EdgeInsets.only(bottom: 5),
                    leading: Container(
                        width: 70, height:80,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: AppNetworkImage(src: data.images![0], width: 60, height:60,)),
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width*.50,
                          child: Text("${itemPrice[index]}€ ",style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color:AppColors.textBlack,
                          ),
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${data.name}",
                                  style: TextStyle(fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                ),
                                Text("${itemPrice[index]}€ / ${data.productType}",
                                  style: TextStyle(fontSize: 10,
                                      fontWeight: FontWeight.w100,
                                      color: Colors.black),
                                ),

                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: ()async{
                                        setState((){
                                            qty[index]--;
                                        });
                                        if(qty[index] == 0){
                                          print("_cartProductId  ==== ${_cartProductId[index]}");
                                          await CartController.removeFromCart(context, _cartProductId[index]);
                                          getCartFuture();
                                          setState(() {

                                          });
                                        }
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(3),
                                        decoration: BoxDecoration(
                                          border: Border.all(width: 1, color: Colors.grey.shade200),
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(5),
                                            topLeft: Radius.circular(5),
                                          ),
                                          color: AppColors.bgWhite,
                                        ),
                                        child: Center(
                                          child: Icon(Icons.remove,size: 20, color: AppColors.mainColor,),
                                        ),
                                      ),
                                    ),
                                    Container(
                                        width: 25,
                                        height: 27,
                                        decoration: BoxDecoration(
                                          border: Border.all(width: 1, color: AppColors.mainColor),
                                          color: AppColors.mainColor,
                                        ),
                                        child: Center(child: Text("${qty[index]}",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15,color: Colors.white),))),


                                    InkWell(
                                      onTap: (){
                                        setState(() {
                                          qty[index]++;
                                        });
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(3),
                                        decoration: BoxDecoration(
                                          border: Border.all(width: 1, color: Colors.grey.shade200),
                                          borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(5),
                                            topRight: Radius.circular(5),
                                          ),
                                          color: AppColors.bgWhite,
                                        ),
                                        child: Center(
                                          child: Icon(Icons.add,size: 20, color: AppColors.mainColor,),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        )



                        ///TODO: Remove this block if need to show the tax
                        // Text("TVA: ${double.parse("${data.tax}")}%",
                        //   style: TextStyle(fontSize: 10,
                        //       fontWeight: FontWeight.w100,
                        //       color: Colors.black),
                        // ),
                      ],
                    ),
                    // title: Column(
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       crossAxisAlignment: CrossAxisAlignment.center,
                    //       children: [
                    //         Column(
                    //           mainAxisAlignment: MainAxisAlignment.start,
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             SizedBox(
                    //               width: MediaQuery.of(context).size.width*.50,
                    //               child: Text("${itemPrice[index]}€ ",style: TextStyle(
                    //                 fontSize: 17,
                    //                 fontWeight: FontWeight.w600,
                    //                 color:AppColors.textBlack,
                    //               ),
                    //               ),
                    //             ),
                    //
                    //             Row(
                    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //               children: [
                    //                 Column(
                    //                   children: [
                    //                     Text("${data.name}",
                    //                       style: TextStyle(fontSize: 12,
                    //                           fontWeight: FontWeight.w200,
                    //                           color: Colors.black),
                    //                     ),
                    //                     Text("${itemPrice[index]}€ / ${data.productType}",
                    //                       style: TextStyle(fontSize: 10,
                    //                           fontWeight: FontWeight.w100,
                    //                           color: Colors.black),
                    //                     ),
                    //
                    //                   ],
                    //                 ),
                    //                 Row(
                    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //                   crossAxisAlignment: CrossAxisAlignment.center,
                    //                   children: [
                    //                     Row(
                    //                       mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //                       crossAxisAlignment: CrossAxisAlignment.center,
                    //                       children: [
                    //                         InkWell(
                    //                           onTap: (){
                    //                             setState(() {
                    //                               if(qty[index] > 1){
                    //                                 qty[index]--;
                    //                               }
                    //                             });
                    //                           },
                    //                           child: Container(
                    //                             padding: EdgeInsets.all(3),
                    //                             decoration: BoxDecoration(
                    //                               border: Border.all(width: 1, color: Colors.grey.shade200),
                    //                               borderRadius: BorderRadius.only(
                    //                                 bottomLeft: Radius.circular(5),
                    //                                 topLeft: Radius.circular(5),
                    //                               ),
                    //                               color: AppColors.bgWhite,
                    //                             ),
                    //                             child: Center(
                    //                               child: Icon(Icons.remove,size: 20, color: AppColors.mainColor,),
                    //                             ),
                    //                           ),
                    //                         ),
                    //                         Container(
                    //                           width: 25,
                    //                           height: 27,
                    //                           decoration: BoxDecoration(
                    //                             border: Border.all(width: 1, color: AppColors.mainColor),
                    //                             color: AppColors.mainColor,
                    //                           ),
                    //                             child: Center(child: Text("${qty[index]}",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15,color: Colors.white),))),
                    //
                    //
                    //                         InkWell(
                    //                           onTap: (){
                    //                             setState(() {
                    //                               qty[index]++;
                    //                             });
                    //                           },
                    //                           child: Container(
                    //                             padding: EdgeInsets.all(3),
                    //                             decoration: BoxDecoration(
                    //                               border: Border.all(width: 1, color: Colors.grey.shade200),
                    //                               borderRadius: BorderRadius.only(
                    //                                 bottomRight: Radius.circular(5),
                    //                                 topRight: Radius.circular(5),
                    //                               ),
                    //                               color: AppColors.bgWhite,
                    //                             ),
                    //                             child: Center(
                    //                               child: Icon(Icons.add,size: 20, color: AppColors.mainColor,),
                    //                             ),
                    //                           ),
                    //                         ),
                    //                       ],
                    //                     ),
                    //                   ],
                    //                 )
                    //               ],
                    //             )
                    //
                    //
                    //
                    //             ///TODO: Remove this block if need to show the tax
                    //             // Text("TVA: ${double.parse("${data.tax}")}%",
                    //             //   style: TextStyle(fontSize: 10,
                    //             //       fontWeight: FontWeight.w100,
                    //             //       color: Colors.black),
                    //             // ),
                    //           ],
                    //         ),
                    //
                    //
                    //         ///TODO: if need to show the closs button then uncomment this block
                    //         // InkWell(
                    //         //     onTap:()async{
                    //               print("_cartProductId  ==== ${_cartProductId[index]}");
                    //              await CartController.removeFromCart(context, _cartProductId[index]);
                    //               getCartFuture();
                    //
                    //               setState(() {
                    //
                    //               });
                    //         //     },
                    //         //     child: Icon(Icons.close,color: AppColors.textGrey,))
                    //       ],
                    //     ),
                    //   ],
                    // ),
                  );
                }) : NotFound() ;
              }
            ),

          ],
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: (){
          showModalBottomSheet(context: context, builder:(BuildContext context){
            return OrderPopup(
                docId: _cartProductId,
                productList: productModel,
                qty: qty,
                totalPrice: itemPrice
            );
          });
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          decoration: BoxDecoration(
            color: AppColors.mainColor,
            borderRadius: BorderRadius.circular(5)
          ),
          padding: const EdgeInsets.only(left: 20.0,right: 20.0),
          margin: const EdgeInsets.only(left: 10.0,right: 10.0, bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add_shopping_cart, size: 20, color: Colors.white,),
              SizedBox(width: 10,),
              Text("Passer la commande",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.white
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }


  totalPriceGet(tax, itemPrice){
    for(var i =0; i < qty.length; i++){
        totalPrice = totalPrice + (itemPrice * qty[i]) + (totalPrice * qty[i]) / 100 * double.parse("${tax}");
    }


  }


}


