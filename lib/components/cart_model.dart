import 'package:flutter/foundation.dart';

class CartItem {
  final String productName;
  final double price;
  final String imageUrl;
  int quantity;

  CartItem({
    required this.productName,
    required this.price,
    required this.imageUrl,
    this.quantity = 1,
  });
}

class CartModel extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  void addItem(CartItem item) {
    for (var existingItem in _items) {
      if (existingItem.productName == item.productName) {
        existingItem.quantity += 1;
        notifyListeners();
        return;
      }
    }
    _items.add(item);
    notifyListeners();
  }

  void removeItem(CartItem item) {
    for (var existingItem in _items) {
      if (existingItem.productName == item.productName) {
        if (existingItem.quantity > 1) {
          existingItem.quantity -= 1;
        } else {
          _items.remove(existingItem);
        }
        notifyListeners();
        return;
      }
    }
  }

  void deleteItem(CartItem item) {
    _items.remove(item);
    notifyListeners();
  }

  double get totalCartPrice {
    double total = 0.0;
    for (var item in _items) {
      total += item.price * item.quantity;
    }
    return total;
  }
}
