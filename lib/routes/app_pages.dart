import 'package:flutterecommerce/routes/app_routes.dart';
import 'package:flutterecommerce/views/cart_view.dart';
import 'package:flutterecommerce/views/category_product_view.dart';
import 'package:flutterecommerce/views/home_view.dart';
import 'package:flutterecommerce/views/login_view.dart';
import 'package:flutterecommerce/views/product_view.dart';
import 'package:flutterecommerce/views/register_view.dart';
import 'package:flutterecommerce/views/splash_view.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppPages {
  static var routes = [
    GetPage(name: AppRoutes.splash, page: () => SplashView()),
    GetPage(name: AppRoutes.login, page: () => LoginView()),
    GetPage(name: AppRoutes.register, page: () => RegisterView()),
    GetPage(name: AppRoutes.home, page: () => HomeView()),
    GetPage(name: AppRoutes.productDetail, page: () => ProductView()),
    GetPage(name: AppRoutes.productByCategries, page: () => CategoryProductView()),
    GetPage(name: AppRoutes.carts, page: () => CartView()),
  ];
}