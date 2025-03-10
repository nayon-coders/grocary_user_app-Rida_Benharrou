import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nectar/data/global/global_controller.dart';
import 'package:nectar/data/global/global_variable.dart';
import 'package:nectar/view/favorite_screen/controller/fav_controller.dart';

class FavWidgets extends GetView<FavController> {
  final String id;

  const FavWidgets({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    //init checkFavProduct function
    //widgetInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.checkFavProduct(id.toString());
    });

    return InkWell(
      onTap: () {
        controller.isFavProduct.value
            ? controller.removeFavProduct(id)
            : controller.addFavProduct(id); // add or remove fav product


      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(100),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 1, spreadRadius: 1
              )
            ]
        ),
        child: Obx(() {
          return  controller.isFavProduct.value
              ? const Icon(Icons.favorite, color: Colors.red)
              : const Icon(Icons.favorite_border, color: Colors.red);
        }
        ),
      ),
    );
  }
}
