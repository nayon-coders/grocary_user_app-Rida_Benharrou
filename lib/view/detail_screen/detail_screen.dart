import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:nectar/controller/auth_controller.dart';
import 'package:nectar/controller/cart_controller.dart';
import 'package:nectar/controller/favourite_controller.dart';
import 'package:nectar/controller/product_controller.dart';
import 'package:nectar/model/product_model.dart';
import 'package:nectar/utility/app_const.dart';
import 'package:nectar/utility/assets.dart';
import 'package:nectar/utility/fontsize.dart';
import 'package:nectar/view/cart_screen/cart_screen.dart';
import 'package:nectar/view/detail_screen/widgets/fav_check.dart';
import 'package:nectar/view/navigation_screen/navigation_screen.dart';
import 'package:nectar/view/shop_screen/widget/recent_products.dart';

import '../../utility/app_color.dart';
import '../../widget/app_button.dart';
import '../../widget/app_network_images.dart';
import '../../widget/app_shimmer.dart';
import '../shop_screen/widget/item_card.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.productModel,});

  final ProductModel productModel;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
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
    getRole();
  }

  getRole()async{
    await AuthController.accountRole().then((value) => setState(()=> role = value ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Scaffold(
          backgroundColor:AppColors.bgWhite,
          body: SingleChildScrollView(
          //  padding: EdgeInsets.only(left: 15, right: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 30),
                  height: MediaQuery.of(context).size.height*0.35,
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
                              Navigator.pop(context);
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
                        child: AppNetworkImage(src: widget.productModel.images![0], fit: BoxFit.contain,
                        ),
                      ),

                      widget.productModel!.discountPrice!.isNotEmpty && widget.productModel!.discountPrice != "0" ? Positioned(
                        right: 10, top: 10,
                        child: Container(
                          width: 80,
                          height: 30,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(100)
                          ),
                          child: Center(child: Text("\$${widget.productModel!.discountPrice!} OFF",
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 13, color: Colors.white
                              )
                          ),),
                        ),
                      ) : Center(),

                      Positioned(
                          bottom: 10, right: 10,
                          child: FavWidgets(id: widget.productModel.id.toString())),


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
                               Text("${widget.productModel!.name.toString()}",
                                 style: TextStyle(
                                     fontSize: titleFont,
                                     fontWeight: FontWeight.w600,
                                     color: Colors.black),
                               ),
                               Text("${  role == sellerAccount
                                        ? widget.productModel.sellingPrice
                                            : role == restaurantAccount
                                        ? widget.productModel.regularPrice
                                            :  role == wholeSellerAccount
                                        ? widget.productModel.wholePrice
                                            : 00} € / ${widget.productModel.productType} ",
                                 style: TextStyle(
                                     fontSize: 12, fontWeight: FontWeight.w300, color: Colors.black
                                 ),
                               ),


                             ],
                           ),
                         ),

                         Column(
                           children: [
                             role != null
                                 ? role == restaurantAccount
                                 ? Text("${(double.parse(widget.productModel.regularPrice!)).toStringAsFixed(2) }€",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18,color: Colors.black),)
                                 : role == sellerAccount
                                 ? Text("${(double.parse(widget.productModel.sellingPrice!)).toStringAsFixed(2)  }€",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18,color: Colors.black),)
                                 : role == wholeSellerAccount
                                 ? Text("${(double.parse(widget.productModel.wholePrice!)).toStringAsFixed(2)  }€",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18,color: Colors.black),)
                                 : Text("Logiin") : CircularProgressIndicator(),


                           ],
                         )

                       ],
                     ),

                     ///Edit increment
                     ///Si
                     SizedBox(height: 30,),
                     AppButton(
                       bgColor: AppColors.bgGreen,
                       name: "Ajouter au panier",
                       onClick: (){
                         //add to cart
                         CartController.addToCar(context, widget.productModel.id.toString(), _initial.toString());

                       },
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
                          child: Text("${widget.productModel!.longDescription}"),
                        ) : Center(),

                      ),

                     SizedBox(height: 30,),



                     StreamBuilder(
                         stream: ProductController.getNewProduct(),
                         builder: (context, snapshot) {
                           if(snapshot.connectionState == ConnectionState.waiting){
                             return SizedBox(
                               height: 200,
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
                             if(ProductModel.fromJson(i.data()).subCategory.toString().contains(widget.productModel!.subCategory.toString())){
                               if(ProductModel.fromJson(i.data()).id != widget.productModel!.id){
                                 products.add(ProductModel.fromJson(i.data()));
                               }

                             }

                           }

                           print("products --- ${products.length}");

                           return Column(
                             mainAxisAlignment: MainAxisAlignment.start,
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               products.isNotEmpty? Text("Produit similaire",
                                 style: TextStyle(
                                     fontSize: 18,
                                     fontWeight: FontWeight.w600,
                                     color: Colors.black
                                 ),
                               ) : Center(),
                               SizedBox(height: 10,),
                               SizedBox(
                                 height: 200,
                                 child: ListView.builder(
                                     padding: EdgeInsets.only(right: 10),
                                     itemCount: products.length,
                                     scrollDirection: Axis.horizontal,
                                     itemBuilder: (context,index){
                                       return products[index].status == "Active" ? ItemCard(productModel: products[index],) : Center();
                                     }),
                               )
                             ],
                           );
                         }
                     ),
                   ],
                 ),
               )
              ],
            ),
          ),
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





class TotalCartCountWidgets extends StatelessWidget {
  const TotalCartCountWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: CartController.getCart(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(child:  CircularProgressIndicator(),);
        }
        return InkWell(
          onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>NavigationScreen(pageIndex: 2,))),
          child: Container(
            width: 60,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.mainColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Stack(
              children: [
                Positioned(
                  right: 7,
                  top: 2,
                  child: Text("${snapshot.data!.docs.length??0}",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white
                    ),
                  ),
                ),
                Center(child: Icon(Icons.shopping_cart, color: Colors.white, size: 25,)),
              ],
            ),
          ),
        );
      }
    );
  }
}

