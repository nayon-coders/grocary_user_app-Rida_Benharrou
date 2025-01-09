import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:nectar/data/global/global_variable.dart';
import 'package:nectar/data/models/product_model.dart';
import 'package:nectar/view/account_screen/controller/acocunt_controller.dart';

import '../../utility/app_const.dart';

class GlobalController extends GetxController {
  var userRole = "".obs;


  AccountController _accountController = Get.find();

  RxDouble calculatedPrice = 1.0.obs; // Make the price reactive

  double priceCalculat(dynamic? product_regular_price, dynamic? product_selling_price, dynamic? product_whole_price, dynamic? supper_marcent) {
    print('Account Type: ${_accountController.myProfile.value.accountType}');
    print('Regular Price: $product_regular_price, Selling Price: $product_selling_price, Wholesale Price: $product_whole_price');

    double newPrice = 0.00; // Default value

    if (_accountController.myProfile.value.accountType == sellerAccount) {
      if (product_selling_price != null) {
        newPrice = double.parse("$product_selling_price"); // Set the selling price
      }
    } else if (_accountController.myProfile.value.accountType == restaurantAccount) {
      if (product_regular_price != null) {
        newPrice = double.parse("${product_regular_price}"); // Set the regular price
      }
    } else if (_accountController.myProfile.value.accountType == wholeSellerAccount) {
      if (product_whole_price != null) {
        newPrice = double.parse("$product_whole_price"); // Set the wholesale price
      }
    }else if (_accountController.myProfile.value.accountType == supperMarcent) {
      if (supper_marcent != null) {
        newPrice = double.parse("$supper_marcent"); // Set the supper marcent
      }
    }

    calculatedPrice.value = newPrice; // Update the reactive variable
    print('Calculated Price: $newPrice');
    return newPrice;
  }
  String calculate(SingleProduct singleProduct) {
    var productType = singleProduct.unit.toString();
    var unit = singleProduct.uvw.toString();

    print(":productType -- ${productType}");

    // Helper method to safely parse double values
    double safeParse(String value, {double defaultValue = 0.0}) {
      return double.tryParse(value) ?? defaultValue;
    }

print("GlobalVariables.productTypeNameInKg.value -- ${GlobalVariables.productTypeNameInKg.value}");
    if(productType.toString().contains("KG (€ / KG)")) {
      return GlobalVariables.productTypeNameInKg.value = "KG";
    }else if(productType.toString().contains("G (€ / G)")) {
      return GlobalVariables.productTypeNameInKg.value = "G";
    }else if(productType.toString().contains("MG (€ / MG)")) {
      return GlobalVariables.productTypeNameInKg.value = "MG";
    }else if(productType.toString().contains("ML (€ / ML)")) {
      return GlobalVariables.productTypeNameInKg.value = "ML";
    }else if(productType.toString().contains("L (€ / L)")) {
      return GlobalVariables.productTypeNameInKg.value = "L";
    }else if(productType.toString().contains("CM (€ / CM)")) {
      return GlobalVariables.productTypeNameInKg.value = "CM";
    }else if(productType.toString().contains("MM (€ / MM)")) {
      return GlobalVariables.productTypeNameInKg.value = "MM";
    }else if(productType.toString().contains("U (€ / U)")) {
      return GlobalVariables.productTypeNameInKg.value = "U";
    }else{
      return GlobalVariables.productTypeNameInKg.value = "uck";
    }


  }

}
