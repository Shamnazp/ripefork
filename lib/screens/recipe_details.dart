import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ripefo/models/cart_model.dart';
import 'package:ripefo/models/recipe_model.dart';
import 'package:ripefo/screens/shopping_cart.dart';
import '../providers/cart_provider.dart'; // Import CartProvider
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
                CachedNetworkImage(
  imageUrl: recipe.image,
  width: double.infinity,
  height: 400,
  fit: BoxFit.cover,
  placeholder: (context, url) => Container(
    height: 400,
    color: Colors.grey[200],
    child: const Center(
      child: CircularProgressIndicator(),
    ),
  ),
  errorWidget: (context, url, error) => Container(
    height: 400,
    color: Colors.grey[200],
    child: const Center(
      child: Icon(Icons.broken_image, color: Colors.grey),
    ),
  ),
),// Back Button
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
                        color: const Color.fromARGB(255, 215, 29, 29),
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
                  // Nutrient Info Section
                  Text("Nutrient-Info",
                      style: GoogleFonts.poppins(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 7),

                  // Calories
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Calories",
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "${recipe.calories?.toStringAsFixed(2) ?? 'N/A'} kcal",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Total Nutrients",
                    style: GoogleFonts.poppins(
                      fontSize: 16, // Heading size
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (recipe.totalNutrients != null &&
                      recipe.totalNutrients!.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: recipe.totalNutrients!.entries.map((entry) {
                        final nutrient =
                            entry.value; // Accessing each nutrient's data
                        return Padding(
                          padding: const EdgeInsets.only(
                              bottom: 4), // Spacing between items
                          child: Text(
                            "• ${nutrient['label']}: ${nutrient['quantity'].toStringAsFixed(1)} ${nutrient['unit']}", // Displaying nutrient info
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                            ),
                          ),
                        );
                      }).toList(),
                    )
                  else
                    Text(
                      "N/A",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  const SizedBox(height: 20),
                  // Nutrition Guide
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Heading
                      Text(
                        "Health Labels",
                        style: GoogleFonts.poppins(
                          fontSize: 16, // Slightly larger font for heading
                          fontWeight: FontWeight.bold, // Bold heading
                          color: Colors.black, // Heading color
                        ),
                      ),
                      const SizedBox(height: 8), // Add spacing below heading
                      // Health Labels List
                      if (recipe.healthLabels != null &&
                          recipe.healthLabels!.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: recipe.healthLabels!
                              .map((label) => Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 4), // Spacing between items
                                    child: Text(
                                      "• $label", // Bullet point for readability
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black, // Highlight labels
                                      ),
                                    ),
                                  ))
                              .toList(),
                        )
                      else
                        Text(
                          "N/A",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Ingredients Section
                  Text("Ingredients",
                      style: GoogleFonts.poppins(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 7),
                  ...recipe.ingredients.map((ingredient) {
                    var existingItem = cartProvider.cartItems.firstWhere(
                        (item) => item.ingredient == ingredient,
                        orElse: () => CartItem(ingredient: ''));

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            "• $ingredient",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                            ),
                            overflow:
                                TextOverflow.ellipsis, // Prevents overflow
                          ),
                        ),
                        existingItem.ingredient.isNotEmpty
                            ? Row(
                                children: [
                                  Text("Qty: ${existingItem.quantity}",
                                      style: GoogleFonts.poppins(fontSize: 12)),
                                  const SizedBox(width: 10),
                                ],
                              )
                            : IconButton(
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
                    );
                  }),
                  const SizedBox(height: 20),
                  // Instructions Section
                  if (recipe.instructions != null &&
                      recipe.instructions!.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Instructions",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: recipe.instructions!
                              .map((step) => Padding(
                                    padding: const EdgeInsets.only(bottom: 4),
                                    child: Text(
                                      "• $step",
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ],
                    )
                  else
                    Text(
                      "Instructions not available",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),

                  const SizedBox(height: 20),

                  // Shopping Cart Button
                  Center(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.shopping_cart),
                      label: Text("View Cooking Needs..."),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ShoppingCartScreen()));
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
