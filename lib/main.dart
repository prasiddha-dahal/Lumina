import 'package:flutter/material.dart';
import 'package:flutterecommerce/bindings/controllers_binding.dart';
import 'package:flutterecommerce/routes/app_pages.dart';
import 'package:flutterecommerce/routes/app_routes.dart';
import 'package:flutterecommerce/views/home_view.dart';
import 'package:flutterecommerce/views/splash_view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
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
      initialBinding: ControllersBinding(),
      initialRoute: AppRoutes.splash,
      getPages: AppPages.routes,
    );
  }
}
