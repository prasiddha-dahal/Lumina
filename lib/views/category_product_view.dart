import 'package:flutter/material.dart';
import 'package:flutterecommerce/controllers/category_controller.dart';
import 'package:flutterecommerce/controllers/product_controller.dart';
import 'package:flutterecommerce/views/product_view.dart';
import 'package:get/get.dart';

class CategoryProductView extends GetView<CategoryController> {
  const CategoryProductView({super.key});

  @override
  Widget build(BuildContext context) {
    ProductController productController = Get.find<ProductController>();
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx((){
              if(controller.isLoading.value){
                return Center(
                  child: CircularProgressIndicator(),
                );
              }else {
                return SizedBox(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.categoryProduct.value.category!.products.length,
                    itemBuilder: (context, index){
                      final product = controller.categoryProduct.value.category!.products[index];

                      return ListTile(
                        onTap: () async{
                          await productController.fetchProductDetail(product.id);
                          Get.to(() => ProductView());
                        },
                        leading: CircleAvatar(
                          child: Image.network("${product.image}"),
                        ),
                        title: Text("${product.title}"),
                      );


                  }),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
