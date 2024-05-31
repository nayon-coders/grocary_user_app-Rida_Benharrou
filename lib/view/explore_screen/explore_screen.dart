import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nectar/utility/app_color.dart';
import 'package:nectar/utility/fontsize.dart';
import 'package:nectar/view/explore_screen/widget/category_card.dart';
import 'package:nectar/view/shop_screen/widget/item_card.dart';
import 'package:nectar/widget/app_input.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: AppColors.bgWhite,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text("Trouver des produits",
                style: TextStyle(
                    fontSize: titleFont,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.75,
                  child: AppInput(
                    prefixIcon: Icon(Icons.search,color: Colors.black,),
                      controller: _searchController,
                      hintText: "Rechercher dans le magasin",
                  ),
                ),
                SizedBox(width: 15,),
                InkWell(
                  onTap: (){

                  },
                    child: Icon(Icons.swap_horiz,size: 30,color: AppColors.textBlack,),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Expanded(
              child: GridView.builder(
                itemCount: 10,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                    childAspectRatio: 0.85,
                  ),
                  itemBuilder: (context,index){
                    return CategoryCard();
                  },
                  ),
            ),
          ],
        ),
      ),
    ));
  }
}
