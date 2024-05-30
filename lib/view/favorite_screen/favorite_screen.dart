import 'package:flutter/material.dart';
import 'package:nectar/utility/app_color.dart';
import 'package:nectar/utility/fontsize.dart';
import 'package:nectar/widget/app_button.dart';
import 'package:nectar/widget/dialog.dart';

import '../../utility/assets.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: AppColors.bgWhite,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text("Favorite",
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: titleFont,
              color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
                itemBuilder: (context,index){
                  return ListTile(
                    contentPadding: EdgeInsets.all(10),
                    shape: Border.symmetric(horizontal: BorderSide(color: Colors.grey.shade200)),
                    leading: Image.asset(Assets.sprite,width: 60,),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Sprite Can",
                              style: TextStyle(
                                  fontSize: titleFont,
                                  fontWeight: FontWeight.w600,
                                  color:AppColors.textBlack,
                              ),
                            ),
                            Text("325ml, Price",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize:smallFont,
                                  color: AppColors.textGrey
                              ),
                            ),
                          ],
                        ),
                        Text("\$1.50",style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black,fontSize: normalFont),)
                      ],
                    ),
                    trailing: Icon(Icons.keyboard_arrow_right,color: Colors.black,),

                  );
                })),
            Padding(
              padding: const EdgeInsets.only(left: 20.0,right: 20,),
              child: AppButton(
                bgColor: AppColors.bgGreen,
                  name: "Add All To Cart", onClick: ()=>dialogBox(context)),
            )

          ],
        ),
      ),
    ));
  }
}
