import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ripefo/models/recipe_model.dart';
import 'package:ripefo/screens/recipe_details.dart';
import 'package:ripefo/screens/search_recipe/search_recipe_controller.dart';
import 'package:ripefo/screens/search_recipe/widgets/search_bar.dart';
import 'package:ripefo/screens/search_recipe/widgets/search_history_list.dart';
import 'package:ripefo/screens/search_recipe/widgets/added_recipe_list.dart';
import 'package:ripefo/screens/shopping_cart.dart';

class SearchRecipeScreen extends StatefulWidget {
  const SearchRecipeScreen({super.key});

  @override
  State<SearchRecipeScreen> createState() => _SearchRecipeScreenState();
}

class _SearchRecipeScreenState extends State<SearchRecipeScreen> {
  final controller = SearchRecipeController();
  final TextEditingController searchController = TextEditingController();

  
  late List<AddRecipeModel> allRecipes;
  late List<AddRecipeModel> filteredRecipes;

  late Box<RecipeModel> recentBox;

@override
void initState() {
  super.initState();

  allRecipes = controller.getAllAddedRecipes();
  filteredRecipes = List.from(allRecipes);
}





  void _filter(String query) {
    setState(() {
      filteredRecipes = allRecipes
          .where((r) =>
              r.recipeName.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _handleDelete(AddRecipeModel recipe) async {
    await controller.deleteAddedRecipe(recipe, () {
      setState(() {
        allRecipes.remove(recipe);
        filteredRecipes.remove(recipe);
      });
    });
  }

  @override
Widget build(BuildContext context) {
  final recentBox = Hive.box<RecipeModel>('recentRecipes'); // 👈 move here safely

  return Scaffold(
    appBar: AppBar(
      title: Text(
        'Saved Recipes',
        style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.shopping_cart),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => ShoppingCartScreen()));
          },
        )
      ],
    ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchBarWidget(
              controller: searchController,
              onChanged: _filter,
            ),
            const SizedBox(height: 16),
           ValueListenableBuilder<Box<RecipeModel>>(
  valueListenable: Hive.box<RecipeModel>('recentRecipes').listenable(),
  builder: (context, box, _) {
    final recipes = box.values.toList()
      ..sort((a, b) => b.visitedDate!.compareTo(a.visitedDate!));

    if (recipes.isEmpty) return SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Search History",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 10),
        SearchHistoryList(
          recipes: recipes.take(3).toList(),
          formatVisitedDate: controller.formatVisitedDate,
          onRecipeTap: (recipe) async {
            await controller.saveRecentRecipe(recipe);
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => RecipeDetailScreen(recipe: recipe)),
            );
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  },
),

            if (filteredRecipes.isNotEmpty) ...[
              const Text("Added Recipes",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 10),
              AddedRecipeList(
                recipes: filteredRecipes,
                onDelete: _handleDelete,
                onEdit: (recipe) {
                  // Navigate to edit screen
                },
              ),
            ],
          ],
        ),
      ),
    ),
  );
}
}