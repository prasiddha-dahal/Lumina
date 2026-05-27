import 'package:flutter/material.dart';
import 'package:flutterecommerce/models/register_model.dart';
import 'package:flutterecommerce/services/auth_service.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  var registerUser = RegisterModel(
    success: false,
    token: null,
    message: null,
  ).obs;
  var name = TextEditingController();
  var email = TextEditingController();
  var password = TextEditingController();

  Future register() async {
    try {
      isLoading(true);
      var response = await AuthService.register(
        name.text,
        email.text,
        password.text,
      );
      if (response != null) {
        registerUser.value = RegisterModel.fromJson(response.data);
        if (registerUser.value.success == true) {
          name.clear();
          email.clear();
          password.clear();
          Get.snackbar(
            "Success",
            "Account created successfully",
            backgroundColor: Colors.greenAccent,
          );
        } else {
          Get.snackbar(
            "Error",
            "Invalid Credentials",
            backgroundColor: Colors.redAccent,
          );
        }
      }
    } finally {
      isLoading(false);
    }
  }
}
