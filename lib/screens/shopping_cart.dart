import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ripefo/providers/cart_provider.dart';

class ShoppingCartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Shopping Cart")),
      body: ListView.builder(
        itemCount: cartProvider.cartItems.length,
        itemBuilder: (context, index) {
          var item = cartProvider.cartItems[index];
          return ListTile(
            title: Text(item.ingredient),
            subtitle: Text("Quantity: ${item.quantity}"),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                cartProvider.removeFromCart(index);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.delete),
        onPressed: () {
          cartProvider.clearCart();
        },
      ),
    );
  }
}
