import 'package:flutter/material.dart';
import 'package:flutterecommerce/controllers/cart_controller.dart';
import 'package:flutterecommerce/models/product_detail_model.dart';
import 'package:get/get.dart';

class OrderView extends StatelessWidget {
  const OrderView({super.key});

  @override
  Widget build(BuildContext context) {
    var cartController = Get.find<CartController>();
    return Scaffold(
      appBar: AppBar(title: Text("Order")),
      body: SafeArea(
        child: Obx(() {
          return SingleChildScrollView(
            child: Column(
              children: [
                //upload the payment receipt button
                FilledButton(
                  onPressed: () {},
                  child: Text("Upload Payment Receipt"),
                ),

                //image

                //cart items
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: cartController.cartItems.value.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    var product = cartController.cartItems.value.data[index];
                    return ListTile(
                      leading: CircleAvatar(backgroundImage: NetworkImage("${product.productImage}"),),
                      title: Text("${product.productName}"));
                  },
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
