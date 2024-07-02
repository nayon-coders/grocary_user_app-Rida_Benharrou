import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nectar/model/sub_category_model.dart';
import 'package:nectar/utility/app_color.dart';
import 'package:nectar/utility/fontsize.dart';
import 'package:nectar/view/category_prodouct/category_product.dart';
import 'package:nectar/view/explore_screen/widget/category_card.dart';
import 'package:nectar/widget/app_input.dart';

import '../../generated/assets.dart';
import '../../model/category_model.dart';
import '../../utility/app_const.dart';
import '../../widget/app_network_images.dart';
import '../../widget/app_shimmer.dart';
import '../shop_screen/widget/categoreis.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Trouver des produits",
          style: TextStyle(
            fontSize: titleFont,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: AppColors.bgWhite,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child:    StreamBuilder(
                  stream: FirebaseFirestore.instance.collection(subCategoryCollection).snapshots(),
                  builder: (context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                        ),
                        itemCount: 8,
                        itemBuilder: (context, index) {
                          return AppShimmer();
                        },
                      );
                    }

                    //store category into category list
                    List<SubCategoryModel> category = [];
                    for(var i in snapshot.data!.docs){
                      category.add(SubCategoryModel.fromJson(i));
                    }

                    return category.isNotEmpty ? GridView.builder(
                     // physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                          mainAxisExtent: 190
                      ),
                      itemCount: category.length,
                      itemBuilder: (context, index) {
                        var data = category[index];
                        return InkWell(
                          onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> CategoryProduct(categoryName: data.name!, mainCatId: data.docId!, mainCatImage: data.image!,))),
                          child: Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                color: AppColors.bgGreen.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(width: 1, color: Colors.grey.shade200)
                            ),
                            child: Column(
                              children: [
                                Text("${data.name}",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black
                                  ),
                                ),
                                Spacer(),
                                AppNetworkImage(src: data.image!, height: 90, width: 90,),

                              ],
                            ),
                          ),
                        );
                      },
                    )  : Center(child: Padding(
                      padding:  EdgeInsets.all(50.0),
                      child: Image.asset(Assets.imagesNoPrd),
                    ),);
                  }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
