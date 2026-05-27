import 'package:flutter/material.dart';
import 'package:flutterecommerce/bindings/controllers_binding.dart';
import 'package:flutterecommerce/views/home_view.dart';
import 'package:flutterecommerce/views/register_view.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.orange)),
      home: RegisterView(),
      initialBinding: ControllersBinding(),
    );
  }
}
