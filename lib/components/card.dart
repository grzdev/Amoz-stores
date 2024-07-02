import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '/components/cart_model.dart'; // Import your CartModel

class CardWidget extends StatelessWidget {
  final String name;
  final String price;
  final String imageUrl;

  const CardWidget({super.key, required this.name, required this.price, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30,
      height: 30,
      child: Card(
        color: const Color.fromARGB(255, 249, 252, 253),
        shadowColor: const Color.fromARGB(255, 233, 233, 233),
        elevation: 4.0,
        child: SizedBox( // Wrap Column with SizedBox if specific size is needed
          width: double.infinity, // Ensures the SizedBox fills the Card horizontally
          height: double.infinity,
          child: Column(
            children: [
              _buildSideBox(
                width: 100, // Specify the desired width
                height: 100, // Specify the desired height
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                    // Log the error or display an error message
                    return const Text('Could not load image');
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                 
                child: Column(
                  children: [
                    Text(name),
                    Text('\$$price'),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  Provider.of<CartModel>(context, listen: false).addItem(
                    CartItem(
                      productName: name,
                      price: double.parse(price),
                      imageUrl: imageUrl,
                    ),
                  );
                  Fluttertoast.showToast(
                    msg: "$name added to cart",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 2,
                    backgroundColor: Colors.black54,
                    textColor: Colors.white,
                    fontSize: 16.0
                  );
                },
              ),
            ],
          )
        ),
      ),
    );
  }

  Widget _buildSideBox({required double width, required double height, required Widget child}) {
    return SizedBox(
      width: width,
      height: height,
      child: child,
    );
  }
}
