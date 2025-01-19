import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nectar/view/detail_screen/controller/details_screen_controller.dart';
import 'package:nectar/widget/app_shimmer.dart';
import '../../shop_screen/widget/item_card.dart';
import '../../../data/models/product_model.dart';

class SimmilerProduct extends GetView<DetailsScreenController> {
  const SimmilerProduct(this.singleProduct, {super.key});

  final SingleProduct singleProduct;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Check if data is still being loaded
      if (controller.isGetRelatedProduct.value) {
        return SizedBox(
          height: 200,
          child: ListView.builder(
            padding: EdgeInsets.only(right: 10),
            itemCount: 5,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return AppShimmer();
            },
          ),
        );
      }

      // When data is loaded, show the product list
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Display "Produit similaire" if related products are available
          controller.relatedProduct.isNotEmpty
              ? const Text(
            "Produit à ajouter",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          )
              : Center(), // Show nothing or provide a fallback widget if empty

          SizedBox(height: 10),

          // Display the related products in a horizontal list
          SizedBox(
            height: 200,
            child: ListView.builder(
              padding: EdgeInsets.only(right: 10),
              itemCount: controller.relatedProduct.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                // Ensure the product isn't null before accessing it
                if (controller.relatedProduct[index] != null) {
                  return ItemCard(singleProduct: controller.relatedProduct[index]!);
                }
                return SizedBox(); // Return an empty widget if the product is null
              },
            ),
          ),
        ],
      );
    });
  }
}
