import 'package:flutterecommerce/models/featured_product_model.dart';
import 'package:flutterecommerce/models/product_detail_model.dart';
import 'package:flutterecommerce/models/product_model.dart';
import 'package:flutterecommerce/services/product_service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProductController extends GetxController {
  var isLoading = false.obs;
  var products = ProductModel(success: false, data: []).obs;
  var product = ProductDetailModel(product: null).obs;
  var featuredProducts = FeaturedProductModel(success: false, data: []).obs;
  var quantityCount = 1.obs;

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
      quantityCount.value = 1;
      final response = await ProductService.getProductDetail(id);
      product.value = ProductDetailModel.fromJson(response.data);
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future fetchFeaturedProducts() async {
    try {
      isLoading.value = true;
      final response = await ProductService.getFeaturedProducts();
      featuredProducts.value = FeaturedProductModel.fromJson(response.data);
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void increment() {
    quantityCount.value = quantityCount.value + 1;
  }

  void decrement() {
    if (quantityCount.value > 1) {
      quantityCount.value = quantityCount.value - 1;
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchProducts();
    fetchFeaturedProducts();
  }
}
