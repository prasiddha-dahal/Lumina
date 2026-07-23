import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutterecommerce/controllers/cart_controller.dart';
import 'package:flutterecommerce/controllers/storage_controller.dart';
import 'package:flutterecommerce/utils/apiUtil.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;

class OrderService {
  static Future placeOrder(File file) async{
    final cartController = Get.find<CartController>();

    // get token
    var storageController = Get.find<StorageController>();
    var token = storageController.getToken();

    var items = cartController.cartItems.value.data.map((p) => {
      "product_id" : p.productId,
      "qty": p.quantity
    }).toList();

    // add token to the dio header
    Apiutil.dio.options.headers["Authorization"] = "Bearer $token";
    FormData formData = FormData.fromMap({
      "payment_receipt": await MultipartFile.fromFile(
        file.path,
        filename: file.path.split("/").last
      ),
      "items": items
    });

    var response = Apiutil.dio.post('/orders', data: formData);





  }
}