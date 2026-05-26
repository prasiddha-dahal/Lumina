import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutterecommerce/controllers/category_controller.dart';
import 'package:flutterecommerce/controllers/product_controller.dart';
import 'package:flutterecommerce/views/product_view.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final productController = Get.find<ProductController>();
    final categoryController = Get.find<CategoryController>();
    return Scaffold(
      appBar: AppBar(title: Text("Ecom")),
      body: Obx(() {
        if (productController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return SingleChildScrollView(
            child: Column(
              children: [
                ListTile(
                  title: Text("Categories"),
                  subtitle: Text("Choose your categories"),
                ),
                Obx(() {
                  if (categoryController.isLoading.value) {
                    return LinearProgressIndicator();
                  } else {
                    return SizedBox(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            categoryController.categories.value.data.length,
                        itemBuilder: (context, index) {
                          final category =
                              categoryController.categories.value.data[index];

                          return Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Chip(label: Text("${category!.title}")),
                          );
                        },
                      ),
                    );
                  }
                }),
                // categories

                // product list
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: productController.products.value.data.length,
                  itemBuilder: (context, index) {
                    final product =
                        productController.products.value.data[index];
                    return ListTile(
                      onTap: () async {
                        await productController.fetchProductDetail(product.id);

                        Get.to(() => ProductView());
                      },
                      leading: CircleAvatar(
                        child: Image.network("${product.image}"),
                      ),
                      title: Text("${product.title}"),
                      subtitle: Html(
                        data: "${product.description}",
                        style: {
                          "body": Style(
                            maxLines: 2,
                            textOverflow: TextOverflow.ellipsis,
                            margin: Margins.zero,
                            padding: HtmlPaddings.zero,
                          ),
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
