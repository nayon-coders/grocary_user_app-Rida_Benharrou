import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nectar/model/category_model.dart';
import 'package:nectar/utility/app_color.dart';
import 'package:nectar/utility/assets.dart';
import 'package:nectar/utility/fontsize.dart';

import '../../controller/product_controller.dart';
import '../../model/product_model.dart';
import '../../utility/app_const.dart';
import '../../widget/app_shimmer.dart';
import '../shop_screen/widget/categoreis.dart';
import '../shop_screen/widget/item_card.dart';
import '../shop_screen/widget/offer_products.dart';

class CategoryProduct extends StatefulWidget {
  final String categoryName;
  final CategoryModel categoryProduct;
  const CategoryProduct({super.key, required this.categoryName, required this.categoryProduct});


  @override
  State<CategoryProduct> createState() => _CategoryProductState();
}

class _CategoryProductState extends State<CategoryProduct> {

  bool _isLoading = false;
  List<Widget> _subCategory = [

  ];

  var clickedSubCategory;


  Future? subcategory;
  getSubCategory()async{

    setState(() => _isLoading = true);
    _subCategory.clear();
   var subCategory = await FirebaseFirestore.instance.collection(categoryCollection).doc(widget.categoryProduct!.docId).collection("sub_category").get();
   for(var i in subCategory.docs){
    setState(() {
      _subCategory.add(Tab(

        child: TextButton(
          onPressed: (){
            setState(() {
              sellerAccount = i.data()["name"].toString();
            });
            print("sellerAccount --- ${sellerAccount}");
          },
          child: Text("${i.data()["name"].toString()}"),
        )
      )) ;
    });
   }
    setState(() => _isLoading = false);

  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("widget.categoryProduct!.docId ${widget.categoryProduct!.docId}");
    subcategory = getSubCategory();
  }




  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _subCategory.length,
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
        body: _isLoading ? Center(child: CircularProgressIndicator(),) :  Column(
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
              isScrollable: true,
                tabs:_subCategory,
            ),
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
                      List<ProductModel> subCategoryproducts = [];


                      if(clickedSubCategory != null){
                        products.clear();
                        for(var i in snapshot.data!.docs){
                          if(i.data()["name"] = clickedSubCategory){
                            subCategoryproducts.add(ProductModel.fromJson(i.data()));
                          }

                        }
                      }else{
                        for(var i in snapshot.data!.docs){
                          products.add(ProductModel.fromJson(i.data()));
                        }
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
                          return subCategoryproducts.isNotEmpty &&  subCategoryproducts[index].status == "Active" ?  ItemCard(productModel: subCategoryproducts[index],) : products[index].status == "Active" ? ItemCard(productModel: products[index],) : Center();
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
