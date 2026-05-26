import 'package:dio/dio.dart';

class ProductService {
  static Future getProducts() async {
    Dio dio = Dio(
      BaseOptions(baseUrl: "https://ecommerce.codeitappsware.com/api"),
    );
    try {
      final response = await dio.get("/products");
      if (response != null) {
        return response;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
