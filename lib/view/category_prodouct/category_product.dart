import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nectar/model/category_model.dart';
import 'package:nectar/model/sub_category_model.dart';
import 'package:nectar/utility/app_color.dart';
import 'package:nectar/utility/assets.dart';
import 'package:nectar/utility/fontsize.dart';
import 'package:nectar/view/navigation_screen/navigation_screen.dart';
import 'package:nectar/widget/app_network_images.dart';

import '../../controller/product_controller.dart';
import '../../model/product_model.dart';
import '../../utility/app_const.dart';
import '../../widget/app_shimmer.dart';
import '../../widget/not_found.dart';
import '../account_screen/account_screen.dart';
import '../cart_screen/cart_screen.dart';
import '../explore_screen/explore_screen.dart';
import '../favorite_screen/favorite_screen.dart';
import '../shop_screen/shop_screen.dart';
import '../shop_screen/widget/categoreis.dart';
import '../shop_screen/widget/item_card.dart';
import '../shop_screen/widget/offer_products.dart';

class CategoryProduct extends StatefulWidget {
  final String categoryName;
  final bool fromSubCat;
  final String subCategoryName;
  final String mainCatId;
  final String mainCatImage;
  const CategoryProduct({super.key, required this.categoryName, required this.mainCatId, required this.mainCatImage, this.subCategoryName = "", this.fromSubCat = true,});


  @override
  State<CategoryProduct> createState() => _CategoryProductState();
}

class _CategoryProductState extends State<CategoryProduct> {

  int _selectedIndex = 1;


