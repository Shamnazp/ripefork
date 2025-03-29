import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ripefo/models/recipe_model.dart';
import 'package:ripefo/screens/add_recipe.dart';
import 'package:ripefo/screens/recipe_details.dart';
import 'package:ripefo/screens/shopping_cart.dart';
import 'package:ripefo/services/hive_service.dart';

class SearchRecipeScreen extends StatefulWidget {
  const SearchRecipeScreen({super.key});

  @override
  _SearchRecipeScreenState createState() => _SearchRecipeScreenState();
}

class _SearchRecipeScreenState extends State<SearchRecipeScreen> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _addedRecipeSearchController =
      TextEditingController();
  final DatabaseService _dbService = DatabaseService();
  List<RecipeModel> searchResults = [];
  List<RecipeModel> recentRecipes = [];
  List<AddRecipeModel> _addedRecipes = [];
  List<AddRecipeModel> _filteredAddedRecipes = [];

  @override
  void initState() {
    super.initState();
    _loadAddedRecipes();
    _loadRecentRecipes();
  }

  void _loadRecentRecipes() {
    setState(() {
      recentRecipes = _dbService.getRecentRecipes();
    });
  }

  String _formatVisitedDate(DateTime? visitedDate) {
    if (visitedDate == null) return "Unknown date";

    final now = DateTime.now();
    final difference = now.difference(visitedDate).inDays;

    if (difference == 0) {
      return "Today";
    } else if (difference == 1) {
      return "Yesterday";
    } else if (difference < 7) {
      return "$difference days ago";
    } else if (difference < 30) {
      int weeks = (difference / 7).floor();
      return "$weeks ${weeks == 1 ? 'week' : 'weeks'} ago";
    } else {
      int years = (difference / 365).floor();
      return "$years ${years == 1 ? 'year' : 'years'} ago";
    }
  }

  void _loadAddedRecipes() {
    setState(() {
      _addedRecipes = _dbService.getAllAddedRecipes();
      _filteredAddedRecipes = List.from(_addedRecipes);
    });
  }

  void _deleteRecipe(AddRecipeModel recipe) async {
    await _dbService.deleteAddedRecipe(recipe);
    setState(() {
      _addedRecipes.remove(recipe);
      _filteredAddedRecipes.remove(recipe);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Recipe deleted successfully!')),
    );
  }

  void _filterAddedRecipes(String query) {
    setState(() {
      _filteredAddedRecipes = _addedRecipes
          .where((recipe) =>
              recipe.recipeName.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _showDeleteConfirmationDialog(AddRecipeModel recipe) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Delete"),
          content: const Text("Are you sure you want to delete this recipe?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); 
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                _deleteRecipe(recipe); 
                Navigator.pop(context); 
              },
              child: const Text("Delete", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Search",
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ShoppingCartScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar (Fixed at Top)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                const Text(
                  "Search Added Recipes",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _addedRecipeSearchController,
                  onChanged: _filterAddedRecipes,
                  decoration: InputDecoration(
                    hintText: "Search added recipes...",
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),

          // Expanded Scrollable Section
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Recently Viewed Recipes
                    const Text(
                      "Search History",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    if (recentRecipes.isNotEmpty)
                      SizedBox(
                        height: 300,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: recentRecipes.length > 3
                              ? 3
                              : recentRecipes.length,
                          itemBuilder: (context, index) {
                            final recipe = recentRecipes[index];

                            return GestureDetector(
                              onTap: () async {
                                await _dbService.saveRecentRecipe(recipe);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        RecipeDetailScreen(recipe: recipe),
                                  ),
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(vertical: 6),
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      blurRadius: 5,
                                      spreadRadius: 2,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        recipe.image,
                                        height: 60,
                                        width: 60,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            recipe.label,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            _formatVisitedDate(
                                                recipe.visitedDate),
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                    // Search Results
                    if (searchResults.isNotEmpty)
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: searchResults.length,
                        itemBuilder: (context, index) {
                          final recipe = searchResults[index];
                          return ListTile(
                            leading: Image.network(recipe.image, width: 50),
                            title: Text(recipe.label),
                            onTap: () async {
                              await _dbService.saveRecentRecipe(recipe);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      RecipeDetailScreen(recipe: recipe),
                                ),
                              );
                            },
                          );
                        },
                      ),

                    // Added Recipes (Moved to Bottom)
                    if (_filteredAddedRecipes.isNotEmpty) ...[
                      const SizedBox(height: 20),
                      const Text(
                        "Added Recipes",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 150,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _filteredAddedRecipes.length,
                          itemBuilder: (context, index) {
                            final recipe = _filteredAddedRecipes[index];
                            return GestureDetector(
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  children: [
                                    Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: Image.file(
                                            File(recipe.imagePath),
                                            width: 180,
                                            height: 100,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Positioned(
                                          top: 4,
                                          right: 50,
                                          child: IconButton(
                                            icon: const Icon(Icons.edit,
                                                color: Colors.blue),
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      AddRecipeScreen(
                                                          recipe: recipe),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        Positioned(
                                          top: 4,
                                          right: 4,
                                          child: IconButton(
                                            icon: const Icon(Icons.delete,
                                                color: Colors.red),
                                            onPressed: () =>
                                                _showDeleteConfirmationDialog(
                                                    recipe),
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
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
