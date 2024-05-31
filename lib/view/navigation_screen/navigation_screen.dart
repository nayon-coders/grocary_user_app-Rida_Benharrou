import 'package:flutter/material.dart';
import 'package:nectar/utility/app_color.dart';
import 'package:nectar/view/account_screen/account_screen.dart';
import 'package:nectar/view/cart_screen/cart_screen.dart';
import 'package:nectar/view/explore_screen/explore_screen.dart';
import 'package:nectar/view/favorite_screen/favorite_screen.dart';
import 'package:nectar/view/shop_screen/shop_screen.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedIndex = 0;
  static const List pages =[
    ShopScreen(),
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
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
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
          backgroundColor: Colors.grey.shade100,
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: onItem,

          selectedItemColor: AppColors.bgGreen,
            selectedLabelStyle: TextStyle(color: AppColors.bgGreen),
            unselectedItemColor: AppColors.textGrey,
            unselectedLabelStyle: TextStyle(color:AppColors.textGrey),
            items: [
              BottomNavigationBarItem(

                icon: Icon(Icons.house_outlined),
              label: "Boutique",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.menu_open),
                label: "Explorer",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: "Chariot",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border),
                label: "Préférée",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Compte",
              ),
            ]
        ),
      ),

    ));
  }
}
