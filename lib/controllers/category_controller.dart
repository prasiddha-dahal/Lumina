import 'package:flutterecommerce/models/categories_model.dart';
import 'package:flutterecommerce/models/categories_product_model.dart';
import 'package:flutterecommerce/services/category_service.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  var isLoading = false.obs;
  var categories = CategoriesModel(success: false, data: []).obs;
  var categoryProduct = CategoriesProductModel(success: false, category: null).obs;


  Future fetchCategories() async {
    try {
      isLoading.value = true;
      final response = await CategoryService.getCategories();
      categories.value = CategoriesModel.fromJson(response.data);
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future fetchCategoryProduct(int id) async {
    try {
      isLoading.value = true;
      final response = await CategoryService.getCategoryProduct(id);
      categoryProduct.value = CategoriesProductModel.fromJson(response.data);
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchCategories();
  }
}
