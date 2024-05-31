import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nectar/utility/fontsize.dart';
import 'package:nectar/view/cart_screen/widget/bottomsheet_list.dart';
import 'package:nectar/view/order_accepted/order_accepted.dart';
import 'package:nectar/widget/app_button.dart';

import '../../utility/app_color.dart';
import '../../utility/assets.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int _initial = 0;

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
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 10,
                  itemBuilder: (context,index){
                return ListTile(
                  shape: Border.symmetric(horizontal: BorderSide(color:Colors.grey.shade200)),
                  contentPadding: EdgeInsets.all(10),
                  leading: Image.asset(Assets.potato),
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
                              Text("Pomme de terre",style: TextStyle(
                                  fontSize: titleFont,
                                  fontWeight: FontWeight.w600,
                                  color:AppColors.textBlack,
                              ),
                              ),
                              Text("1 kg, Prix",
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
                                    _initial--;
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
                              Text("${_initial}",style: TextStyle(fontWeight: FontWeight.w600,fontSize: normalFont,color: Colors.black),),
                              SizedBox(width: 10,),
                              InkWell(
                                onTap: (){
                                  setState(() {
                                    _initial++;
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
                          Text("\$4.99",style: TextStyle(fontSize: normalFont,fontWeight: FontWeight.w600,color: Colors.black),)
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
        ),
      )
    ));
  }
}


