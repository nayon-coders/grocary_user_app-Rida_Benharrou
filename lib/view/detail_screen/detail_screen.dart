import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nectar/data/global/global_controller.dart';
import 'package:nectar/data/global/global_variable.dart';
import 'package:nectar/data/models/product_model.dart';
import 'package:nectar/utility/fontsize.dart';
import 'package:nectar/view/detail_screen/widgets/fav_check.dart';
import 'package:nectar/view/detail_screen/widgets/simmiler_product.dart';
import 'package:nectar/view/navigation_screen/navigation_screen.dart';

import '../../utility/app_color.dart';
import '../../widget/app_button.dart';
import '../../widget/app_network_images.dart';
import '../../widget/app_shimmer.dart';
import '../shop_screen/widget/item_card.dart';
import '../cart_screen/controller/car_controller.dart';
import 'controller/details_screen_controller.dart';

class DetailScreen extends StatefulWidget {
  final SingleProduct? singleProduct;
  DetailScreen({this.singleProduct});
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  DetailsScreenController _detailsScreenController = Get.put(DetailsScreenController());
  CartControllerNew carControllerNew = Get.find<CartControllerNew>();
  GlobalController globalController = Get.find<GlobalController>();

  int _initial = 1;
  int _selectedIndex = 0;


  bool _isShowDetiails = false;

  void onItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.push(context, MaterialPageRoute(builder: (context)=>NavigationScreen(pageIndex: _selectedIndex,)));
  }

  String? role;
  var totalCart;
  SingleProduct? singleProduct;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    singleProduct = widget.singleProduct;
    // Ensure this happens after the build phase
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _detailsScreenController.getMainCatRelatedProduct(singleProduct!.categoryName.toString());
    });
    // _detailsScreenController.getSingleProductByID(singleProduct!.id.toString());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Scaffold(
          backgroundColor:AppColors.bgWhite,
          body: Obx((){
              return _detailsScreenController.isLoading.value ? Center(child: CircularProgressIndicator.adaptive(),)
                  : SingleChildScrollView(
                   child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 30),
                          height: MediaQuery.of(context).size.height*0.35,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [

                              Positioned(
                                left: 10, top: 20,
                                child: InkWell(
                                    onTap:(){
                                      Get.back();
                                    },
                                    child: Container(
                                        height: 40,
                                        width: 40,
                                        child: Center(child: Icon(Icons.keyboard_arrow_left_sharp,color: Colors.black, size: 40,)))),
                              ),

                              Container(
                                height: MediaQuery.of(context).size.height*0.23,
                                width: MediaQuery.of(context).size.width*.65,
                                decoration: BoxDecoration(

                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20)
                                  ),
                                ),
                                child: AppNetworkImage(src:  singleProduct!.images![0].imageUrl!, fit: BoxFit.contain,
                                ),
                              ),

                              singleProduct!.discountPrice != null &&  singleProduct!.discountPrice! > 0 ? Positioned(
                                right: 10, top: 30,
                                child: Container(
                                  width: 80,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(100)
                                  ),
                                  child: Center(child: Text("\$${ singleProduct!.discountPrice!} OFF",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 13, color: Colors.white
                                      )
                                  ),),
                                ),
                              ) : Center(),


                              Positioned(
                                  bottom: 10, left: 10,
                                  child: Text("Origine: ${ singleProduct!.country}")),

                              ///TODO: Fav button
                              Positioned(
                                  bottom: 10, right: 10,
                                  child: FavWidgets(id:  singleProduct!.id.toString())),

                            ],
                          ),
                        ),


                        ///TODO:Product name
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width*.70,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("${ singleProduct!.name.toString()}",
                                          style: TextStyle(
                                              fontSize: titleFont,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black),
                                        ),

                                      ],
                                    ),
                                  ),

                                  Column(
                                    children: [
                                      Obx((){
                                        return
                                          Text("${globalController.priceCalculat(singleProduct!.regularPrice, singleProduct!.sellingPrice, singleProduct!.wholePrice, singleProduct!.supperMarcent!)}€",
                                          style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18,color: Colors.black),);
                                      })
                                    ],
                                  )

                                ],
                              ),

                              ///Edit increment
                              ///Si

                              singleProduct!.shortDescription != null && singleProduct!.shortDescription!.isNotEmpty ? Container(
                                margin: EdgeInsets.only(top: 8),
                                child: Text("${singleProduct!.shortDescription}",
                                  style: TextStyle(
                                    fontSize: 12, color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ) : Center(),
                              SizedBox(height: 10,),
                              SizedBox(
                                width: 120,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: (){
                                        setState(() {
                                          if(_initial > 1){
                                            _initial--;
                                          }
                                        });
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.grey.shade200),
                                          borderRadius: BorderRadius.circular(10),
                                          color: AppColors.bgWhite,
                                        ),
                                        child: Center(
                                          child: Icon(Icons.remove,color: AppColors.textGrey,),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    Text("${_initial}",style: TextStyle(fontWeight: FontWeight.w600,fontSize: normalFont,color: Colors.black),),
                                    SizedBox(width: 10,),
                                    InkWell(
                                      onTap: (){
                                        setState(() {
                                          _initial++;
                                        });
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.grey.shade200),
                                          borderRadius: BorderRadius.circular(10),
                                          color: AppColors.bgWhite,
                                        ),
                                        child: Center(
                                          child: Icon(Icons.add,color: Colors.green,),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 15,),
                              Obx(() {
                                  return AppButton(
                                    isLoading: carControllerNew.isAddingCart.value,
                                    bgColor: AppColors.bgGreen,
                                    name: "Ajouter au panier",
                                    onClick: (){
                                       carControllerNew.addToCart(_initial, singleProduct!.id.toString());
                                    },
                                  );
                                }
                              ),

                              SizedBox(height: 15,),
                              ListTile(
                                contentPadding: EdgeInsets.zero,
                                title: InkWell(
                                  onTap: (){
                                    setState(() {
                                      _isShowDetiails = !_isShowDetiails;
                                    });
                                  },
                                  child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade100,
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Détails du produit",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700
                                            ),
                                          ),
                                          Icon(_isShowDetiails ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down_outlined)
                                        ],
                                      )),
                                ),
                                subtitle: _isShowDetiails ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("${ singleProduct!.longDescription}"),
                                ) : Center(),

                              ),

                              SizedBox(height: 30,),


                              SimmilerProduct( singleProduct!),


                            ],
                          ),
                        )
                      ],
                ),
              );
            }
          )
        ),
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
                icon: SizedBox(
                  child: Stack(
                    children: [

                      Icon(Icons.shopping_basket_outlined, size: 28,),
                      Obx(() {
                        return carControllerNew.cartCount.value != 0 ? Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            width: 15, height: 15,
                            decoration: BoxDecoration(
                              color: AppColors.bgGreen,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text("${carControllerNew.cartCount.value}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                    fontSize: 10
                                ),
                              ),
                            ),
                          ),
                        ) : Positioned(
                            right: 0,
                            top: 0,
                            child: Center());
                      }
                      ),

                    ],
                  ),
                ),
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






