import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ripefo/models/recipe_model.dart';
import 'package:ripefo/screens/shopping_cart.dart';
import '../providers/cart_provider.dart';  // Import CartProvider
import '../providers/user_provider.dart';

class RecipeDetailScreen extends StatelessWidget {
  final RecipeModel recipe;

  const RecipeDetailScreen({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context); // Get CartProvider

    bool isSaved = userProvider.isRecipeSaved(recipe.label);

    return Scaffold(
      body: SingleChildScrollView(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                // Recipe Image
                Image.network(recipe.image,
                    width: double.infinity, height: 400, fit: BoxFit.cover),

                // Back Button
                Positioned(
                  top: 40,
                  left: 15,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                    ),
                  ),
                ),

                // Bookmark Button
                Positioned(
                  top: 40,
                  right: 15,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(
                        isSaved ? Icons.bookmark : Icons.bookmark_border,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        if (isSaved) {
                          userProvider.removeRecipe(recipe.label);
                        } else {
                          userProvider.saveRecipe(recipe);
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Recipe Title
                  Text(
                    recipe.label,
                    style: GoogleFonts.poppins(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),

                  // Row for user icon and source
                  Row(
                    children: [
                      // User Icon
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.grey[300],
                        child: const Icon(Icons.person, color: Colors.black),
                      ),
                      const SizedBox(width: 10),

                      // Source Name
                      Text(
                        recipe.source,
                        style: GoogleFonts.poppins(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Ingredients Section
                  Text("Ingredients",
                      style: GoogleFonts.poppins(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 7),
                  ...recipe.ingredients.map((ingredient) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
          child: Text(
            "• $ingredient",
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w100,
            ),
            overflow: TextOverflow.ellipsis, // Prevents overflow
          ),
        ),
                          IconButton(
                            icon: const Icon(Icons.add_shopping_cart,
                                color: Colors.green),
                            onPressed: () {
                              cartProvider.addToCart(ingredient);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text("$ingredient added to cart!"),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            },
                          ),
                        ],
                      )),
                  const SizedBox(height: 20),

                  // Instructions Section
                  Text("Description",
                      style: GoogleFonts.poppins(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 7),
                  Text(
                    recipe.source,
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: const Color.fromARGB(255, 1, 1, 1)),
                  ),

                  const SizedBox(height: 20),

                  // Shopping Cart Button
                  Center(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.shopping_cart),
                      label: Text("View Cart"),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ShoppingCartScreen()));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
