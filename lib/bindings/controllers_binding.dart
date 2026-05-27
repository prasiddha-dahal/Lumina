import 'package:flutterecommerce/controllers/auth_controller.dart';
import 'package:flutterecommerce/controllers/category_controller.dart';
import 'package:flutterecommerce/controllers/product_controller.dart';
import 'package:get/get.dart';

class ControllersBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ProductController>(ProductController(),permanent: true);
    Get.put<CategoryController>(CategoryController(),permanent: true);
    Get.put<AuthController>(AuthController(),permanent: true);
  }

}