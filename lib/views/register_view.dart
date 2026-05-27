import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutterecommerce/controllers/auth_controller.dart';
import 'package:flutterecommerce/utils/screen_size.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class RegisterView extends GetView<AuthController> {
  const RegisterView({super.key});

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
                        Text("Register"),
                        Gap(ScreenSize.vGap),
                        //username
                        TextFormField(
                          controller: controller.name,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            hint: Text("Enter your Full Name"),
                            label: Text("Username"),
                          ),
                        ),

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
                        TextFormField(
                          controller: controller.password,
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.visibility_off),
                            ),
                            hint: Text("Enter Password"),
                            label: Text("Password"),
                          ),
                        ),

                        Gap(ScreenSize.vGap),
                        Gap(ScreenSize.vGap),

                        // register button
                        Row(
                          children: [
                            Expanded(
                              child: FilledButton(
                                onPressed: () async{ 
                                  Loader.show(context);
                                  await controller.register();
                                  Loader.hide();
                                },
                                child: Text("Register"),
                              ),
                            ),
                          ],
                        ),

                        Gap(ScreenSize.vGap),

                        //Already have an account
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already hava an account? "),
                            GestureDetector(onTap: () {}, child: Text("Login", style: TextStyle(color: Colors.deepOrange),)),
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
