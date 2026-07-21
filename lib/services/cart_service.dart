import 'package:flutterecommerce/controllers/storage_controller.dart';
import 'package:flutterecommerce/utils/apiUtil.dart';
import 'package:get/get.dart';

class CartService {
  static Future addToCart(int productId, int quantity) async {
    // get token first

    var controller = Get.find<StorageController>();

    final token = controller.getToken();

    // add token to the dio header
    Apiutil.dio.options.headers["Authorization"] = "Bearer $token";

    var response = await Apiutil.dio.post(
      "/cart",
      data: {"product_id": productId, "qty": quantity},
    );
    return response;
  }

  static Future fetchCartItems() async{

     // get token first
    var controller = Get.find<StorageController>();
    final token = controller.getToken();

    // add token to the dio header
    Apiutil.dio.options.headers["Authorization"] = "Bearer $token";

    var response = await Apiutil.dio.get(
      "/carts",
    );

    return response; 
  }

  static Future deleteCartItem(int cartId) async{
      // get token first
    var controller = Get.find<StorageController>();
    final token = controller.getToken();

    // add token to the dio header
    Apiutil.dio.options.headers["Authorization"] = "Bearer $token";

   var response = await Apiutil.dio.delete('/cart/$cartId');
    return response;
  }
}
