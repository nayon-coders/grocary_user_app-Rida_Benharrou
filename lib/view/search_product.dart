import 'package:flutter/material.dart';
import 'package:nectar/view/shop_screen/widget/item_card.dart';
import 'package:nectar/widget/app_input.dart';

import '../controller/product_controller.dart';
import '../model/product_model.dart';
import '../widget/app_shimmer.dart';


class SearchProduct extends StatefulWidget {
  const SearchProduct({super.key});

  @override
  State<SearchProduct> createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
  final _search = TextEditingController();
  var searchValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppInput(controller: _search, hintText: "Rechercher un produit....",
          onChanged: (v){
              setState(() {
                searchValue = v!.toString();
              });
          },
          prefixIcon: Icon(Icons.search),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: StreamBuilder(
            stream: ProductController.getNewProduct(),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting){
                return SizedBox(
                  height: 250,
                  child: ListView.builder(
                      padding: EdgeInsets.only(right: 10),
                      itemCount: 6,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context,index){
                        return AppShimmer();
                      }),
                );
              }


              //store data into product model list
              List<ProductModel> products = [];
              List<ProductModel> searchProducts = [];

              for(var i in snapshot.data!.docs){
                products.add(ProductModel.fromJson(i.data()));
              }

              if(searchValue != null)
              for(var i in snapshot.data!.docs){
                if(ProductModel.fromJson(i.data()).name!.toLowerCase().contains(searchValue.toString())){
                  searchProducts.add(ProductModel.fromJson(i.data()));
                }
              }



              print("products --- ${products.length}");

              return searchValue != null && searchProducts.isNotEmpty
                  ? GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5.0,
                      mainAxisSpacing: 5.0,
                      mainAxisExtent: 270,
                    ),
                    itemCount: searchProducts.length,
                    itemBuilder: (context, index) {
                      return searchProducts[index].status == "Active" ? ItemCard(productModel: searchProducts[index],) : Center();
                    },
                  )
                  : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 5.0,
                  mainAxisExtent: 270,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return products[index].status == "Active" ? ItemCard(productModel: products[index],) : Center();
                },
              );
            }
        ),
      ),
    );
  }
}
