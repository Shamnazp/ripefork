import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ripefo/providers/user_provider.dart';
import 'package:ripefo/screens/saved_recipes/widgets/saved_recipe_grid.dart';


class SavedRecipesScreen extends StatelessWidget {
  const SavedRecipesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final savedRecipes = userProvider.savedRecipes;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Saved Recipes',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
      body: SafeArea(
        child: savedRecipes.isEmpty
            ? const Center(child: Text("No saved recipes yet!"))
            : SavedRecipeGrid(recipes: savedRecipes),
      ),
    );
  }
}
