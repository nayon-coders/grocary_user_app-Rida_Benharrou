import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nectar/model/category_model.dart';
import 'package:nectar/model/sub_category_model.dart';
import 'package:nectar/utility/app_color.dart';
import 'package:nectar/view/category_prodouct/controller/category_product_controller.dart';
import 'package:nectar/view/category_prodouct/widgets/main_cat_view.dart';
import 'package:nectar/view/navigation_screen/navigation_screen.dart';
import 'package:nectar/view/shop_screen/controller/home_controller.dart';

import '../../data/models/category_list_model.dart';
import '../../widget/app_shimmer.dart';
import '../../widget/not_found.dart';
import '../shop_screen/widget/item_card.dart';
import 'widgets/sub_cat_view.dart';

class CategoryProduct extends StatefulWidget {
  final String categoryName;
  final List subCategories;
  final int mainCatIndex;
  final String subCatName;
  const CategoryProduct({super.key, required this.categoryName, required this.subCategories, required this.mainCatIndex, required this.subCatName});


  @override
  State<CategoryProduct> createState() => _CategoryProductState();
}

class _CategoryProductState extends State<CategoryProduct> {

  HomeController homeController = Get.find();
  CategoryProductController categoryProductController = Get.put(CategoryProductController());

  int _selectedIndex = 1;


  void onItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.push(context, MaterialPageRoute(builder: (context)=>NavigationScreen(pageIndex: _selectedIndex,)));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  List<SingleCategory> subCategories = [];

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    categoryProductController.subCategories.removeWhere((category) => category.name == 'All');
    categoryProductController.getCategoryProduct();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      categoryProductController.mainCatIndex.value = widget.mainCatIndex;

// Set selected subcategory
      if (widget.subCatName.isNotEmpty) {
        categoryProductController.selectedSubCategory.value = widget.subCatName;
        print("widget.subCatName ------ ${widget.subCatName}");
      } else if (widget.subCategories.isNotEmpty) {
        // If widget has subCategories, set the first one as default
        categoryProductController.selectedSubCategory.value = widget.subCategories.first.name!.toString();
      }

// Handle Subcategories
      if (widget.subCategories.isNotEmpty) {
        print("Subcategories are available, assigning them to controller");
        // Ensure that widget.subCategories is actually a List<SingleCategory>
        categoryProductController.subCategories.value = List<SingleCategory>.from(widget.subCategories);
      }

// Set Main Category
      if (widget.categoryName.isNotEmpty) {
        categoryProductController.selectedMainCategory.value = widget.categoryName;
      } else if (homeController.categoryListModel != null && homeController.categoryListModel!.value.data!.isNotEmpty) {
        // Set the first category if none is provided
        categoryProductController.selectedMainCategory.value = homeController.categoryListModel!.value.data!.first.name!.toString();
      }

// Call to get products
      categoryProductController.getCategoryProduct();

    });

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        title: Text("Catégorie"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
            // Remove "All" from the list
            categoryProductController.getCategoryProduct();
            // Navigate back
            Get.back();
          },
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: Column(
            children: [
              MainCatView(),
              SizedBox(height: 10,),
              SubCatView(),
            ],
          ),
        ),),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Obx((){
          if(categoryProductController.isLoading.value){
            return GridView.builder(
              itemCount: 10,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  mainAxisExtent: 180
              ),
              itemBuilder: (BuildContext context, int index) {
                return AppShimmer();
              },
            );
          }else if( categoryProductController.catProductModel.value.data == null || categoryProductController.catProductModel.value.data!.isEmpty){
            return NotFound();
          }else{
            return GridView.builder(
              itemCount: categoryProductController.catProductModel.value.data!.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                mainAxisExtent: 180
              ),
              itemBuilder: (BuildContext context, int index) {
                var data =  categoryProductController.catProductModel.value.data![index];
                return ItemCard(singleProduct: data);
              },
            );
          }

        })
      ),

      ///TODO:
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
    );
  }
}
