import 'package:flutter/material.dart';
import 'package:nectar/utility/app_color.dart';
import 'package:nectar/view/account_screen/account_screen.dart';
import 'package:nectar/view/cart_screen/cart_screen.dart';
import 'package:nectar/view/explore_screen/explore_screen.dart';
import 'package:nectar/view/favorite_screen/favorite_screen.dart';
import 'package:nectar/view/shop_screen/shop_screen.dart';

class NavigationScreen extends StatefulWidget {
  final int pageIndex;
  const NavigationScreen({super.key, this.pageIndex = 0});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
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
    _selectedIndex = widget.pageIndex;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                label: "Browse",
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
