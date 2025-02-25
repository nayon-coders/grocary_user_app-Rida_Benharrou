// import 'package:flutter/material.dart';
// import 'package:nectar/widget/app_shimmer.dart';
//
// import '../../../utility/app_color.dart';
// import '../../../utility/fontsize.dart';
// import '../../show_product/all_products.dart';
// import 'item_card.dart';
//
//
// class BestSellingProducts extends StatelessWidget {
//   const BestSellingProducts({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//         stream: ProductController.getBestSellingProducts(),
//         builder: (context, snapshot) {
//           if(snapshot.connectionState == ConnectionState.waiting){
//             return SizedBox(
//               height: 250,
//               child: ListView.builder(
//                   padding: EdgeInsets.only(right: 10),
//                   itemCount: 5,
//                   scrollDirection: Axis.horizontal,
//                   itemBuilder: (context,index){
//                     return AppShimmer();
//                   }),
//             );
//           }
//
//
//           //store data into product model list
//           List<ProductModel> products = [];
//
//           for(var i in snapshot.data!.docs){
//             products.add(ProductModel.fromJson(i.data()));
//           }
//
//           print("products --- ${products.length}");
//
//           return products.isNotEmpty ? Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Text("Meilleure vente",style: TextStyle(fontSize:titleFont,fontWeight: FontWeight.w600,color: Colors.black),),
//                   InkWell(
//                       onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> AllProducts(title: "Offre exclusive",))),
//                       child: Text("Voir tout",style: TextStyle(fontSize:smallFont,fontWeight: FontWeight.w600,color:AppColors.bgGreen),)),
//
//                 ],
//               ),
//               SizedBox(height: 10,),
//               // SizedBox(
//               //     height: 230,
//               //     child: ListView.builder(
//               //     padding: EdgeInsets.only(right: 10),
//               //     itemCount: products.length,
//               //     scrollDirection: Axis.horizontal,
//               //     itemBuilder: (context,index){
//               //     return products[index].status == "Active" ? ItemCard(singleProduct: products[index],) : Center();
//               //     }),
//               // )
//
//             ],
//           )  :Center();
//         }
//     );
//   }
// }
