import 'package:flutter/material.dart';
import 'package:flutterecommerce/controllers/auth_controller.dart';
import 'package:get/get.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    var authController = Get.find<AuthController>();
    authController.authCheck();
    return Scaffold(
      body: Center(child: Image.asset("images/splash.webp", fit: BoxFit.cover ,)),
    );
  }
}