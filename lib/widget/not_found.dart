import 'package:flutter/material.dart';
import 'package:nectar/utility/assets.dart';

import '../generated/assets.dart';


class NotFound extends StatelessWidget {
  const NotFound({
    super.key,  this.name="Aucun produit à afficher ici",
  });
  final String? name;

  @override
  Widget build(BuildContext context) {
    return Center(child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(AppAssets.empty, height: 100,),
          Text(name!),
          //Text("Panier vide")
        ],
      ),
    ),);
  }
}
