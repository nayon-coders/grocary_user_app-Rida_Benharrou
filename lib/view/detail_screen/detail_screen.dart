import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nectar/data/global/global_controller.dart';
import 'package:nectar/data/models/product_model.dart';
import 'package:nectar/utility/fontsize.dart';
import 'package:nectar/view/detail_screen/widgets/fav_check.dart';
import 'package:nectar/view/detail_screen/widgets/simmiler_product.dart';
import 'package:nectar/view/navigation_screen/navigation_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../utility/app_color.dart';
import '../../widget/app_button.dart';
import '../../widget/app_network_images.dart';
import '../cart_screen/controller/car_controller.dart';
import 'controller/details_screen_controller.dart';

class DetailScreen extends StatefulWidget {
  final String? productId;
  DetailScreen({this.productId});
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Ensure this happens after the build phase
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _detailsScreenController.getMainCatRelatedProduct(widget.productId.toString());
      _detailsScreenController.getSingleProductByID(widget.productId.toString());
    });

    // _detailsScreenController.get_detailsScreenController.singleProduct.valueByID(_detailsScreenController.singleProduct.value!.id.toString());
  }
  int activeIndex = 0;

  // SingleFavList singleFavList = Get.arguments;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Scaffold(
            backgroundColor:AppColors.bgWhite,
            body: Obx((){
              return _detailsScreenController.isLoading.value ||  _detailsScreenController.singleProduct.value == null? const Center(child: CircularProgressIndicator.adaptive(),)
                  : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 30),
                      height: MediaQuery.of(context).size.height*0.35,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [

                          Positioned(
                            left: 10, top:15,
                            child: InkWell(
                                onTap:(){
                                  Get.back();
                                },
                                child: const SizedBox(
                                    height: 40,
                                    width: 40,
                                    child: Center(child: Icon(Icons.keyboard_arrow_left_sharp,color: Colors.black, size: 40,)))),
                          ),

                          //Product image
                          Container(
                            height: MediaQuery.of(context).size.height*0.23,
                            width: MediaQuery.of(context).size.width*.65,
                            decoration: const BoxDecoration(

                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20)
                              ),
                            ),
                            child: Column(
                              children: [
                                Obx(() {
                                    return _detailsScreenController.singleProduct.value!.images == null ? Center() : CarouselSlider.builder(
                                      itemCount: _detailsScreenController.singleProduct.value!.images!.length,
                                      itemBuilder: (context, index, realIndex) {
                                        return Container(

                                          width: MediaQuery.of(context).size.width * 0.65,
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(20),
                                              bottomRight: Radius.circular(20),
                                            ),
                                          ),
                                          child: ClipRRect(
                                            borderRadius: const BorderRadius.only(
                                              bottomLeft: Radius.circular(20),
                                              bottomRight: Radius.circular(20),
                                            ),
                                            child: AppNetworkImage(src:  _detailsScreenController.singleProduct.value!.images![index].imageUrl!, fit: BoxFit.contain,),
                                          ),
                                        );
                                      },
                                      options: CarouselOptions(
                                        height: MediaQuery.of(context).size.height * 0.20,
                                        autoPlay:false,
                                        viewportFraction: 1.0,
                                        onPageChanged: (index, reason) {
                                          setState(() {
                                            activeIndex = index;
                                          });
                                        },
                                      ),
                                    );
                                  }
                                ),

                                const SizedBox(height: 8),

                                // **SmoothPageIndicator**
                                Obx(() {
                                    return   _detailsScreenController.singleProduct.value == null ? Center() : AnimatedSmoothIndicator(
                                      activeIndex: activeIndex,
                                      count: _detailsScreenController.singleProduct.value!.images!.length,
                                      effect: const ExpandingDotsEffect(
                                        dotHeight: 5,
                                        dotWidth: 5,
                                        activeDotColor: Colors.blue,
                                        dotColor: Colors.grey,
                                      ),
                                    );
                                  }
                                ),
                              ],
                            ),
                            //child: AppNetworkImage(src:  _detailsScreenController.singleProduct.value!.images![0].imageUrl!, fit: BoxFit.contain,),
                          ),
                          const SizedBox(height: 10,),


                          _detailsScreenController.singleProduct.value!.discountPrice != null &&  _detailsScreenController.singleProduct.value!.discountPrice! > 0 ? Positioned(
                            right: 10, top: 30,
                            child: Container(
                              width: 100,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(100)
                              ),
                              child: Center(child: Text("Promo - ${double.parse("${_detailsScreenController.singleProduct.value!.discountPrice}").toStringAsFixed(0)}%",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 13, color: Colors.white
                                  )
                              ),),
                            ),
                          ) : const Center(),

                          //origin
                          Positioned(
                              bottom: 10, left: 10,
                              child: Text("Origine: ${ _detailsScreenController.singleProduct.value!.country}")),

                          // Fav button
                          Positioned(
                              bottom: 10, right: 10,
                              child: FavWidgets(id:  _detailsScreenController.singleProduct.value!.id.toString())),

                        ],
                      ),
                    ),


                    //Product name
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10,),
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
                                    Text("${ _detailsScreenController.singleProduct.value!.name.toString()}",
                                      style: TextStyle(
                                          fontSize: titleFont,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black),
                                    ),
                                    Text("${_detailsScreenController.singleProduct.value!.packaging}",
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black),
                                    ),

                                  ],
                                ),
                              ),

                              Column(
                                children: [
                                  Obx((){
                                    return
                                      Text("${globalController.priceCalculat(_detailsScreenController.singleProduct.value!.regularPrice, _detailsScreenController.singleProduct.value!.sellingPrice, _detailsScreenController.singleProduct.value!.wholePrice, _detailsScreenController.singleProduct.value!.supperMarcent).toStringAsFixed(2)}€",
                                        style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 18,color: Colors.black),);
                                  }),
                                  Obx((){
                                    return
                                      Text("${(double.parse("${globalController.priceCalculat(_detailsScreenController.singleProduct.value!.regularPrice, _detailsScreenController.singleProduct.value!.sellingPrice, _detailsScreenController.singleProduct.value!.wholePrice, _detailsScreenController.singleProduct.value!.supperMarcent)}") / double.parse("${_detailsScreenController.singleProduct.value!.uvw != null ? _detailsScreenController.singleProduct.value!.uvw.toString() : "0.00"}")).toStringAsFixed(2)} € / 1 ${_detailsScreenController.singleProduct.value!.unit?.split(" ")[0]}",
                                        style: const TextStyle(fontWeight: FontWeight.w400,fontSize: 12,color: Colors.black),);
                                  }),
                                ],
                              )

                            ],
                          ),

                          ///Edit increment
                          ///Si

                          _detailsScreenController.singleProduct.value!.shortDescription != null && _detailsScreenController.singleProduct.value!.shortDescription!.isNotEmpty ? Container(
                            margin: const EdgeInsets.only(top: 8),
                            child: Text("${_detailsScreenController.singleProduct.value!.shortDescription}",
                              style: const TextStyle(
                                fontSize: 12, color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ) : const Center(),
                          const SizedBox(height: 10,),

                          //increment decrement
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
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey.shade200),
                                      borderRadius: BorderRadius.circular(10),
                                      color: AppColors.bgWhite,
                                    ),
                                    child: const Center(
                                      child: Icon(Icons.remove,color: AppColors.textGrey,),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10,),
                                Text("${_initial}",style: TextStyle(fontWeight: FontWeight.w600,fontSize: normalFont,color: Colors.black),),
                                const SizedBox(width: 10,),
                                InkWell(
                                  onTap: (){
                                    setState(() {
                                      _initial++;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey.shade200),
                                      borderRadius: BorderRadius.circular(10),
                                      color: AppColors.bgWhite,
                                    ),
                                    child: const Center(
                                      child: Icon(Icons.add,color: Colors.green,),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 15,),
                          Obx(() {
                            return AppButton(
                              isLoading: carControllerNew.isAddingCart.value,
                              bgColor:  carControllerNew.isAlreadyInCart(_detailsScreenController.singleProduct.value!.id.toString()) ? Colors.grey : AppColors.bgGreen,
                              name: carControllerNew.isAlreadyInCart(_detailsScreenController.singleProduct.value!.id.toString()) ? "Produit déjà dans votre panier" : "Ajouter au panier",
                              onClick: (){
                                if( carControllerNew.isAlreadyInCart(_detailsScreenController.singleProduct.value!.id.toString())){
                                  return null;
                                }else{
                                  carControllerNew.addToCart(_initial, _detailsScreenController.singleProduct.value!.id.toString());
                                }

                              },
                            );
                          }
                          ),

                          const SizedBox(height: 15,),
                          ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: InkWell(
                                onTap: (){
                                  setState(() {
                                    _isShowDetiails = !_isShowDetiails;
                                  });
                                },
                                child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("Détails du produit",
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
                                child: Text("${ _detailsScreenController.singleProduct.value!.longDescription}"),
                              )  : Center()

                          ),

                          const SizedBox(height: 30,),


                          SimmilerProduct( _detailsScreenController.singleProduct.value!),


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






