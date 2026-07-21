import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutterecommerce/controllers/cart_controller.dart';
import 'package:get/get.dart';

class CartView extends GetView<CartController> {
  const CartView({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Container(
          height: 60,
          width: double.infinity,
          child: FilledButton(
            onPressed: () {},
            style: FilledButton.styleFrom(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
            ),
            child: Text("Proceed To Checkout"),
          ),
        ),
        appBar: AppBar(),
        body: Obx(() {
          if (controller.isLoading.value) {
            return Center(child: CircularProgressIndicator());
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
                        return ListTile(
                          title: Text("${product.productName}"),
                          trailing: IconButton(onPressed: (){
                            Get.defaultDialog(
                              title: "Delete",
                              content: Text("Are you sure?"), 
                              actions: [
                                TextButton(onPressed: (){
                                  Get.back();
                                }, child: Text("Cancel")),
                                FilledButton(onPressed: () async{
                                  Loader.show(context);
                                  await controller.deleteCartItem(product.cartId!);
                                  await controller.fetchCartItems();
                                  Loader.hide();
                                }, child: Text("Yes")),
                              ]
                            );
                          }, icon: Icon(Icons.delete,color: Colors.red,)),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                              "${product.productImage}",
                            ),
                          ),
                          subtitle: Text("(${product.quantity} * ${product.sellingPrice}) = ${product.totalAmt} "),
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
