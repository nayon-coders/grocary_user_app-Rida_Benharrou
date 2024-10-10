import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/product_controller.dart';
import '../../../model/product_model.dart';
import '../../../utility/fontsize.dart';
import '../../../widget/app_shimmer.dart';
import '../../shop_screen/widget/item_card.dart';
import '../controller/car_controller.dart';

class RecomandationProducts extends GetView<CartControllerNew> {
  const RecomandationProducts({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getRecomandationProduct();
    });
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Recommandations",style: TextStyle(fontSize:titleFont,fontWeight: FontWeight.w600,color: Colors.black),),

        SizedBox(height: 10,),
        Obx(() {
            return SizedBox(
              height: 200,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: controller.recomandationProduct!.length,

                itemBuilder: (context, index) {
                  var data = controller.recomandationProduct![index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: ItemCard(
                      singleProduct: data,
                    ),
                  );
                },
              ),
            );
          }
        )

      ],
    );
  }
}
