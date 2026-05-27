import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutterecommerce/controllers/auth_controller.dart';
import 'package:flutterecommerce/utils/screen_size.dart';
import 'package:flutterecommerce/views/register_view.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class LoginView extends GetView<AuthController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenSize.screenPadding,
                  ),
                  child: Form(
                    child: Column(
                      children: [
                        Text("Login"),
                        Gap(ScreenSize.vGap),
                        //email
                        TextFormField(
                          controller: controller.email,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            hint: Text("Enter Email"),
                            label: Text("Email"),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),

                        Gap(ScreenSize.vGap),

                        //password
                        Obx(() {
                          return TextFormField(
                            controller: controller.password,
                            obscureText: !controller.isVisible.value,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  controller.toggleEye();
                                },
                                icon: controller.isVisible.value == true
                                    ? Icon(Icons.visibility_off)
                                    : Icon(Icons.visibility),
                              ),
                              hint: Text("Enter Password"),
                              label: Text("Password"),
                            ),
                          );
                        }),

                        Gap(ScreenSize.vGap),
                        Gap(ScreenSize.vGap),

                        //login button
                        Row(
                          children: [
                            Expanded(
                              child: FilledButton(
                                onPressed: () async {
                                  Loader.show(context);
                                    await controller.login();
                                    Loader.hide();
                                },
                                child: Text("Login"),
                              ),
                            ),
                          ],
                        ),

                        Gap(ScreenSize.vGap),

                        //new user?
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("New User? "),
                            GestureDetector(
                              onTap: () {
                                Get.off(() => RegisterView());
                              },
                              child: Text(
                                "Register",
                                style: TextStyle(color: Colors.deepOrange),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
