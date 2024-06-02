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
          color: Colors.white,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              productModel!.discountPrice! != "0" ? Align(
                alignment: Alignment.centerRight,
                child: Container(
                  alignment: Alignment.centerRight,
                  width: 60,
                  height: 20,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(100)
                  ),
                  child: Center(child: Text("\$${productModel!.discountPrice!} OFF",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 10, color: Colors.white
                    )
                  ),),
                ),
              ) : SizedBox(height: 20,),
              AppNetworkImage(src: productModel!.images![0].toString(),height:100,width:double.infinity,fit: BoxFit.contain,),
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

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("\$${productModel!.sellingPrice}",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                  InkWell(
                    child: Container(
                      height: 40,
                      width: 40,
                      padding: EdgeInsets.only(left: 5,right: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.bgGreen,
                      ),
                      child: Center(child: Icon(Icons.add,color: Colors.white,)),
                    ),
                  )

                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}