import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutterecommerce/controllers/product_controller.dart';
import 'package:get/get.dart';

class ProductView extends GetView<ProductController> {
  const ProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Obx(() {
        if(controller.isLoading.value){
          return LinearProgressIndicator();
        }else {
          return SingleChildScrollView(
        child: Column(
          children: [
            Image.network("${controller.product.value.product!.image}"),
            Text("${controller.product.value.product!.title}"),
            Html(data:"${controller.product.value.product!.description }"),
          ],
        ),
      );
        }
      })
    );
  }
}