import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';


class AppShimmer extends StatelessWidget {
  const AppShimmer({super.key,  this.height = 100,  this.width = 100});

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: height,
      height: width,
      child: Shimmer.fromColors(
        baseColor: Colors.white,
        highlightColor: Colors.grey.shade200,
        child: Container(
          color: Colors.white,
        )
      ),
    );
  }
}
