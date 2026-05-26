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

  static Future getCategoryProduct(int id) async {
    final dio = Apiutil.dio;
    try {
      final response = await dio.get("/category/$id");
      if (response != null) {
        return response;
      }
    } catch (e) {
      print(e.toString());
    }
  }


}