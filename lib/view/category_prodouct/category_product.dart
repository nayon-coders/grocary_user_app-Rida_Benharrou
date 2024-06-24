import 'package:flutter/material.dart';
import 'package:nectar/utility/app_color.dart';
import 'package:nectar/utility/assets.dart';
import 'package:nectar/utility/fontsize.dart';

import '../../controller/product_controller.dart';
import '../../model/product_model.dart';
import '../../widget/app_shimmer.dart';
import '../shop_screen/widget/categoreis.dart';
import '../shop_screen/widget/item_card.dart';
import '../shop_screen/widget/offer_products.dart';

class CategoryProduct extends StatefulWidget {
  final String categoryName;
  const CategoryProduct({super.key, required this.categoryName});


  @override
  State<CategoryProduct> createState() => _CategoryProductState();
}

class _CategoryProductState extends State<CategoryProduct> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("${widget.categoryName}",
            style: TextStyle(
              fontSize: titleFont,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            SizedBox(height: 10,),
            ///add Category list
            // SizedBox(
            //   height: 50,
            //   child: ListView.builder(
            //     itemCount: 10,
            //       scrollDirection: Axis.horizontal,
            //       itemBuilder: (context,index){
            //     return InkWell(
            //       onTap: (){},
            //       child: Container(
            //         margin: EdgeInsets.only(right: 10),
            //         padding: EdgeInsets.all(10),
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(10),
            //           border: Border.all(color: Colors.grey.shade200),
            //         ),
            //         child: Row(
            //           children: [
            //             Image.asset(Assets.gajorIcon,height: 20,width: 20,fit: BoxFit.cover,),
            //             SizedBox(width: 5,),
            //             Text("Fruits",style: TextStyle(fontWeight: FontWeight.w500,color: AppColors.textBlack,fontSize: 14),)
            //           ],
            //         ),
            //       ),
            //     );
            //   }),
            // ),
            ///Add Tabbar
            TabBar(
                tabs:[
              Tab(text: "Notre Seletction",),
              Tab(text: "Notre Seletction",),
              Tab(text: "Notre Seletction",),
            ]),
            SizedBox(height: 10,),
            Expanded(
              flex: 2,
              child: Padding(
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
                          mainAxisExtent: 240,
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
            ),
            // SizedBox(
            //   height: 306,
            //   child: OfferProducts(),
            // ),
          ],
        ),
      ),
    );
  }
}
