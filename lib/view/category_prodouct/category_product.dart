import 'package:flutter/material.dart';
import 'package:nectar/utility/app_color.dart';
import 'package:nectar/utility/assets.dart';
import 'package:nectar/utility/fontsize.dart';

import '../../controller/product_controller.dart';
import '../../model/product_model.dart';
import '../../widget/app_shimmer.dart';
import '../shop_screen/widget/item_card.dart';

class CategoryProduct extends StatefulWidget {
  final String categoryName;
  const CategoryProduct({super.key, required this.categoryName});


  @override
  State<CategoryProduct> createState() => _CategoryProductState();
}

class _CategoryProductState extends State<CategoryProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.categoryName}",
          style: TextStyle(
            fontSize: titleFont,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: StreamBuilder(
            stream: ProductController.getCategroyWishProduct(widget.categoryName!),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting){
                return SizedBox(
                  height: 250,
                  child: ListView.builder(
                      padding: EdgeInsets.only(right: 10),
                      itemCount: 5,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context,index){
                        return AppShimmer();
                      }),
                );
              }


              //store data into product model list
              List<ProductModel> products = [];

              for(var i in snapshot.data!.docs){
                products.add(ProductModel.fromJson(i.data()));
              }

              print("products --- ${products.length}");

              return products.isNotEmpty ? GridView.builder(

                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 5.0,
                  mainAxisExtent: 270,
                ),
                itemCount:  products.length,
                itemBuilder: (context, index) {
                  return products[index].status == "Active" ? ItemCard(productModel: products[index],) : Center();
                },
              ) : Center(child: Padding(
                padding: const EdgeInsets.all(50.0),
                child: Image.asset(Assets.norProduct),
              ),);
            }
        ),
      ),

    );
  }
}
