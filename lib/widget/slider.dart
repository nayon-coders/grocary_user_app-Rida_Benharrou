import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CarouserSlider extends StatelessWidget {
  const CarouserSlider({
    super.key,
    required this.images,
  });

  final List<Widget> images;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items:images ,
        options: CarouselOptions(
          height: 160,
          viewportFraction:1,
          initialPage: 0,
          enableInfiniteScroll: true,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),

        )
    );
  }
}