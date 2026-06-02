import 'package:flutter/material.dart';
import 'package:flutterecommerce/controllers/storage_controller.dart';
import 'package:flutterecommerce/models/login_model.dart';
import 'package:flutterecommerce/models/register_model.dart';
import 'package:flutterecommerce/services/auth_service.dart';
import 'package:flutterecommerce/views/home_view.dart';
import 'package:flutterecommerce/views/login_view.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  var registerUser = RegisterModel(
    success: false,
    token: null,
    message: null,
  ).obs;
  var loginUser = LoginModel(success: false, token: null, message: null).obs;
  var name = TextEditingController();
  var email = TextEditingController();
  var password = TextEditingController();

  var isVisible = false.obs;

Future<void> authCheck() async {
  var storageController = Get.find<StorageController>();

  final token = await storageController.getToken();

  await Future.delayed(const Duration(seconds: 3));

  if (token == null) {
    Get.off(() => const LoginView());
  } else {
    Get.off(() => const HomeView());
  }
} 

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

  Future login() async {
    try {
      isLoading(true);
      var response = await AuthService.login(email.text, password.text);
      if (response != null) {
        loginUser.value = LoginModel.fromJson(response.data);
        if (loginUser.value.success == true) {
          var storageController = Get.find<StorageController>();
          String? token = loginUser.value.token;
          storageController.saveToken(token!);

          email.clear();
          password.clear();
          Get.snackbar(
            "Success",
            "Login successfully",
            backgroundColor: Colors.greenAccent,
          );
          Get.offAll(() => HomeView());
        } else {
          Get.snackbar(
            "Error",
            "Something went wrong",
            backgroundColor: Colors.redAccent,
          );
        }
      }
    } finally {
      isLoading(false);
    }
  }

  void toggleEye() {
    isVisible.value = !isVisible.value;
  }

  @override
  void onInit() {
    super.onInit();
    authCheck();
  }
}
