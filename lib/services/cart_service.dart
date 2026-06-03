import 'package:flutterecommerce/controllers/storage_controller.dart';
import 'package:get/get.dart';

class CartService {
  static Future addToCart() async{
    // get token first

    var controller = Get.find<StorageController>();

    final token = controller.getToken();


  }
}