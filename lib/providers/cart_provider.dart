import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:ripefo/models/cart_model.dart';

class CartProvider with ChangeNotifier {
  final Box<CartItem> _cartBox = Hive.box<CartItem>('shoppingCart');
  List<CartItem> get cartItems => _cartBox.values.toList();

  void addToCart(String ingredient) {
    var existingItem = _cartBox.values.firstWhere(
        (item) => item.ingredient == ingredient,
        orElse: () => CartItem(ingredient: ''));

    if (existingItem.ingredient.isNotEmpty) {
      existingItem.quantity += 1;
      existingItem.save();
    } else {
      _cartBox.add(CartItem(ingredient: ingredient));
    }
    notifyListeners();
  }
  void removeFromCart(int index) {
    _cartBox.deleteAt(index);
    notifyListeners();
  }

  void updateQuantity(CartItem item, int newQuantity) {
    if (newQuantity > 0) {
      item.quantity = newQuantity;
      item.save();  // Saves the updated quantity in Hive
    } else {
      _cartBox.delete(item.key); // Remove item if quantity is 0
    }
    notifyListeners();
  }

  void clearCart() {
    _cartBox.clear();
    notifyListeners();
  }
}
