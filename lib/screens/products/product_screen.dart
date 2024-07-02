import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../../components/card.dart';
import '../../components/product.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProductScreenState createState() => _ProductScreenState();
}


class _ProductScreenState extends State<ProductScreen> {
  late Future<List<Product>> futureProducts;

  @override
  void initState() {
    super.initState();
    futureProducts = loadProducts();
  }

  Future<List<Product>> loadProducts() async {
    final String response = await rootBundle.loadString('lib/components/data.json');
    final data = await json.decode(response);
    return (data['data'] as List).map((i) => Product.fromJson(i)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),  
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 242, 247, 250),
        title: const Text(
          'Products',
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
        color: const Color.fromARGB(255, 249, 252, 253),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
            onPressed: () {
              // Check if the current route is not ProductScreen
              bool alreadyOnProductScreen = false;
              Navigator.popUntil(context, (route) {
                if (route.settings.name == "ProductScreen") {
                  alreadyOnProductScreen = true;
                }
                return true; // Don't actually pop any routes
              });

              if (!alreadyOnProductScreen) {
                Navigator.pushNamed(context, '/productScreen');
              }
            },
            icon: const Icon(
              Icons.shopping_bag,
              color: Color.fromARGB(255, 43, 113, 146)
            ), 
          ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/checkout');
              },
              icon: const Icon(
                Icons.shopping_cart,
                color: Color.fromARGB(255, 43, 113, 146)
              ),
            ),
          ],
        ),
      ),
      //change the list formart to a 3 x 3 grid and column and add spaces to the tob and bottom of the grid
      body: FutureBuilder<List<Product>>(
        future: futureProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No products found'));
          } else {
            return Padding( // Add Padding widget here
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0), // Top and bottom padding
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // Change to 3 columns for a 3x3 grid
                  childAspectRatio: 2.0, // Adjust aspect ratio if needed
                  crossAxisSpacing: 5.0, // Space between columns
                  mainAxisSpacing: 6.0, // Space between rows
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final product = snapshot.data![index];
                  return CardWidget(
                    name: product.name,
                    price: product.price.toString(),
                    imageUrl: product.img,
                  );
                },
              )
            );
          }
        },
      ),
    );
  }
}



