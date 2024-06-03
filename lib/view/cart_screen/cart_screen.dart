import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nectar/controller/cart_controller.dart';
import 'package:nectar/model/product_model.dart';
import 'package:nectar/utility/fontsize.dart';
import 'package:nectar/view/cart_screen/widget/bottomsheet_list.dart';
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

  List<ProductModel> productModel = [];

  Future<List<ProductModel>>? carFuture;

  Future getCartFuture()async{
    carFuture = CartController.getCartProduct();
  }

  getCartItems(){
    FirebaseFirestore.instance.collection(cartCollection).where("email", isEqualTo: FirebaseAuth.instance.currentUser!.email).get().then((value) {
      for(var i in value.docs){
        if(i.exists){
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


            return snapshot.data!.isNotEmpty ? Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                      itemBuilder: (context,index){
                      var data = snapshot.data![index];
                      productModel.add(data);
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
                                  Text("${data.productType}, Prix",
                                    style: TextStyle(fontSize: smallFont,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.textGrey),
                                  ),
                                ],
                              ),

                              InkWell(
                                  onTap:(){},
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
                               Text("\$${role != null ? role == "Customer" ? double.parse(data.regularPrice!) * qty[index] : role == "Seller" ? double.parse(data.sellingPrice!) * qty[index] : double.parse(data.wholePrice!) * qty[index] : 00}",style: TextStyle(fontSize: normalFont,fontWeight: FontWeight.w600,color: Colors.black),)
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
                      print("qty ---- $qty");
                      showModalBottomSheet(context: context, builder:(BuildContext context){
                        return Container(
                          padding: EdgeInsets.all(10),
                          height: 600,
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
                                onClick: (){},
                              ),
                              Divider(color: Colors.grey.shade200,),
                              ListbottomSheet(
                                title: "Paiement",
                                subtitle: Icon(Icons.credit_card,color: Colors.orange,),
                                onClick: (){},
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
                              SizedBox(height: 30,),
                              SizedBox(
                                width:200,
                                child: RichText(text: TextSpan(
                                  text: "En passant une commande, vous acceptez notre  ",
                                  style: TextStyle(fontSize:smallFont,color: AppColors.textGrey),
                                  children: [
                                    TextSpan(
                                      text: " Termes ",
                                      style: TextStyle(
                                          fontSize: smallFont,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                      ),
                                    ),
                                    TextSpan(
                                      text: " Et ",
                                      style: TextStyle(
                                          fontSize: smallFont,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.textGrey,
                                      ),
                                    ),
                                    TextSpan(
                                      text: " Conditions",
                                      style: TextStyle(
                                          fontSize: smallFont,
                                          fontWeight: FontWeight.w500,
                                          color:Colors.black,
                                      ),
                                    ),
                                  ]
                                )),
                              ),
                              Spacer(),
                              Center(
                                child: SizedBox(
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


