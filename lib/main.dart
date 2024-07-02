import 'package:flutter/material.dart';
import 'app.dart'; 
import 'package:provider/provider.dart';
import 'components/cart_model.dart';
import 'screens/checkout/checkout_screen.dart';
import 'screens/products/product_screen.dart';
import 'screens/success/success_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amoze stores',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const App(),
      routes: {
        '/checkout': (context) => const CheckoutScreen(),
        '/products': (context) => const ProductScreen(),
        '/success': (context) => const SuccessScreen(),
      },
    );
  }
}