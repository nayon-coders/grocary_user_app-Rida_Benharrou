import 'package:flutter/material.dart';

import '../../controller/product_controller.dart';
import '../../generated/assets.dart';
import '../../model/product_model.dart';
import '../../utility/app_color.dart';
import '../../utility/fontsize.dart';
import '../../widget/app_network_images.dart';
import '../../widget/app_shimmer.dart';
import '../shop_screen/widget/item_card.dart';


class AllProducts extends StatefulWidget {
  final String title;
  const AllProducts({super.key, required this.title});

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("${widget.title}",
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
        // child: StreamBuilder(
        //     stream: ProductController.getOfferProduct(),
        //     builder: (context, snapshot) {
        //       if(snapshot.connectionState == ConnectionState.waiting){
        //         return SizedBox(
        //           height: 220,
        //           child: ListView.builder(
        //               padding: EdgeInsets.only(right: 10),
        //               itemCount: 5,
        //               scrollDirection: Axis.horizontal,
        //               itemBuilder: (context,index){
        //                 return AppShimmer();
        //               }),
        //         );
        //       }
        //
        //
        //       //store data into product model list
        //       List<ProductModel> products = [];
        //
        //       for(var i in snapshot.data!.docs){
        //         products.add(ProductModel.fromJson(i.data()));
        //       }
        //
        //       print("products --- ${products.length}");
        //
        //       return  GridView.builder(
        //
        //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //           crossAxisCount: 2,
        //           crossAxisSpacing: 7.0,
        //           mainAxisSpacing: 15.0,
        //           mainAxisExtent: 240,
        //         ),
        //         itemCount: products.length > 8 ? 8 : products.length,
        //         itemBuilder: (context, index) {
        //           return products[index].status == "Active" ? ItemCard(singleProduct: products[index],) : Center();
        //         },
        //       );
        //     }
        // ),
        child: Text("All Products"),
      ),
    );
  }
}
