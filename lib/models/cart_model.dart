import 'package:hive/hive.dart';

part 'cart_model.g.dart';

@HiveType(typeId: 6)
class CartItem extends HiveObject {
  @HiveField(0)
  String ingredient;

  @HiveField(1)
  int quantity;

  CartItem({required this.ingredient, this.quantity = 1});
   // Add a method to update quantity
  void updateQuantity(int newQuantity) {
    quantity = newQuantity;
    save(); // Save changes to Hive database
  }
}
