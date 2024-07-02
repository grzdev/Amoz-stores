import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '/components/cart_model.dart';

class CartBox extends StatelessWidget {
  final String productName;
  final double price;
  final String imageUrl;

  const CartBox({
    super.key,
    required this.productName,
    required this.price,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartModel>(context);
    final cartItem = cart.items.firstWhere(
      (item) => item.productName == productName,
      orElse: () => CartItem(productName: productName, price: price, imageUrl: imageUrl),
    );

    return SizedBox(
      width: 300,
      height: 120,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 100,
              height: 100,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                children: [
                  Text(productName),
                  Text(" \$${price.toString()}"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              cart.removeItem(cartItem);
                            },
                            icon: const Icon(Icons.remove),
                          ),
                          const SizedBox(width: 8),
                          Text(cartItem.quantity.toString()),
                          const SizedBox(width: 8),
                          IconButton(
                            onPressed: () {
                              cart.addItem(cartItem);
                              Fluttertoast.showToast(
                                msg: "$productName added to cart",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black54,
                                textColor: Colors.white,
                                fontSize: 16.0
                              );
                            },
                            icon: const Icon(Icons.add),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          cart.deleteItem(cartItem);
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
