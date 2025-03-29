import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ripefo/providers/cart_provider.dart';

class ShoppingCartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cooking Needs",
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: cartProvider.cartItems.length,
        itemBuilder: (context, index) {
          var item = cartProvider.cartItems[index];
          return ListTile(
            title: Text(item.ingredient),
            subtitle: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.remove, color: Colors.red),
                  onPressed: () {
                    if (item.quantity > 1) {
                      cartProvider.updateQuantity(item, item.quantity - 1);
                    }
                  },
                ),
                Text("Quantity: ${item.quantity}",
                    style: TextStyle(fontSize: 16)),
                IconButton(
                  icon: Icon(Icons.add, color: Colors.green),
                  onPressed: () {
                    cartProvider.updateQuantity(item, item.quantity + 1);
                  },
                ),
              ],
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
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
