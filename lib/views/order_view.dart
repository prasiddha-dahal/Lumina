import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutterecommerce/controllers/cart_controller.dart';
import 'package:flutterecommerce/controllers/order_controller.dart';
import 'package:get/get.dart';

class OrderView extends StatelessWidget {
  const OrderView({super.key});

  @override
  Widget build(BuildContext context) {
    var cartController = Get.find<CartController>();
    var orderController = Get.find<OrderController>();

    return Scaffold(
      appBar: AppBar(title: Text("Order")),
      body: SafeArea(
        child: Obx(() {
          return SingleChildScrollView(
            child: Column(
              children: [
                //upload the payment receipt button
                FilledButton(
                  onPressed: () async {
                    await orderController.pickImage();
                  },
                  child: Text("Upload Payment Receipt"),
                ),

                //image
                orderController.image.value != null
                    ? Image.file(orderController.image.value!, height: 200)
                    : Text("No Image Selected"),

                //cart items
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: cartController.cartItems.value.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    var product = cartController.cartItems.value.data[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          "${product.productImage}",
                        ),
                      ),
                      title: Text("${product.productName}"),
                    );
                  },
                ),

                //order button
                ElevatedButton(
                  onPressed: () async {
                    if (orderController.image.value == null) {
                      Get.snackbar("Error", "Please upload payment receipt");
                      return;
                    }
                    Loader.show(context);

                    await orderController.placeOrder(
                      orderController.image.value!,
                    );

                    Loader.hide();
                  },
                  child: const Text("Order"),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
