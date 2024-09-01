import 'package:flutter/material.dart';
import 'package:nectar/model/product_model.dart';
import '../../../utility/app_const.dart';


class ProductTypeWithPrice extends StatefulWidget {
  final ProductModel productModel;
  final String role;
  const ProductTypeWithPrice({super.key, required this.productModel, required this.role});

  @override
  State<ProductTypeWithPrice> createState() => _ProductTypeWithPriceState();
}

class _ProductTypeWithPriceState extends State<ProductTypeWithPrice> {

  double productPriceInKg = 0.00;
  var productTypeNameInKg;
  var productPrice;

  void calculate()async{
    if(widget.role == sellerAccount){
      productPrice = widget.productModel.sellingPrice;
    }else if( widget.role == restaurantAccount){
      productPrice = widget.productModel.regularPrice;
    }else if(widget.role == wholeSellerAccount){
      productPrice = widget.productModel.wholePrice;
    }else{
      productPrice = 0.00;
    }

    var productType = widget.productModel!.productType;
    //looping to find the product type
    for(var i = 0; i < unitList.length; i++){
      print("unitList[i] name fuck --- ${productType}");
      if(productType == "KG (€ / Kg)"){
        var inG = 1000;
        var totalGram = double.parse(widget.productModel!.unit.toString()) * inG;
        var oneGramPrice = double.parse(productPrice) /double.parse(totalGram.toString()) ;
        productPriceInKg = oneGramPrice * inG;
        productTypeNameInKg = unitList[i]["kgName"];
        break;
      }else if(productType == "U (€ / U)" && unitList[i]["name"] == productType){
        productPriceInKg = double.parse(productPrice) /double.parse(widget.productModel!.unit.toString());
        productTypeNameInKg = unitList[i]["kgName"];
        break;
      }else if(unitList[i]["name"] == productType){
        productPriceInKg = (double.parse(productPrice) / double.parse(widget.productModel!.unit.toString())) * unitList[i]["inKg"];
        productTypeNameInKg = unitList[i]["kgName"];
        break;
      }else{
         productPriceInKg = double.parse(productPrice.toString());
            productTypeNameInKg = widget.productModel!.productType;
      }
    }



    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    calculate();
    print("role --- ${widget.role}");

  }

  @override
  Widget build(BuildContext context) {
    return Text("${productPriceInKg.toStringAsFixed(2)} € / 1 ${productTypeNameInKg}",
      style: const TextStyle(
          fontSize: 12, fontWeight: FontWeight.w300, color: Colors.black
      ),
    );
  }
}


