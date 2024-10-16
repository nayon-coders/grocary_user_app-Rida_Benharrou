// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:nectar/widget/app_network_images.dart';
//
// import '../utility/app_const.dart';
//
// class CarouserSlider extends StatelessWidget {
//   const CarouserSlider({
//     super.key,
//     required this.images,
//   });
//
//   final List<Widget> images;
//
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return StreamBuilder(
//       stream: FirebaseFirestore.instance.collection(bannerCollection).snapshots(),
//       builder: (context, snapshot) {
//         if(snapshot.connectionState == ConnectionState.waiting){
//           return Center(child: CircularProgressIndicator(),);
//         }
//
//         List<BannerModel> banners = [];
//         for(var i in snapshot.data!.docs!){
//           banners.add(BannerModel.fromJson(i.data()));
//         }
//         return CarouselSlider(
//             items: banners.map((e) => AppNetworkImage(src: e.image.toString(), height: 160, width: size.width, fit: BoxFit.cover,),).toList(),
//             options: CarouselOptions(
//               height: 160,
//               viewportFraction:1,
//               initialPage: 0,
//               enableInfiniteScroll: true,
//               autoPlay: true,
//               autoPlayInterval: Duration(seconds: 4),
//
//             )
//         );
//       }
//     );
//   }
// }