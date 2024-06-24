import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nectar/model/product_model.dart';
import 'package:nectar/view/detail_screen/detail_screen.dart';
import 'package:nectar/widget/app_network_images.dart';

import '../../../utility/app_color.dart';
import '../../../utility/assets.dart';
import '../../../utility/fontsize.dart';
class ItemCard extends StatelessWidget {
  final ProductModel? productModel;
  const ItemCard({super.key, this.productModel,});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>DetailScreen(productModel: productModel!,), settings: RouteSettings(name: "${productModel!.name!.replaceAll(" ", "-")}")) ),

      child: Container(
        margin: EdgeInsets.only(right: 10),
        padding: EdgeInsets.all(10),
        width: size.width*.40,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade100),
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.shade50,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              spreadRadius: .3,
              blurRadius: 0.5,
              offset: Offset(0, 1)
            )
          ]
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///Edit offer banner
              // productModel!.discountPrice! != "0" ? Align(
              //   alignment: Alignment.centerRight,
              //   child: Container(
              //     alignment: Alignment.centerRight,
              //     width: 60,
              //     height: 20,
              //     decoration: BoxDecoration(
              //         color: Colors.red,
              //         borderRadius: BorderRadius.circular(100)
              //     ),
              //     child: Center(child: Text("\$${productModel!.discountPrice!} OFF",
              //       style: TextStyle(
              //         fontWeight: FontWeight.normal,
              //         fontSize: 10, color: Colors.white
              //       )
              //     ),),
              //   ),
              // ) : SizedBox(height: 20,),
              ///Edit Text Top position
              Stack(
                children: [
                  AppNetworkImage(src: productModel!.images![0].toString(),height:100,width:double.infinity,fit: BoxFit.cover,),
                  Positioned(
                    bottom: 5,
                      right: 5,
                      child: InkWell(
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color:Colors.white ,
                      ),
                      child: Center(child: Icon(Icons.add,color: AppColors.bgGreen,)),
                    ),
                  ))
                ],
              ),
              SizedBox(height: 20,),
              Text("${productModel!.name.toString()}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: normalFont,
                    color: Colors.black),
              ),
              SizedBox(height: 10,),
              Text("${productModel!.categoryS!.categoryName}",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: smallFont,
                    color: Colors.black),
              ),

              SizedBox(height: 5,),
              double.parse(productModel!.regularPrice!) > double.parse(productModel!.sellingPrice!) ? Text("\$${productModel!.regularPrice}",
                style: TextStyle(
                    decoration: TextDecoration.lineThrough,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.red),
              ) : Center(),

              Text("\$${productModel!.sellingPrice}",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),

            ],
          ),
        ),
      ),
    );
  }
}