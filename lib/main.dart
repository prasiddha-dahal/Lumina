import 'package:flutter/material.dart';
import 'package:flutterecommerce/bindings/controllers_binding.dart';
import 'package:flutterecommerce/views/splash_view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async{
  await GetStorage.init();
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
      home: SplashView(),
      initialBinding: ControllersBinding(),
    );
  }
}
