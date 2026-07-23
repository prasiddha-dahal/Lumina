import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutterecommerce/services/order_service.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class OrderController extends GetxController {
  final isLoading = false.obs;

  final imagePicker = ImagePicker();

  final image = Rxn<File>();

  Future<void> pickImage() async {
    final XFile? pickedFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      image.value = File(pickedFile.path);
    }
  }

  Future<void> placeOrder(File file) async {
    try {
      isLoading.value = true;

      final response = await OrderService.placeOrder(file);

      Get.snackbar(
        "Success",
        response.data["message"] ?? "Order placed successfully",
      );
      Get.snackbar(
        "Error",
        "something went wrong"
      );
    } catch (e) {

      Get.snackbar(
        "Error",
        e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }
}