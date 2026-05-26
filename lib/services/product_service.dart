import 'package:flutterecommerce/utils/apiUtil.dart';

class ProductService {
  static Future getProducts() async {
    final dio = Apiutil.dio;
    try {
      final response = await dio.get("/products");
      if (response != null) {
        return response;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  static Future getProductDetail(int id) async {
    final dio = Apiutil.dio;
    try {
      final response = await dio.get("/product/$id");
      if (response != null) {
        return response;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  static Future getFeaturedProducts() async {
    final dio = Apiutil.dio;
    try {
      final response = await dio.get("/featured-products");
      if (response != null) {
        return response;
      }
    } catch (e) {
      print(e.toString());
    }
  }

}
