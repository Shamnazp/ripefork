import 'package:flutter/material.dart';
import 'package:ripefo/models/recipe_model.dart';
import 'saved_recipe_card.dart';

class SavedRecipeGrid extends StatelessWidget {
  final List<RecipeModel> recipes;

  const SavedRecipeGrid({super.key, required this.recipes});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.7,
      ),
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        return SavedRecipeCard(recipe: recipes[index]);
      },
    );
  }
}
