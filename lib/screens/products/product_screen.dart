import 'package:flutter/material.dart';

import '../../components/card.dart';
import '../../components/product_model.dart';
import '../../components/products.dart'; // Import the products list

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
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
    // Use the hardcoded products list instead of loading from JSON
    return products.map((i) => Product.fromJson(i)).toList();
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
              bool alreadyOnProductScreen = false;
              Navigator.popUntil(context, (route) {
                if (route.settings.name == "ProductScreen") {
                  alreadyOnProductScreen = true;
                }
                  return true;
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
            return Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 2.0,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 6.0,
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
              ),
            );
          }
        },
      ),
    );
  }
}
