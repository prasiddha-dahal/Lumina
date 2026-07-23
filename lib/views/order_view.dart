import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutterecommerce/controllers/cart_controller.dart';
import 'package:flutterecommerce/controllers/order_controller.dart';
import 'package:get/get.dart';

class OrderView extends StatelessWidget {
  const OrderView({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();
    final orderController = Get.find<OrderController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Place Order"),
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Obx(() {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Payment Receipt Section
                Text(
                  "Payment Receipt",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 12),

                // Upload Button
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () async {
                      await orderController.pickImage();
                    },
                    icon: const Icon(Icons.upload_file),
                    label: const Text("Upload Payment Receipt"),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Image Preview
                Container(
                  height: 240,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: orderController.image.value != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            orderController.image.value!,
                            fit: BoxFit.contain,
                          ),
                        )
                      : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.image_outlined,
                                size: 48,
                                color: Colors.grey.shade400,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "No receipt uploaded yet",
                                style: TextStyle(color: Colors.grey.shade600),
                              ),
                            ],
                          ),
                        ),
                ),

                const SizedBox(height: 32),

                // Cart Items Section
                Text(
                  "Cart Items (${cartController.cartItems.value.data.length})",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 12),

                // Cart Items List
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: cartController.cartItems.value.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    var product = cartController.cartItems.value.data[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(12),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CircleAvatar(
                            radius: 28,
                            backgroundImage: NetworkImage(
                              "${product.productImage}",
                            ),
                            backgroundColor: Colors.grey.shade200,
                          ),
                        ),
                        title: Text(
                          "${product.productName}",
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        subtitle: const Text("Qty: 1"), // You can make this dynamic if needed
                      ),
                    );
                  },
                ),

                const SizedBox(height: 24),

                // Place Order Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (orderController.image.value == null) {
                        Get.snackbar(
                          "Error",
                          "Please upload payment receipt",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red.shade100,
                          colorText: Colors.red.shade900,
                        );
                        return;
                      }
                      Loader.show(context);
                      await orderController.placeOrder(
                        orderController.image.value!,
                      );
                      Loader.hide();
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text(
                      "Confirm Order",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),
              ],
            ),
          );
        }),
      ),
    );
  }
}