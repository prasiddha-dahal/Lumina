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
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(onPressed: (){
                                Get.defaultDialog(
                                  title: "Delete",
                                  content: Text("Are you sure?"), 
                                  actions: [
                                    TextButton(onPressed: (){
                                      Get.back();
                                    }, child: Text("Cancel")),
                                    FilledButton(onPressed: () async{
                                      Get.back();
                                      Loader.show(context);
                                      await controller.deleteCartItem(product.cartId!);
                                      await controller.fetchCartItems();
                                      Loader.hide();
                                    }, child: Text("Yes")),
                                  ]
                                );
                              }, icon: Icon(Icons.delete,color: Colors.red,)),
                              IconButton(onPressed: () async{
                                var quantityController = TextEditingController();
                                Get.defaultDialog(
                                  title: "Update quantity",
                                  content: TextField(
                                    controller: quantityController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      labelText: "Quantity",
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  textCancel: "Cancel",
                                  textConfirm: "Update",
                                  onConfirm: () async{
                                    final quantity =  int.tryParse(quantityController.text) ;
                                    if(quantity == null || quantity < 0){
                                      Get.snackbar("Error", "Please enter valid quantity");
                                      return;
                                    }
                                    Get.back();
                                    Loader.show(context);
                                    await controller.updateCartItem(product.cartId!, product.productId!, quantity);
                                    await controller.fetchCartItems();
                                    Loader.hide();
                                  }
                                );
                              }, icon: Icon(Icons.update)),
                            ],
                          ),
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
