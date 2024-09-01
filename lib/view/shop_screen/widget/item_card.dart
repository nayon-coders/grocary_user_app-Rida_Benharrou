import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nectar/controller/auth_controller.dart';
import 'package:nectar/model/product_model.dart';
import 'package:nectar/view/detail_screen/detail_screen.dart';
import 'package:nectar/widget/app_network_images.dart';

import '../../../utility/app_color.dart';
import '../../../utility/app_const.dart';
import '../../../utility/assets.dart';
import '../../../utility/fontsize.dart';
class ItemCard extends StatefulWidget {
  final ProductModel? productModel;
  const ItemCard({super.key, this.productModel,});

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {

  var role;
  getUserRol()async{
    var data = await AuthController.accountRole();
    setState(() {
      role = data;
    });
    calculate();

  }
  double productPriceInKg = 0.00;
  var productPrice, productTypeNameInKg ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getUserRol();


  }

  void calculate()async{
    if(role == sellerAccount){
      productPrice = widget.productModel?.sellingPrice;
    }else if( role == restaurantAccount){
      productPrice = widget.productModel?.regularPrice;
    }else if(role == wholeSellerAccount){
      productPrice = widget.productModel?.wholePrice;
    }else{
      productPrice = 0.00;
    }

    var productType = widget.productModel!.productType;
    //looping to find the product type
    for(var i = 0; i < unitList.length; i++){

      if(productType == "KG (€ / Kg)"){
        var inG = 1000;
        var totalGram = double.parse(widget.productModel!.unit.toString()) * inG;
        var oneGramPrice = double.parse(productPrice) /double.parse(totalGram.toString()) ;
        productPriceInKg = oneGramPrice * inG;
        productTypeNameInKg = unitList[i]["kgName"];
        break;
      }else if(productType == "U (€ / U)" && unitList[i]["name"] == productType){
        productPriceInKg = double.parse(productPrice) /double.parse(widget.productModel!.unit.toString());
        productTypeNameInKg = unitList[i]["kgName"];
        break;
      }else if(unitList[i]["name"] == productType){
        productPriceInKg = (double.parse(productPrice) / double.parse(widget.productModel!.unit.toString())) * unitList[i]["inKg"];
        productTypeNameInKg = unitList[i]["kgName"];
        break;
      }else{
        productPriceInKg = double.parse(productPrice.toString());
        productTypeNameInKg = widget.productModel!.productType;
      }
    }
    setState(() {

    });
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>DetailScreen(productModel: widget.productModel!,), settings: RouteSettings(name: "${widget.productModel!.name!.replaceAll(" ", "-")}")) ),

      child: Container(
        margin: EdgeInsets.only(right: 5),
        width: size.width*.35,
        decoration: BoxDecoration(
         // border: Border.all(color: Colors.grey.shade100),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,

        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///Edit offer banner

              ///Edit Text Top position
              Container(
                //height: 140,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100
                ),
               // padding: EdgeInsets.all(10),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AppNetworkImage(src: widget.productModel!.images![0].toString(),height:100,width:double.infinity,fit: BoxFit.contain,),
                    ),
                    Positioned(
                      bottom: 5,
                        right: 5,
                        child: InkWell(
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color:Colors.white ,
                          boxShadow:[
                            BoxShadow(
                              color: Colors.grey.shade200,
                              offset: Offset(1,1),
                              blurRadius: 1,
                              spreadRadius: 1
                            )
                          ]
                        ),
                        child: Center(child: Icon(Icons.add,color: AppColors.bgGreen,)),
                      ),
                    )),
                    widget.productModel!.discountPrice!.isNotEmpty && widget.productModel!.discountPrice != "0" ? Positioned(
                      right: 0,
                      top: 5,
                      child: Container(
                        alignment: Alignment.centerRight,
                        width: 60,
                        height: 20,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(100),
                              bottomLeft: Radius.circular(100)
                            )
                        ),
                        child: Center(child: Text("\$${widget.productModel!.discountPrice!} OFF",
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 10, color: Colors.white
                            )
                        ),),
                      ),
                    ) : Center(),
                  ],
                ),
              ),
              SizedBox(height: 5,),
             Padding(
               padding: const EdgeInsets.only(left: 8, right: 8),
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.start,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text("${
                       role == "Seller"
                           ? widget.productModel!.sellingPrice
                           : role == "Restaurant"
                           ? widget.productModel!.regularPrice
                           : widget.productModel!.wholePrice} €",
                     style: const TextStyle(
                         fontSize: 15,
                         fontWeight: FontWeight.w700,
                         color: Colors.pink),
                   ),
                   Text("${widget.productModel!.name.toString()}",
                     maxLines: 1,
                     overflow: TextOverflow.ellipsis,
                     softWrap: false,
                     style: TextStyle(
                         fontWeight: FontWeight.w300,
                         fontSize: 13,
                         color: Colors.black),
                   ),
                   Text("${productPriceInKg.toStringAsFixed(2)} € / 1 ${productTypeNameInKg}",
                     style: TextStyle(
                         fontWeight: FontWeight.w200,
                         fontSize: 10,
                         color: Colors.black),
                   ),
                 ],
               ),
             )


            ],
          ),
        ),
      ),
    );
  }
}