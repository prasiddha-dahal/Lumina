import 'package:flutter/material.dart';
import 'package:flutterecommerce/controllers/cart_controller.dart';
import 'package:get/get.dart';

class CartView extends GetView<CartController> {
  const CartView({super.key});
  @override

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Obx(() {
          if (controller.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.cartItems.value.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      var product = controller.cartItems.value.data[index];
                      ListTile(
                        title: Text("${product.productName}"),
                      );
                    },
                  ),
                ],
              ),
            );
          }
        }),
      ),
    );
  }
}
