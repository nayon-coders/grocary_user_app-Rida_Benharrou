import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nectar/model/sub_category_model.dart';
import 'package:nectar/utility/app_color.dart';
import 'package:nectar/utility/fontsize.dart';
import 'package:nectar/view/category_prodouct/category_product.dart';
import 'package:nectar/view/explore_screen/widget/category_card.dart';
import 'package:nectar/view/search_product.dart';
import 'package:nectar/widget/app_input.dart';
import 'package:nectar/widget/not_found.dart';

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
  //store category into category list
  List<SubCategoryModel> category = [];
  List<SubCategoryModel> searchCategory = [];
  @override
  Widget build(BuildContext context) {
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
        child: StreamBuilder(
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


              if(searchCategory.isEmpty){
                for(var i in snapshot.data!.docs){
                  category.add(SubCategoryModel.fromJson(i));
                }
              }


              return searchCategory.isNotEmpty
                  ? GridView.builder(
                      // physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                          mainAxisExtent: 180
                      ),
                      itemCount: searchCategory.length,
                      itemBuilder: (context, index) {
                        var data = searchCategory[index];
                        return InkWell(
                          onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> CategoryProduct(categoryName: data.name!, mainCatId: data.docId!, mainCatImage: data.image!,))),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.blue.shade50,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(width: 1, color: Colors.grey.shade200)
                            ),
                            child: Column(
                              children: [
                                Text("${data.name}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black
                                  ),
                                ),
                                Spacer(),
                                AppNetworkImage(src: data.image!, height: 110, width: 110,),

                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : category.isNotEmpty
                  ? GridView.builder(
               // physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
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
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(width: 1, color: Colors.grey.shade200)
                      ),
                      child: Column(
                        children: [
                          Text("${data.name}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: Colors.black
                            ),
                          ),
                          Spacer(),
                          AppNetworkImage(src: data.image!, height: 110, width: 110,),

                        ],
                      ),
                    ),
                  );
                },
              )
                  : NotFound();
            }
        ),
      ),
    );
  }
}
