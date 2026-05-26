import 'package:flutterecommerce/models/product_detail_model.dart';
import 'package:flutterecommerce/models/product_model.dart';
import 'package:flutterecommerce/services/product_service.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  var isLoading = false.obs;
  var products = ProductModel(success: false, data: []).obs;
  var product = ProductDetailModel(product: null).obs;


  Future fetchProducts() async {
    try {
      isLoading.value = true;
      final response = await ProductService.getProducts();
      products.value = ProductModel.fromJson(response.data);
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future fetchProductDetail(int id) async {
    try {
      isLoading.value = true;
      final response = await ProductService.getProductDetail(id);
      product.value = ProductDetailModel.fromJson(response.data);
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
    fetchProducts();
  }
}
