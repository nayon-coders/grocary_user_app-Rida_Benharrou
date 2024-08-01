import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../controller/product_controller.dart';
import '../../../model/product_model.dart';
import '../../../utility/fontsize.dart';
import '../../../widget/app_shimmer.dart';
import '../../shop_screen/widget/item_card.dart';

class RecomandationProducts extends StatefulWidget {
  const RecomandationProducts({super.key});

  @override
  State<RecomandationProducts> createState() => _RecomandationProductsState();
}

class _RecomandationProductsState extends State<RecomandationProducts> {

  Future<List<ProductModel>>? getRandomProduct;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRandomProduct = ProductController.getRecomandationProduct();
  }

  @override
  Widget build(BuildContext context) {
    ProductModel productModel;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Recommendation",style: TextStyle(fontSize:titleFont,fontWeight: FontWeight.w600,color: Colors.black),),

        SizedBox(height: 10,),
        FutureBuilder<List<ProductModel>>(
            future: getRandomProduct,
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


              return SizedBox(
                height: 200,
                child: ListView.builder(
                    padding: EdgeInsets.only(right: 10),
                    itemCount: snapshot.data!.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index){
                      return snapshot.data![index].status == "Active" ? ItemCard(productModel: snapshot.data![index],) : Center();
                    }),
              );
            }
        ),
      ],
    );
  }
}
