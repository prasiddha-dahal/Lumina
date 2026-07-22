import 'package:flutterecommerce/models/add_to_cart_model.dart';
import 'package:flutterecommerce/models/cart_model.dart';
import 'package:flutterecommerce/models/delete_cart_item_model.dart';
import 'package:flutterecommerce/models/update_cart_model.dart';
import 'package:flutterecommerce/services/cart_service.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var isLoading = false.obs;
  var addToCartResponse = AddToCartModel(success: false, message: null).obs;
  var cartItems = CartModel(sucess: false, data: []).obs;
  var deleteCart = DeleteCartItemModel(success: false, message: null).obs;
  var updateCart = UpdateCartModel(success: false, message: null).obs;

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
    }catch(e){
        print(e.toString());
    }finally {
      isLoading.value = false;
    }
  }

  Future deleteCartItem(int cartId) async {
    try {
      isLoading.value = true;
      var response = await CartService.deleteCartItem(cartId);
      if (response != null) {
        deleteCart.value = DeleteCartItemModel.fromJson(response.data);
      }
      if(deleteCart.value.success == true){
        Get.snackbar("Success", "Item Successfully deleted");
      }else{
        Get.snackbar("Failed", "Something went wrong");
      }

    }catch(e){
        print(e.toString());
    }finally {
      isLoading.value = false;
    }
  }

    Future updateCartItem(int cartId, int productId, int quantity) async{
      try{
        isLoading.value = true;
        var response = await CartService.updateCart(cartId, productId, quantity);
        if(response != null){
          updateCart.value = UpdateCartModel.fromJson(response.data);
        }
        if(updateCart.value.success == true){
          Get.snackbar("Success", "${updateCart.value.message}");
        }else{
          Get.snackbar("Failed", "${updateCart.value.message}");
        }
      }finally{
        isLoading.value = false;
      }

  }

  @override
  void onInit() {
    super.onInit();
    fetchCartItems();
  }
}
