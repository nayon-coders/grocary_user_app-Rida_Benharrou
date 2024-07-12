import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nectar/controller/cart_controller.dart';
import 'package:nectar/model/product_model.dart';
import 'package:nectar/utility/fontsize.dart';
import 'package:nectar/view/cart_screen/widget/bottomsheet_list.dart';
import 'package:nectar/view/cart_screen/widget/order_popup.dart';
import 'package:nectar/view/order_accepted/order_accepted.dart';
import 'package:nectar/widget/app_button.dart';
import 'package:nectar/widget/app_network_images.dart';

import '../../controller/auth_controller.dart';
import '../../utility/app_color.dart';
import '../../utility/app_const.dart';
import '../../utility/assets.dart';

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
  }

  getCartItems(){
    FirebaseFirestore.instance.collection(cartCollection).where("email", isEqualTo: FirebaseAuth.instance.currentUser!.email).get().then((value) {
      for(var i in value.docs){
        if(i.exists){
          setState(() {
            _cartProductId.add(i.id);
          });
          qty.add(int.parse("${i.data()["qty"]}"));
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
    getCartItems();
    AuthController.accountRole().then((value) => setState(()=> role = value ));

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      //backgroundColor: AppColors.bgWhite,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: AppColors.bgWhite,
        title: Text("Mon panier",
          style: TextStyle(
              fontSize: titleFont,
              fontWeight: FontWeight.w600,
              color: AppColors.textBlack,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: FutureBuilder(
          future: carFuture,
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),);
            }


            productModel.clear();
            totalPrice = 0.0;

            for(var i in snapshot!.data!){
              productModel.add(i);
            }



            return snapshot.data!.isNotEmpty ? Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                      itemBuilder: (context,index){
                      var data = snapshot.data![index];
                      //totalPrice = 0.0;
                   

                      //totalPrice = 0.0;
                      if(role != null && role == restaurantAccount){
                        itemPrice.add(double.parse(data.regularPrice!));
                      }else if( role == sellerAccount){
                        itemPrice.add(double.parse(data.sellingPrice!));
                      }else{
                        itemPrice.add(double.parse(data.wholePrice!));
                      }

                      return ListTile(
                      shape: Border.symmetric(horizontal: BorderSide(color:Colors.grey.shade200)),
                      contentPadding: EdgeInsets.all(10),
                      leading: AppNetworkImage(src: data.images![0], width: 60, height:60,),
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width*.50,
                                    child: Text("${data.name}",style: TextStyle(
                                        fontSize: titleFont,
                                        fontWeight: FontWeight.w600,
                                        color:AppColors.textBlack,
                                    ),
                                    ),
                                  ),
                                  Text("Prix/${data.productType}",
                                    style: TextStyle(fontSize: smallFont,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.textGrey),
                                  ),
                                ],
                              ),

                              InkWell(
                                  onTap:()async{
                                    await CartController.removeFromCart(context, _cartProductId[index]);
                                    getCartFuture();
                                    setState(() {

                                    });
                                  },
                                  child: Icon(Icons.close,color: AppColors.textGrey,))
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: (){
                                      setState(() {
                                        if(qty[index] > 1){
                                          qty[index]--;
                                        }
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey.shade200),
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColors.bgWhite,
                                      ),
                                      child: Center(
                                        child: Icon(Icons.remove,color: AppColors.textGrey,),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Text("${qty[index]}",style: TextStyle(fontWeight: FontWeight.w600,fontSize: normalFont,color: Colors.black),),
                                  SizedBox(width: 10,),
                                  InkWell(
                                    onTap: (){
                                      setState(() {
                                        qty[index]++;
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey.shade200),
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColors.bgWhite,
                                      ),
                                      child: Center(
                                        child: Icon(Icons.add,color: Colors.green,),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                               Text("\$${(itemPrice[index] * qty[index]).toStringAsFixed(2)}",style: TextStyle(fontSize: normalFont,fontWeight: FontWeight.w600,color: Colors.black),)
                            ],
                          )
                        ],
                      ),
                    );
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0,right: 20.0),
                  child: AppButton(
                    bgColor: AppColors.bgGreen,
                      name: "Aller à la caisse",
                      onClick: (){
                      showModalBottomSheet(context: context, builder:(BuildContext context){
                        return OrderPopup(
                          docId: _cartProductId,
                           productList: productModel,
                          qty: qty,
                          totalPrice: itemPrice
                        );
                      });
                      }
                  ),
                ),
                SizedBox(height: 10,),
              ],
            ) : Center(
              child: Image.asset(Assets.norProduct, width: 200,),
            ) ;
          }
        ),
      )
    ));
  }


}


