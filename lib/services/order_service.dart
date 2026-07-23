import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutterecommerce/controllers/cart_controller.dart';
import 'package:flutterecommerce/controllers/storage_controller.dart';
import 'package:flutterecommerce/utils/apiUtil.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;

class OrderService {
  static Future placeOrder(File file) async {
    final cartController = Get.find<CartController>();
    final storageController = Get.find<StorageController>();

    final token = storageController.getToken();

    final items = cartController.cartItems.value.data
        .map(
          (p) => {
            "product_id": p.productId,
            "qty": p.quantity,
          },
        )
        .toList();

    Apiutil.dio.options.headers["Authorization"] = "Bearer $token";

    FormData formData = FormData.fromMap({
      "payment_receipt": await MultipartFile.fromFile(
        file.path,
        filename: file.path.split("/").last,
      ),

      // IMPORTANT
      "items": jsonEncode(items),
    });

    final response = await Apiutil.dio.post(
      "/order",
      data: formData,
    );

    return response;
  }
}