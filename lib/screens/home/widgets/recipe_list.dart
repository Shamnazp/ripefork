import 'package:flutter/material.dart';
import 'package:ripefo/models/recipe_model.dart';
import 'package:ripefo/screens/recipe_card.dart';

class RecipeList extends StatelessWidget {
  final Future<List<dynamic>>? recipeFuture;

  const RecipeList({super.key, required this.recipeFuture});

  @override
  Widget build(BuildContext context) {
    if (recipeFuture == null) {
      return const Center(child: Text("Search for recipes"));
    }

    return FutureBuilder<List<dynamic>>(
      future: recipeFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No recipes found"));
        }

        final recipes = snapshot.data!;
        return ListView.builder(
          itemCount: recipes.length,
          itemBuilder: (context, index) {
            final recipe =
                RecipeModel.fromJson(recipes[index]['recipe']);
            return RecipeCard(recipe: recipe);
          },
        );
      },
    );
  }
}
