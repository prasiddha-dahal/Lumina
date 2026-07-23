import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutterecommerce/controllers/cart_controller.dart';
import 'package:flutterecommerce/routes/app_routes.dart';
import 'package:get/get.dart';

class CartView extends GetView<CartController> {
  const CartView({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 60,
            width: double.infinity,
            child: FilledButton(
              onPressed: () {
                Get.toNamed(AppRoutes.order);
              },
              style: FilledButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
              child: Text("Proceed To Checkout"),
            ),
          ),
        ),
        appBar: AppBar(),
        body: Obx(() {
          if (controller.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          } else if (controller.cartItems.value.data.isEmpty) {
            return Center(child: Text("Cart is Empty"));
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text("Cart Items"),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: controller.cartItems.value.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        var product = controller.cartItems.value.data[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    "${product.productImage}",
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  ),
                                ),

                                const SizedBox(width: 12),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.productName ?? "",
                                        style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),

                                      const SizedBox(height: 8),

                                      Text(
                                        "Quantity: ${product.quantity}",
                                        style: const TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),

                                      Text(
                                        "Price: Rs. ${product.sellingPrice}",
                                        style: const TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),

                                      const SizedBox(height: 8),

                                      Text(
                                        "Total: Rs. ${product.totalAmt}",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Column(
                                  children: [
                                    IconButton(
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {
                                        Get.defaultDialog(
                                          title: "Delete",
                                          content: const Text("Are you sure?"),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Get.back();
                                              },
                                              child: const Text("Cancel"),
                                            ),
                                            FilledButton(
                                              onPressed: () async {
                                                Get.back();

                                                Loader.show(context);

                                                await controller.deleteCartItem(
                                                  product.cartId!,
                                                );
                                                await controller
                                                    .fetchCartItems();

                                                Loader.hide();
                                              },
                                              child: const Text("Yes"),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.blue,
                                      ),
                                      onPressed: () {
                                        final quantityController =
                                            TextEditingController();

                                        Get.defaultDialog(
                                          title: "Update Quantity",
                                          content: TextField(
                                            controller: quantityController,
                                            keyboardType: TextInputType.number,
                                            decoration: const InputDecoration(
                                              labelText: "Quantity",
                                              border: OutlineInputBorder(),
                                            ),
                                          ),
                                          textCancel: "Cancel",
                                          textConfirm: "Update",
                                          onConfirm: () async {
                                            final quantity = int.tryParse(
                                              quantityController.text,
                                            );

                                            if (quantity == null ||
                                                quantity <= 0) {
                                              Get.snackbar(
                                                "Error",
                                                "Please enter valid quantity",
                                              );
                                              return;
                                            }

                                            Get.back();

                                            Loader.show(context);

                                            await controller.updateCartItem(
                                              product.cartId!,
                                              product.productId!,
                                              quantity,
                                            );

                                            await controller.fetchCartItems();

                                            Loader.hide();
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          }
        }),
      ),
    );
  }
}
