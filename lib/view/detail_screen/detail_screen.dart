import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    AuthController.accountRole().then((value) => setState(()=> role = value ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Scaffold(
          appBar: AppBar(
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                  onTap:(){
                    Navigator.pop(context);
                  },
                  child: Container(
                      height: 20,
                      width: 20,
                      child: Center(child: Icon(Icons.keyboard_arrow_left_sharp,color: Colors.black, size: 40,)))),
            ),
            backgroundColor: AppColors.bgWhite,
          ),
          backgroundColor:AppColors.bgWhite,
          body: SingleChildScrollView(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    widget.productModel!.discountPrice !=null && widget.productModel!.discountPrice!.isNotEmpty ? Positioned(
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
                    Container(
                      height: MediaQuery.of(context).size.height*0.40,
                      width: double.infinity,
                      padding: EdgeInsets.all(50),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20)
                        ),
                      ),
                      child: AppNetworkImage(src: widget.productModel.images![0], fit: BoxFit.contain, height:  MediaQuery.of(context).size.height*0.35
                      ),
                    ),
                  ],
                ),
                ///TODO:Product name
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width-100,
                      child: Text("${widget.productModel!.name.toString()}",
                        style: TextStyle(
                            fontSize: titleFont,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    ),
                   FavWidgets(id: widget.productModel.id.toString()),

                  ],
                ),
                SizedBox(height: 5,),
                SizedBox(
                  width: MediaQuery.of(context).size.width-100,
                  child: Text("${widget.productModel.categoryS!.categoryName.toString()}",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: smallFont,
                        color: AppColors.textGrey,
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Text("${widget.productModel.productType}",
                  style: TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w600, color: Colors.grey
                  ),
                ),
                SizedBox(height: 10,),


                ///Edit increment
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AppButton(
                      bgColor: AppColors.bgGreen,
                      name: "Ajouter au panier",
                      onClick: (){
                        //add to cart
                        CartController.addToCar(context, widget.productModel.id.toString(), _initial.toString());

                      },
                    ),

                    Column(
                      children: [
                        role != null ? Text("$role Prix", style: TextStyle(color: Colors.red),) : Center(),
                        role != null
                            ? role == restaurantAccount
                            ? Text("\$${(double.parse(widget.productModel!.regularPrice!) * double.parse(_initial.toString())).toStringAsFixed(2) }",style: TextStyle(fontWeight: FontWeight.w600,fontSize: titleFont,color: Colors.black),)
                            : role == sellerAccount
                            ? Text("\$${(double.parse(widget.productModel!.sellingPrice!) * double.parse(_initial.toString())).toStringAsFixed(2)  }",style: TextStyle(fontWeight: FontWeight.w600,fontSize: titleFont,color: Colors.black),)
                            : role == wholeSellerAccount
                            ? Text("\$${(double.parse(widget.productModel!.regularPrice!) * double.parse(_initial.toString())).toStringAsFixed(2)  }",style: TextStyle(fontWeight: FontWeight.w600,fontSize: titleFont,color: Colors.black),)
                            : Text("Logiin") : CircularProgressIndicator(),


                      ],
                    )

                  ],
                ),

                // SizedBox(height: 20,),
                // Text("Détails du produit",
                //   style: TextStyle(
                //     fontWeight: FontWeight.w600,
                //     color: Colors.black,
                //     fontSize: 14,
                //   ),
                // ),
                // Text("${widget.productModel.shortDescription}",
                //   style: TextStyle(
                //     fontWeight: FontWeight.w400,
                //     color: Colors.black,
                //     fontSize: 12,
                //   ),
                // ),

                SizedBox(height: 15,),
                ExpansionTile(

                  collapsedBackgroundColor: Colors.grey.shade300,

                    title:Text("Détails du produit"),
                  children: [
                    Text("${widget.productModel.longDescription!}")
                  ],
                ),

                SizedBox(height: 20,),



                StreamBuilder(
                    stream: ProductController.getNewProduct(),
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
                        if(ProductModel.fromJson(i.data()).subCategory.toString().contains(widget.productModel!.subCategory.toString())){
                          if(ProductModel.fromJson(i.data()).id != widget.productModel!.id){
                            products.add(ProductModel.fromJson(i.data()));
                          }

                        }

                      }

                      print("products --- ${products.length}");

                      return Column(
                        children: [
                          products.isNotEmpty? Text("Produit similaire",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black
                            ),
                          ) : Center(),
                          SizedBox(height: 10,),
                          products.isNotEmpty?  GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10.0,
                              mainAxisSpacing: 20.0,
                              mainAxisExtent: 250,
                            ),
                            itemCount: products.length > 6 ? 6 : products.length,
                            itemBuilder: (context, index) {
                              return products[index].status == "Active" ? ItemCard(productModel: products[index],) : Center();
                            },
                          ) : Center(),
                        ],
                      );
                    }
                ),
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
                icon: Icon(Icons.percent_outlined),
                label: "Deals",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_basket_outlined),
                label: "Cart",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.manage_search),
                label: "Favorite",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.perm_identity),
                label: "Profile",
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

