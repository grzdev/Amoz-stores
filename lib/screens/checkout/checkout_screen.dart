import 'package:amoz_stores/components/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../success/success_screen.dart';
import '/components/cart_model.dart'; // Import your CartModel

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 247, 248),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 242, 247, 250),
        title: const Text(
          'Checkout',
          style: TextStyle(fontSize: 18,)  
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.home,
            color: Color.fromARGB(255, 43, 113, 146)
          ),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(context, '/', (Route<dynamic> route) => false);
          },
        ),
        leadingWidth: 60,
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/products');
              },
              icon: const Icon(
                Icons.shopping_bag,
                color: Color.fromARGB(255, 43, 113, 146)
              ),
            ),
            IconButton(
              onPressed: () {
                bool alreadyOnProductScreen = false;
                Navigator.popUntil(context, (route) {
                  if (route.settings.name == "CheckoutScreen") {
                    alreadyOnProductScreen = true;
                  }
                  return true; 
                });

                if (!alreadyOnProductScreen) {
                  Navigator.pushNamed(context, '/checkScreen');
                }
              },
              icon: const Icon(
                Icons.shopping_cart,
                color: Color.fromARGB(255, 43, 113, 146)
              ),
            ),
          ],
        ),
      ),
      
      body: Consumer<CartModel>(
        builder: (context, cart, child) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cart.items.length,
                  itemBuilder: (context, index) {
                    final item = cart.items[index];
                    return CartBox(
                      productName: item.productName,
                      price: item.price,
                      imageUrl: item.imageUrl,
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SuccessScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
                    textStyle: const TextStyle(fontSize: 18.0),
                    backgroundColor: const Color.fromARGB(255, 230, 247, 255), // Optional: Button color
                  ),
                  child: Text(
                    'Checkout \$${cart.totalCartPrice.toStringAsFixed(2)}'
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
