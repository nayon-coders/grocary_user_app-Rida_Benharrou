import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nectar/data/models/product_model.dart';
import 'package:nectar/utility/app_color.dart';
import 'package:nectar/utility/fontsize.dart';
import 'package:nectar/view/detail_screen/detail_screen.dart';
import 'package:nectar/view/favorite_screen/controller/fav_controller.dart';
import 'package:nectar/widget/app_network_images.dart';
import '../../widget/app_dialog.dart';

class FavoriteScreen extends GetView<FavController> {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: AppColors.bgWhite,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text("Mes favoris",
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: titleFont,
              color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Obx(() {
              if(controller.isLoading.value){
                return Center(child: CircularProgressIndicator());
              }else if(controller.favProduct.value.data == null){
                return Center(
                  child: Text("Aucun produit favori trouvé"),
                );

              }else{
                return ListView.builder(
                    itemCount: controller.favProduct.value.data!.length,
                    itemBuilder: (context,index){
                      var data = controller.favProduct.value.data![index];
                      return ListTile(
                        onTap: (){
                          Get.to(DetailScreen(productId: data.productId.toString()));
                         //  Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailScreen(singleProduct: data)));
                        },
                        contentPadding: EdgeInsets.all(10),
                        shape: Border.symmetric(horizontal: BorderSide(color: Colors.grey.shade200)),
                        leading: AppNetworkImage(src: data.images![0]!.imageUrl!, height: 50, width: 50,),
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
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color:AppColors.textBlack,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red,),
                          onPressed: (){
                            AppDialog(
                                context,
                                "Supprimer",
                                "Voulez-vous vraiment supprimer ce produit de vos favoris?",
                                    (){
                                      controller.removeFavProduct(data.productId.toString());
                                      Get.back();
                                    }
                            );

                          },
                        )

                      );
                    });
              }

          }
        ),
      ),
    );
  }
}
