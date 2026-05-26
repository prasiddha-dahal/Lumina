import 'package:flutterecommerce/controllers/product_controller.dart';
import 'package:get/get.dart';

class ControllersBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ProductController>(ProductController(),permanent: true);
  }

}