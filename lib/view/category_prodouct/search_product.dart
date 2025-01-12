import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nectar/widget/app_input.dart';

import '../../widget/app_shimmer.dart';
import '../shop_screen/widget/item_card.dart';
import '../show_product/all_products.dart';
import 'controller/category_product_controller.dart';


class SearchProduct extends StatefulWidget {
  const SearchProduct({super.key});

  @override
  State<SearchProduct> createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
  final _search = TextEditingController();
  var searchValue;
  final CategoryProductController categoryProductController = Get.put(CategoryProductController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 30,
        title: AppInput(controller: _search, hintText: "Recherche",
          onChanged: (v){
            categoryProductController.getSearchProduct(v!.toString());
          },
          prefixIcon: Icon(Icons.search),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Obx(() {
          if(categoryProductController.isLoading.value){
            return SizedBox(
              height: 200,
              child: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(right: 10),
                  itemCount: 5,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context,index){
                    return AppShimmer();
                  }),
            );
          }else if(categoryProductController.searchProduct.value.data == null){
            return Center(child: Text("No data found"));
          }else{
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 5.0,
                  mainAxisExtent: 200,
                ),
                itemCount: categoryProductController.searchProduct.value.data!.length,
                itemBuilder: (context,index){
                  var data = categoryProductController.searchProduct.value.data![index];
                  return ItemCard(singleProduct: data);
                }
            );
          }
        }),

      ),
    );
  }
}
