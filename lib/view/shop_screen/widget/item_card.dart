import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:nectar/data/global/global_variable.dart';
import 'package:nectar/routes/app_routes.dart';
import 'package:nectar/view/detail_screen/detail_screen.dart';
import 'package:nectar/widget/app_network_images.dart';

import '../../../data/global/global_controller.dart';
import '../../../data/models/product_model.dart';
import '../../../utility/app_color.dart';
class ItemCard extends StatelessWidget {
  SingleProduct singleProduct;
  ItemCard({required this.singleProduct});

  var globalController = Get.put(GlobalController());
  @override
  Widget build(BuildContext context) {

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   // Update your controller or state here
    //   globalController.priceCalculat(singleProduct!.regularPrice, singleProduct.sellingPrice, singleProduct.wholePrice);
    // });

    var size = MediaQuery.of(context).size;

    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailScreen(productId: singleProduct.id.toString(),)));

      },

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
                      child: singleProduct!.images!.isEmpty
                          ? Image.asset("assets/images/empty_error.png",height: 100,width: double.infinity,fit: BoxFit.contain,)
                          : AppNetworkImage(src: singleProduct!.images![0].imageUrl.toString(),height:100,width:double.infinity,fit: BoxFit.contain,),
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
                        child: const Center(child: Icon(Icons.add,color: AppColors.bgGreen,)),
                      ),
                    )),
                    singleProduct!.discountPrice != null && singleProduct!.discountPrice != 0 ? Positioned(
                      right: 0,
                      top: 5,
                      child: Container(
                        alignment: Alignment.centerRight,
                        width: 80,
                        height: 20,
                        decoration: const BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(100),
                              bottomLeft: Radius.circular(100)
                            )
                        ),
                        child: Center(child: Text("Promo - ${singleProduct!.discountPrice.toString()}% ",
                            style: const TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 10, color: Colors.white
                            )
                        ),),
                      ),
                    ) : Center(),
                  ],
                ),
              ),
              const SizedBox(height: 5,),
             Padding(
               padding: const EdgeInsets.only(left: 8, right: 8),
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.start,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Obx(() {
                       return Text("${globalController.priceCalculat(singleProduct.regularPrice, singleProduct.sellingPrice!, singleProduct.wholePrice, singleProduct.supperMarcent).toStringAsFixed(2)} €",
                         style: const TextStyle(
                             fontSize: 15,
                             fontWeight: FontWeight.w700,
                             color: Colors.pink),
                       );
                     }
                   ),
                   Text("${singleProduct!.name.toString()}",
                     maxLines: 1,
                     overflow: TextOverflow.ellipsis,
                     softWrap: false,
                     style: const TextStyle(
                         fontWeight: FontWeight.w300,
                         fontSize: 13,
                         color: Colors.black),
                   ),
                   Text("${(double.parse("${globalController.priceCalculat(singleProduct.regularPrice, singleProduct.sellingPrice!, singleProduct.wholePrice, singleProduct.supperMarcent)}") / double.parse("${singleProduct.uvw}")).toStringAsFixed(2)} € / 1 ${singleProduct.unit!.split(" ")[0]}",
                     style: const TextStyle(
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