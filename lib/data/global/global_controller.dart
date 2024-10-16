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

  double priceCalculat(double? product_regular_price, double? product_selling_price, double? product_whole_price) {
    print('Account Type: ${_accountController.myProfile.value.accountType}');
    print('Regular Price: $product_regular_price, Selling Price: $product_selling_price, Wholesale Price: $product_whole_price');

    double newPrice = 1.00; // Default value

    if (_accountController.myProfile.value.accountType == sellerAccount) {
      if (product_selling_price != null) {
        newPrice = product_selling_price;
      }
    } else if (_accountController.myProfile.value.accountType == restaurantAccount) {
      if (product_regular_price != null) {
        newPrice = product_regular_price;
      }
    } else if (_accountController.myProfile.value.accountType == wholeSellerAccount) {
      if (product_whole_price != null) {
        newPrice = product_whole_price;
      }
    }

    calculatedPrice.value = newPrice; // Update the reactive variable
    print('Calculated Price: $newPrice');
    return newPrice;
  }
  calculate(SingleProduct singleProduct) {
    var productType = singleProduct.productType;
    var unit = singleProduct.unit.toString();

    // Helper method to safely parse double values
    double safeParse(String value, {double defaultValue = 0.0}) {
      return double.tryParse(value) ?? defaultValue;
    }

    // Looping to find the product type
    for (var i = 0; i < unitList.length; i++) {
      if (productType == "KG (€ / Kg)") {
        var inG = 1000;
        double totalGram() {
          return safeParse(unit) * inG;
        }

        var oneGramPrice = GlobalVariables.gPrice.value / totalGram();
        GlobalVariables.productPriceInKg.value = oneGramPrice * inG;
        GlobalVariables.productTypeNameInKg.value = unitList[i]["kgName"];
        break;

      } else if (productType == "U (€ / U)" && unitList[i]["name"] == productType) {
        GlobalVariables.productPriceInKg.value = GlobalVariables.gPrice.value / safeParse(unit);
        GlobalVariables.productTypeNameInKg.value = unitList[i]["kgName"];
        break;

      } else if (unitList[i]["name"] == productType) {
        GlobalVariables.productPriceInKg.value = (GlobalVariables.gPrice.value / safeParse(unit)) * unitList[i]["inKg"];
        GlobalVariables.productTypeNameInKg.value = unitList[i]["kgName"];
        break;

      } else {
        GlobalVariables.productPriceInKg.value = GlobalVariables.gPrice.value;
        GlobalVariables.productTypeNameInKg.value = singleProduct.productType!;
      }
    }
  }

}
