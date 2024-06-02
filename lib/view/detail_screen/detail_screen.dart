import 'package:flutter/material.dart';
import 'package:nectar/model/product_model.dart';
import 'package:nectar/utility/assets.dart';
import 'package:nectar/utility/fontsize.dart';

import '../../utility/app_color.dart';
import '../../widget/app_button.dart';
import '../../widget/app_network_images.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.productModel,});

  final ProductModel productModel;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int _initial = 1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(child:Scaffold(
      backgroundColor:AppColors.bgWhite,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                widget.productModel!.discountPrice! != "0" ? Positioned(
                  right: 10, top: 10,
                  child: Container(
                    width: 80,
                    height: 30,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(100)
                    ),
                    child: Center(child: Text("\$${widget.productModel!.discountPrice!} OFF",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 13, color: Colors.white
                        )
                    ),),
                  ),
                ) : Center(),
                Container(
                  height: MediaQuery.of(context).size.height*0.40,
                  width: double.infinity,
                  padding: EdgeInsets.all(50),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)
                    ),
                  ),
                  child: AppNetworkImage(src: widget.productModel.images![0], fit: BoxFit.contain, height:  MediaQuery.of(context).size.height*0.35
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                        onTap:(){
                          Navigator.pop(context);
                        },
                        child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.black
                            ),
                            child: Center(child: Icon(Icons.keyboard_arrow_left,color: Colors.white,)))),
                  ],

                ),)
                
              ],
            ),
            ///TODO:Product name
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width-100,
                  child: Text("${widget.productModel!.name.toString()}",
                    style: TextStyle(
                        fontSize: titleFont,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                ),
                Icon(Icons.favorite_border,color: AppColors.textGrey,),
              ],
            ),
            SizedBox(height: 5,),
            SizedBox(
              width: MediaQuery.of(context).size.width-100,
              child: Text("${widget.productModel!.categoryS!.categoryName.toString()}",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: smallFont,
                    color: AppColors.textGrey,
                ),
              ),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 150,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap:(){
                          setState(() {
                            if(_initial > 1){
                              _initial--;
                            }
                          });
                        },
                          child:  Container(
                              width: 40, height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.black,
                                border: Border.all(color:Colors.black,width: .9),
                              ),
                              child: Icon(Icons.remove,color: Colors.white,))),
                      SizedBox(width: 10,),
                      Container(
                        width: 40, height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.textGrey,width: .9),
                        ),
                        child: Center(
                          child: Text("${_initial}",style: TextStyle(fontSize: titleFont,color: Colors.black,fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      InkWell(
                         onTap: (){
                           setState(() {
                             _initial++;
                           });
                         },
                          child:  Container(
                              width: 40, height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.black,
                                border: Border.all(color:Colors.black,width: .9),
                              ),
                              child: Icon(Icons.add,color: Colors.white,))),

                
                    ],
                  ),
                ),
                Column(
                  children: [

                    Text("\$${double.parse(widget.productModel!.sellingPrice!) * double.parse(_initial.toString()) }",style: TextStyle(fontWeight: FontWeight.w600,fontSize: titleFont,color: Colors.black),),
                  ],
                )

              ],
            ),
            SizedBox(height: 10,),
            Text("${widget.productModel.productType}",
              style: TextStyle(
                  fontSize: 12, fontWeight: FontWeight.w600, color: Colors.grey
              ),
            ),
            SizedBox(height: 20,),
            Text("Détails du produit",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontSize: 14,
              ),
            ),
            Text("${widget.productModel.shortDescription}",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.black,
                fontSize: 12,
              ),
            ),

            SizedBox(height: 15,),
            ExpansionTile(
                title:Text("Détails du produit"),
              children: [
                Text("${widget.productModel.longDescription!}")
              ],
            ),
            /// TODO:Product price
                
            ///TODO:product quantity and buy button
                
                
            /// TODO:payment method
          ],
        ),
      ),
      bottomNavigationBar:Padding(
        padding: const EdgeInsets.only(left: 40.0, right: 40, bottom: 20, top: 10),
        child: AppButton(
          bgColor: AppColors.bgGreen,
          name: "Ajouter au panier",
          onClick: (){

          },
        ),
      ),
    ));
  }
}
