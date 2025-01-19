import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nectar/view/category_prodouct/controller/category_product_controller.dart';
import 'package:nectar/view/shop_screen/widget/item_card.dart';
import '../../data/models/product_model.dart';
import '../../utility/fontsize.dart';
import '../shop_screen/controller/home_controller.dart';


class AllProducts extends StatefulWidget {
  final String title;
  final List<SingleProduct> products;
  const AllProducts({super.key, required this.title, required this.products});

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  final HomeController controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("${widget.title}",
            style: TextStyle(
              fontSize: titleFont,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white
      ),
      backgroundColor: Colors.white,

      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 5.0,
            mainAxisSpacing: 5.0,
            mainAxisExtent: 200
          ),
          itemCount: widget.products.length,
          itemBuilder: (context, index) {
            return ItemCard(singleProduct: widget.products[index]);
          },
        )
      ),
    );
  }
}
