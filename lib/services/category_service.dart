import 'package:flutterecommerce/utils/apiUtil.dart';

class CategoryService {
  static Future getCategories() async {
    final dio = Apiutil.dio;
    try {
      final response = await dio.get("/categories");
      if (response != null) {
        return response;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}