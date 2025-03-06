import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ripefo/models/recipe_model.dart';
import 'package:ripefo/screens/add_recipe.dart';
import 'package:ripefo/screens/home.dart';
import 'package:ripefo/screens/manage_profile.dart';
import 'package:ripefo/screens/recipe_card.dart';
import 'package:ripefo/screens/recipe_details.dart';
import 'package:ripefo/screens/saved_recipe.dart';
import 'package:ripefo/screens/shopping_cart.dart';
import 'package:ripefo/services/api_service.dart';
import 'package:ripefo/services/hive_service.dart';
import '../models/recipe_model.dart' as api; // Ensure correct import

class SearchRecipeScreen extends StatefulWidget {
  const SearchRecipeScreen({super.key});

  @override
  _SearchRecipeScreenState createState() => _SearchRecipeScreenState();
}

class _SearchRecipeScreenState extends State<SearchRecipeScreen> {
  final TextEditingController _searchController = TextEditingController();
  Future<List<dynamic>>? _recipeFuture;

//navbar
  int _currentIndex = 1;
  void _onTabTapped(int index) {
    if (index == 0) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }

    if (index == 1) {
      // Stay on the same screen
      return;
    }
    if (index == 2) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AddRecipeScreen()));
    }
    if (index == 3) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => SavedRecipesScreen()));
    }
    if (index == 4) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => ManageProfileScreen()));
    }

    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadAddedRecipes();
  }

// List to store added recipes
  List<AddRecipeModel> _addedRecipes = [];

  void _loadAddedRecipes() {
    setState(() {
      _addedRecipes = DatabaseService().getAllAddedRecipes();
    });
  }

  void onSearch(String query) async {
    if (query.isEmpty) return;

    setState(() {
      _recipeFuture = RecipeService.fetchRecipes(query);
    });
  }

  void _deleteRecipe(AddRecipeModel recipe) async {
    await DatabaseService().deleteAddedRecipe(recipe);

    setState(() {
      _addedRecipes.remove(recipe); // Remove from the UI
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Recipe deleted successfully!')),
    );
  }


  @override
  Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      title: const Text("Search Recipes"),
      actions: [
        IconButton(
          icon: const Icon(Icons.shopping_cart),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ShoppingCartScreen()),
            );
          },
        ),
      ],
    ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            // Search Bar
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search Recipes...",
                  icon: Icon(Icons.search),
                ),
                onSubmitted: (_) => onSearch(_searchController.text.trim()),
              ),
            ),
            const SizedBox(height: 20),

            // Added Recipes Section
            if (_addedRecipes.isNotEmpty) ...[
              const Text(
                "Added Recipes",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 150, // Fixed height for horizontal scrolling
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _addedRecipes.length,
                  itemBuilder: (context, index) {
                    final recipe = _addedRecipes[index];
                    return GestureDetector(
                      onTap: () {
                        // Navigate to Recipe Detail Page (if needed)
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.file(
                                    File(recipe.imagePath),
                                    width: 120,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: 4,
                                  right: 4,
                                  child: IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                    onPressed: () => _deleteRecipe(recipe),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                recipe.recipeName,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],

            // Search Results Section
            Expanded(
              child: _recipeFuture == null
                  ? const Center(child: Text("Search for recipes"))
                  : FutureBuilder<List<dynamic>>(
                      future: _recipeFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text("Error: ${snapshot.error}"));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Center(child: Text("No recipes found"));
                        }

                        final recipes = snapshot.data ?? [];

                        return ListView.builder(
                          itemCount: recipes.length,
                          itemBuilder: (context, index) {
                            final apiRecipe = api.RecipeModel(
                              uri: recipes[index]['recipe']['uri'] ?? "",
                              label: recipes[index]['recipe']['label'] ??
                                  "Unknown",
                              image: recipes[index]['recipe']['image'] ?? "",
                              source: recipes[index]['recipe']['source'] ??
                                  "No description",
                              ingredients: (recipes[index]['recipe']
                                          ['ingredientLines'] as List<dynamic>?)
                                      ?.map((item) => item.toString())
                                      .toList() ??
                                  [],
                              visitedDate: DateTime.now(),
                            );

                            return RecipeCard(recipe: apiRecipe);
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}


































