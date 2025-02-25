import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nectar/utility/app_color.dart';
import 'package:nectar/view/category_prodouct/category_product.dart';
import 'package:nectar/view/category_prodouct/search_product.dart';
import 'package:nectar/view/shop_screen/controller/home_controller.dart';
import 'package:nectar/widget/app_input.dart';
import '../../widget/app_network_images.dart';
import '../../widget/app_shimmer.dart';

class ExploreScreen extends GetView<HomeController> {

  const ExploreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _searchController = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.bgWhite,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: AppInput(
          hintText: "Recherche",
          readOnly: true,
          onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchProduct())),
          controller: _searchController,
          // onChanged: (v){
          //   searchCategory.clear();
          //   for(var i in category){
          //     if(i.name!.toLowerCase().contains(v.toLowerCase())){
          //       print("...search name .... ${i.name}");
          //       setState(() {
          //         searchCategory.add(i);
          //       });
          //       print("searchCategory --- ${searchCategory.length}");
          //     }
          //   }
          // },
        )
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Obx(() {
            return controller.isGettingCategory.value
                ? const Center(child: AppShimmer(height: 100, width: 100))
                : ListView.builder(
                    shrinkWrap: true,
                  //  physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.categoryListModel.value.data!.length,
                    itemBuilder: (context, index) {
                      var data = controller.categoryListModel.value.data![index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade50
                            ),
                            child: Text(
                              data.name!,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 7.0,
                              mainAxisSpacing: 7.0,
                              mainAxisExtent: 170,
                            ),
                            itemCount:  data.subCategories!.length,
                            itemBuilder: (context, i) {
                              var subCat = data.subCategories![i];
                              return InkWell(
                                onTap: ()=>Get.to(CategoryProduct(categoryName: data.name!, subCategories: data.subCategories!, mainCatIndex: index, subCatName: subCat.name!)),
                                child: Container(
                                  padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.blue.shade50,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(width: 1, color: Colors.grey.shade200)
                                  ),
                                  child: Column(
                                    children: [

                                      SizedBox(
                                        child: Text("${subCat.name}",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      AppNetworkImage(src: subCat.image ?? "", height: 110,),

                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                        ],
                      );
                    },
                  );
          }
        ),
        )
    );
  }
}
