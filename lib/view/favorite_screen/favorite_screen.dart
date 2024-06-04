import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nectar/controller/favourite_controller.dart';
import 'package:nectar/model/product_model.dart';
import 'package:nectar/utility/app_color.dart';
import 'package:nectar/utility/app_const.dart';
import 'package:nectar/utility/fontsize.dart';
import 'package:nectar/view/detail_screen/detail_screen.dart';
import 'package:nectar/view/detail_screen/widgets/fav_check.dart';
import 'package:nectar/widget/app_button.dart';
import 'package:nectar/widget/app_network_images.dart';
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
    return Scaffold(

      backgroundColor: AppColors.bgWhite,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text("Préférée",
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
            FutureBuilder(
              future: FavouriteController.getFavProduct(),
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator(),);
                }else{
                  return Expanded(
                    child: snapshot.data!.isNotEmpty ? ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context,index){
                          var data = snapshot.data![index];
                          return ListTile(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailScreen(productModel: data)));
                            },
                            contentPadding: EdgeInsets.all(10),
                            shape: Border.symmetric(horizontal: BorderSide(color: Colors.grey.shade200)),
                            leading: AppNetworkImage(src: data.images![0], height: 60, width: 60,),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width*.42,
                                      child: Text("${data.name.toString()}",
                                        style: TextStyle(
                                          fontSize: titleFont,
                                          fontWeight: FontWeight.w600,
                                          color:AppColors.textBlack,
                                        ),
                                      ),
                                    ),
                                    Text("${data.categoryS!.categoryName!}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize:smallFont,
                                          color: AppColors.textGrey
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            trailing: FavWidgets(id: data.id.toString())

                          );
                        }) : Center(
                      child: Image.asset(Assets.norProduct, width: 200,),
                    ));
                }



              }
            ),
          ],
        ),
      ),
    );
  }
}
