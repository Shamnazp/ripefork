import 'package:flutter/material.dart';
import 'package:ripefo/models/recipe_model.dart';
import 'package:ripefo/screens/recipe_details.dart';


//home page recipe card
class RecipeCard extends StatelessWidget {
  final RecipeModel recipe;
  final VoidCallback? onAdd;


  const RecipeCard({super.key, required this.recipe,this.onAdd});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeDetailScreen(recipe: recipe),
          ),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(recipe.image,
                height: 140, width: double.infinity, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.label,
                    maxLines: 2,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4), // Small space
                  // Text(
                  //   "Calories: ${recipe.calories.toStringAsFixed(2)} kcal",
                  //   style: const TextStyle(fontSize: 14, color: Colors.grey),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}