  void onItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.push(context, MaterialPageRoute(builder: (context)=>NavigationScreen(pageIndex: _selectedIndex,)));
  }

  bool _isLoading = false;
  bool _loadingForGetingSubCategory = false;
  List<Widget> _subCategoryTab = [];
  List<CategoryModel> _categoryTab = [];
  List<CategoryModel> categories = [];
  List<SubCategoryModel> subCategories = [];
  List _subCategoryname = [];

  var clickedSubCategory;


  Future? subcategory;
  var _seelctedMainCategory, _seelctedMainCategoryName;

  //get all category and sub categoris
  getMainCategory()async{
    await FirebaseFirestore.instance.collection(categoryCollection).get().then((cat){
      for(var j in cat.docs){
          _categoryTab.add(CategoryModel.fromSnapshot(j));
      }
    });

  }

  //sub category
  getAllCategory()async{
    subCategories.clear();
    _subCategoryTab.clear();
    setState(() => _loadingForGetingSubCategory =  true);


    await FirebaseFirestore.instance.collection(subCategoryCollection).get().then((subCategoryValue){
      _subCategoryTab.add(Tab(child: Text("Tout",
        style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 13, color: Colors.black
        ),
      ),));
      for(var j in subCategoryValue.docs){
        if(_seelctedMainCategory == SubCategoryModel.fromJson(j).mainCatId ){
            subCategories.add(SubCategoryModel.fromJson(j));
            _subCategoryTab.add(
                Tab(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0), // Remove horizontal padding
                      child: Text(SubCategoryModel.fromJson(j).name!,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13, color: Colors.black
                        ),
                      ),
                    ),
                )
            );
        }
      }

    });
    setState(() => _loadingForGetingSubCategory =  false);

  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("doc id --- ${widget.mainCatId}");
    _seelctedMainCategory = widget.mainCatId;

    subcategory = getAllCategory();
    getMainCategory();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    subcategory = getAllCategory();
    getMainCategory();
  }




  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _subCategoryTab.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Catégorie"),
          // title: SizedBox(
          //   width: MediaQuery.of(context).size.width*.90,
          //
          //   // child: Row(
          //   //   children: [
          //   //     AppNetworkImage(src: widget.mainCatImage!, width: 40, height: 40,),
          //   //     SizedBox(width: 5,),
          //   //     SizedBox(
          //   //       width: MediaQuery.of(context).size.width*.60,
          //   //       child: Text("${widget.categoryName}",
          //   //         overflow: TextOverflow.ellipsis,
          //   //         style: TextStyle(
          //   //           fontSize: 18,
          //   //           fontWeight: FontWeight.w600,
          //   //           color: Colors.black,
          //   //         ),
          //   //       ),
          //   //     ),
          //   //   ],
          //   // ),
          // ),
          centerTitle: true,
          backgroundColor: Colors.white,
          bottom: PreferredSize(
              preferredSize: Size.fromHeight(90),
              child:  Column(
                children: [
                  SizedBox(height: 40,
                    child: ListView.builder(
                      itemCount: _categoryTab.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_, index){
                        var data = _categoryTab[index];
                        return InkWell(
                          onTap: (){
                            subcategory = getAllCategory();
                            setState(() {
                              clickedSubCategory = null;
                              _seelctedMainCategory = data.docId.toString();
                              _seelctedMainCategoryName = data.categoryName.toString();
                            });

                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 7, left: 7),
                            padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.grey.shade100),
                              borderRadius: BorderRadius.circular(10),
                              color: _seelctedMainCategory != null && _seelctedMainCategory == data.docId ? AppColors.mainColor.withOpacity(0.2) : Colors.white
                            ),
                            child: Row(
                              children: [
                                AppNetworkImage(src: "${data.categoryImage}", height: 40, width: 40,),
                                SizedBox(width: 5,),
                                Text("${data.categoryName}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: _seelctedMainCategory != null && _seelctedMainCategory == data.docId ? AppColors.mainColor : Colors.black
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  ),
                  SizedBox(height: 5,),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: TabBar(
                      isScrollable: true,
                      indicatorSize: TabBarIndicatorSize.label,
                      tabs: _subCategoryTab,
                      indicatorColor: Colors.blue,
                      labelColor: Colors.black,
                      onTap: (index){
                       // clickedSubCategory = null;
                        if(index == 0){
                          setState(() {
                            clickedSubCategory = null;
                          });
                        }else{
                          setState(() {
                            clickedSubCategory = subCategories[index]!.name.toString();
                          });
                        }

                      },
                    ),
                  ),
                ],
              ),
          ),
        ),
        backgroundColor: Colors.white,
        body: _loadingForGetingSubCategory ? Center(child: CircularProgressIndicator(),) :  Column(
          children: [

            SizedBox(height: 10,),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: StreamBuilder(
                 // stream: ProductController.getCategroyWishProduct(_seelctedMainCategoryName),
                    stream: clickedSubCategory != null
                        ?  ProductController.getSubCategroyWishProduct(clickedSubCategory)
                        : ProductController.getCategroyWishProduct(_seelctedMainCategoryName),
                    builder: (context, snapshot) {
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return SizedBox(
                          child: GridView.builder(
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 5.0,
                                mainAxisSpacing: 5.0,
                                mainAxisExtent: 200,
                              ),
                              itemCount:  20,
                              itemBuilder: (context,index){
                                return AppShimmer();
                              }),
                        );
                      }
                      //store data into product model list
                      List<ProductModel> products = [];
                      List<ProductModel> subCategoryproducts = [];


                      if(clickedSubCategory == null){
                        for(var i in snapshot.data!.docs){
                          products.add(ProductModel.fromJson(i.data()));
                        }

                      }else{
                        products.clear();
                        subCategoryproducts.clear();
                        for(var i=0; i<snapshot.data!.docs.length; i++){

                          if(snapshot.data!.docs[i].data()["sub_category"].toString().toLowerCase() == clickedSubCategory.toString().toLowerCase()){
                            subCategoryproducts.add(ProductModel.fromJson(snapshot.data!.docs[i].data()));
                          }

                        }
                      }



                      return products.isNotEmpty ? GridView.builder(

                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 5.0,
                          mainAxisSpacing: 5.0,
                          mainAxisExtent: 200,
                        ),
                        itemCount:  products.length,
                        itemBuilder: (context, index) {
                          return products.isNotEmpty &&  products[index].status == "Active" ?  ItemCard(productModel: products[index],) : products[index].status == "Active" ? ItemCard(productModel: products[index],) : Center();
                        },
                      ) : subCategoryproducts.isNotEmpty ? GridView.builder(

                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 5.0,
                          mainAxisSpacing: 5.0,
                          mainAxisExtent: 200,
                        ),
                        itemCount:  subCategoryproducts.length,
                        itemBuilder: (context, index) {
                          return subCategoryproducts.isNotEmpty &&  subCategoryproducts[index].status == "Active" ?  ItemCard(productModel: subCategoryproducts[index],) : subCategoryproducts[index].status == "Active" ? ItemCard(productModel: subCategoryproducts[index],) : Center();
                        },
                      ) : NotFound();
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

        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(15),
            topLeft: Radius.circular(15),
          ),
          child: BottomNavigationBar(
              elevation: 0,
              backgroundColor: Colors.white,
              type: BottomNavigationBarType.fixed,
              currentIndex: _selectedIndex,
              onTap: onItem,

              selectedItemColor: AppColors.bgGreen,
              selectedLabelStyle: TextStyle(color: AppColors.bgGreen),
              unselectedItemColor: AppColors.textGrey,
              unselectedLabelStyle: TextStyle(color:AppColors.textGrey),
              items: [
                BottomNavigationBarItem(

                  icon: Icon(Icons.dashboard),
                  label: "Explorer",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.manage_search_rounded),
                  label: "Catégories",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_basket_outlined),
                  label: "Panier",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.manage_search),
                  label: "Favoris",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.perm_identity),
                  label: "Profil",
                ),
              ]
          ),
        ),
      ),
    );
  }
}
