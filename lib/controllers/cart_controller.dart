import 'package:flutterecommerce/models/add_to_cart_model.dart';
import 'package:flutterecommerce/services/cart_service.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var isLoading = false.obs;
  var addToCartResponse = AddToCartModel(success: false, message: null).obs;

  Future addToCart(int productId, int quantity) async {
    try {
      isLoading.value = true;
      var response = await CartService.addToCart(productId, quantity);
      addToCartResponse.value = AddToCartModel.fromJson(response.data);

      if (addToCartResponse.value.success == true) {
        Get.snackbar("Success", "items added to cart");
      } else {
        Get.snackbar("Failed", "Something went wrong");
      }
    } finally {}
  }
}
