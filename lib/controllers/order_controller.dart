import 'dart:io';

import 'package:flutterecommerce/controllers/cart_controller.dart';
import 'package:flutterecommerce/routes/app_routes.dart';
import 'package:flutterecommerce/services/order_service.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class OrderController extends GetxController {
  var cartController = Get.find<CartController>();
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
      if(response != null){
        await cartController.fetchCartItems();
        Get.offNamed(AppRoutes.orderComplete);
      }
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