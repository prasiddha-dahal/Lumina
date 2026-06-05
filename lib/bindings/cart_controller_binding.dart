import 'package:flutterecommerce/controllers/cart_controller.dart';
import 'package:get/get.dart';

class CartControllerBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<CartController>(CartController(),permanent: true);
  }

}