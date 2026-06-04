import 'package:flutterecommerce/models/add_to_cart_model.dart';
import 'package:flutterecommerce/models/cart_model.dart';
import 'package:flutterecommerce/services/cart_service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CartController extends GetxController {
  var isLoading = false.obs;
  var addToCartResponse = AddToCartModel(success: false, message: null).obs;
  var cartItems = CartModel(sucess: false, data: []).obs;

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
    } finally {
      isLoading.value = false;
    }
  }

  Future fetchCartItems() async {
    try {
      isLoading.value = true;
      var response = await CartService.fetchCartItems();
      if (response != null) {
        cartItems.value = CartModel.fromJson(response.data);
      }
    } finally {
      isLoading.value = false;
    }
  }
}
