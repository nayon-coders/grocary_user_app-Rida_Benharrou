import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nectar/data/global/global_controller.dart';
import 'package:nectar/routes/app_routes.dart';
import 'package:nectar/utility/fontsize.dart';
import 'package:nectar/view/shop_screen/controller/home_controller.dart';
import 'package:nectar/view/shop_screen/widget/categoreis.dart';
import 'package:nectar/view/shop_screen/widget/item_card.dart';
import 'package:nectar/widget/show_hint_widgets.dart';

import '../../utility/app_color.dart';
import '../../widget/app_shimmer.dart';
import '../show_product/all_products.dart';

class Home extends GetView<HomeController> {

  const Home({super.key});

  @override
  Widget build(BuildContext context) {

    var globalController = Get.put(GlobalController());



    return SafeArea(child: Scaffold(

      backgroundColor: AppColors.bgWhite,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ShowHint(

                    hintText: "Ajoutez votre lieu de livraison maintenant.",
                    child:  InkWell(
                      onTap: ()=>Get.toNamed(AppRoutes.addressList),

                      child: Row(
                        children: [
                          Text("Mes adresses de livraison",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.pink,
                              fontSize: smallFont,
                            ),
                          ),
                          const SizedBox(width: 5,),
                          const Icon(Icons.keyboard_arrow_down,color: Colors.pink,),
                        ],
                      ),
                    ),
                ),
              ],
            ),

            const SizedBox(height: 15,),
            //single category product
            Container(
              height: 280,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.pink.shade50
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Produits",style: TextStyle(fontSize:titleFont,fontWeight: FontWeight.w600,color: Colors.black),),
                      InkWell(
                          onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> AllProducts(title: "Nos produits", products: controller.productList.value,))),
                          child: Container(
                              padding: const EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 8,),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(100)
                              ),
                              child: const Text("Voir tout",style: TextStyle(fontSize:13,fontWeight: FontWeight.w500,color:AppColors.bgGreen),))),

                    ],
                  ),
                  const SizedBox(height: 10,),
                  Obx(() {
                        if(controller.isLoading.value){
                          return SizedBox(
                            height: 200,
                            child: ListView.builder(
                                shrinkWrap: true,
                                padding: const EdgeInsets.only(right: 10),
                                itemCount: 5,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context,index){
                                  return const AppShimmer();
                                }),
                          );
                        }else{
                          return SizedBox(
                            height: 200,
                            child: Obx(() {
                                return ListView.builder(
                                    padding: const EdgeInsets.only(right: 10),
                                    itemCount: controller.productList.length > 12 ? 11 : controller.productList.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context,index){
                                      var data = controller.productList[index];
                                      return index == 10 ? InkWell(
                                        onTap: ()=>Get.to(AllProducts(title: "Nos produits", products: controller.productList.value,)),
                                        child: Container(
                                          width: Get.width*.35,
                                          height: 100,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(10)
                                          ),
                                          child: const Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Icon(Icons.arrow_forward_ios_rounded,color: Colors.pink,),
                                              Text("Voir plus",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: Colors.pink),)
                                            ],
                                          )
                                        ),
                                      ) :  ItemCard(singleProduct: data);
                                    });
                              }
                            ),
                          );
                        }

                      }
                  ),
                ],
              ),
            ),
            // SizedBox(height: 15,),
            // //offer products
            // NewProducts(),
            // SizedBox(height: 15,),
            // //offer products
            // OfferProducts(),


           // NewItems(),
            const SizedBox(height: 15,),
            //Categoreis()
            SubCategoreis(),

          ],
        ),
      ),
    ));
  }
}


