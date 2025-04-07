import 'package:flutter/material.dart';
import 'package:ripefo/models/recipe_model.dart';
import 'package:ripefo/screens/recipe_details.dart';
import 'package:ripefo/services/hive_service.dart';
import 'package:cached_network_image/cached_network_image.dart';

//home page recipe card
class RecipeCard extends StatelessWidget {
  final RecipeModel recipe;
  final VoidCallback? onAdd;

  const RecipeCard({super.key, required this.recipe, this.onAdd});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final dbService = DatabaseService();
        await dbService.saveRecentRecipe(recipe);

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
            CachedNetworkImage(
              imageUrl: recipe.image,
              height: 140,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                height: 140,
                color: Colors.grey[200],
                child: const Center(child: CircularProgressIndicator()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.label,
                    maxLines: 1,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text("calories: ${recipe.calories?.toStringAsFixed(1)} ",
                      style: const TextStyle(fontSize: 12)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
