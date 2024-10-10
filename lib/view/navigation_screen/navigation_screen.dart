import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nectar/controller/cart_controller.dart';
import 'package:nectar/data/global/global_controller.dart';
import 'package:nectar/utility/app_color.dart';
import 'package:nectar/view/account_screen/account_screen.dart';
import 'package:nectar/view/auth/controller/auth_controller.dart';
import 'package:nectar/view/cart_screen/cart_screen.dart';
import 'package:nectar/view/explore_screen/explore_screen.dart';
import 'package:nectar/view/favorite_screen/controller/fav_controller.dart';
import 'package:nectar/view/favorite_screen/favorite_screen.dart';
import 'package:nectar/view/shop_screen/controller/home_controller.dart';
import 'package:nectar/view/shop_screen/shop_screen.dart';

import '../cart_screen/controller/car_controller.dart';

class NavigationScreen extends StatefulWidget {
  final int pageIndex;
  const NavigationScreen({super.key, this.pageIndex = 0});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {

  //cart new controller init
  final CartControllerNew carControllerNew = Get.find<CartControllerNew>();
  int _selectedIndex = 0;
  static const List pages =[
    Home(),
    ExploreScreen(),
    CartScreen(),
    FavoriteScreen(),
    AccountScreen(),
  ];

  void onItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.put(GlobalController());
    _selectedIndex = widget.pageIndex;
  }



  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        Get.find<HomeController>().getAllProduct();
        Get.find<HomeController>().getAllCategory();
        Get.find<FavController>().getFavProduct();
        Get.find<AuthController>().getMyProfile();
        Get.find<CartControllerNew>().getCartProduct();
      },
      child: Scaffold(
        backgroundColor:Colors.white,
        body: Center(
          child: pages.elementAt(_selectedIndex),
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

      ),
    );
  }
}
