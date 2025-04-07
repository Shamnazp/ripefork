import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ripefo/models/recipe_model.dart';
import 'package:ripefo/providers/user_provider.dart';
import 'package:ripefo/screens/add_recipe.dart';
import 'package:ripefo/screens/manage_profile.dart';
import 'package:ripefo/screens/profile.dart';
import 'package:ripefo/screens/recipe_card.dart';
import 'package:ripefo/screens/saved_recipe.dart';
import 'package:ripefo/screens/search_recipe.dart';
import 'package:ripefo/services/api_service.dart';
import 'package:ripefo/services/hive_service.dart';

class HomeScreen extends StatefulWidget {
  final String email; // Accept email
  const HomeScreen({super.key, required this.email});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  Future<List<dynamic>>? _recipeFuture;
  final DatabaseService _databaseService = DatabaseService();
  List<AddRecipeModel> recipes = [];

  @override
  void initState() {
    super.initState();
    DatabaseService().init();
    _fetchDefaultRecipes(); // Fetch default recipes when the home screen loads
  }

  void _fetchDefaultRecipes() {
    setState(() {
      _recipeFuture = RecipeService.fetchRecipes(
          "popular"); // Fetch popular recipes or any default category
    });
  }

  List<CategoryModel> categories = CategoryModel.getCategories();
  CategoryModel? selectedCategory;
  String? selectedSubcategory;

  void _setCategory(CategoryModel category) {
    setState(() {
      selectedCategory = category;
      selectedSubcategory = null;
      print("Selected category: ${category.name}, Query: ${category.query}");
      _searchRecipes();
    });
  }

  void _setSubcategory(String? subcategory) {
    setState(() {
      selectedSubcategory = subcategory;

      if (selectedSubcategory == null && selectedCategory != null) {
        String query = selectedCategory!.query == "nonveg"
            ? "non-veg"
            : selectedCategory!.query;
        print("Fetching all recipes for category: $query");
        _recipeFuture = RecipeService.fetchRecipes(query);
      } else if (selectedSubcategory != null) {
        print("Fetching subcategory recipes: $selectedSubcategory");
        _recipeFuture = RecipeService.fetchRecipes(selectedSubcategory!);
      } else {
        print("Fetching all recipes");
        _recipeFuture = RecipeService.fetchRecipes("");
      }
    });
  }

  void _searchRecipes() {
    setState(() {
      String query = _searchController.text.trim();

      if (query.isEmpty) {
        // Explicitly tell RecipeService to return all recipes
        _recipeFuture = RecipeService.fetchRecipes("all");
        return;
      }

      // Existing logic (preserved)
      if (query.isNotEmpty) {
        selectedCategory = null;
        selectedSubcategory = null;
        _recipeFuture = RecipeService.fetchRecipes(query);
      } else if (selectedSubcategory != null) {
        _recipeFuture = RecipeService.fetchRecipes(selectedSubcategory!);
      } else if (selectedCategory != null) {
        _recipeFuture = RecipeService.fetchRecipes(selectedCategory!.query);
      } else {
        _recipeFuture = RecipeService.fetchRecipes("");
      }
    });
  }

  int _currentIndex = 0;
  void _onTabTapped(int index) {
    if (index == 1) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => SearchRecipeScreen()));
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
          MaterialPageRoute(builder: (context) => ProfileScreen(email: '')));
    }
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),

              // Profile Section
              Row(
                children: [
                  Consumer<UserProvider>(
                    builder: (context, userProvider, child) {
                      return Row(
                        children: [
                          CircleAvatar(
                            radius: 22,
                            backgroundColor: Colors.grey[300],
                            backgroundImage: userProvider
                                    .profileImage.isNotEmpty
                                ? FileImage(File(userProvider.profileImage))
                                    as ImageProvider
                                : const AssetImage('assets/default_user.png'),
                            child: userProvider.profileImage.isEmpty
                                ? const Icon(Icons.person,
                                    size: 20, color: Colors.white)
                                : null,
                          ),
                          const SizedBox(width: 20),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ProfileScreen(email: ''),
                                ),
                              );
                            },
                            child: Text(
                              'Hey there, 👋\n${userProvider.name}',
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // Search Bar
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search recipes',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.grey[250],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (value) {
                  _searchRecipes();
                },
                onSubmitted: (_) => _searchRecipes(),
              ),

              const SizedBox(height: 15),

              // Category Title
              Text(
                "What is inside your cooler?",
                style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),

              const SizedBox(height: 15),

              // Category Selection
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: categories.map((category) {
                    bool isSelected = selectedCategory?.name == category.name;
                    Color borderColor =
                        category.name == "Veg" ? Colors.green : Colors.red;
                    Color fillColor = isSelected
                        ? borderColor.withOpacity(0.3)
                        : Colors.white;

                    return GestureDetector(
                      onTap: () => _setCategory(category),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: fillColor,
                          border: Border.all(
                            color: borderColor,
                            width: isSelected ? 2.5 : 1.5,
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: borderColor,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 15),

              // Subcategory List
              if (selectedCategory != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: [
                      GestureDetector(
                        onTap: () => _setSubcategory(null),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: selectedSubcategory == null
                                ? const Color.fromARGB(255, 243, 33, 33)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: selectedSubcategory == null
                                  ? Color.fromARGB(255, 243, 33, 33)
                                  : Colors.grey,
                              width: 2,
                            ),
                          ),
                          child: Text(
                            "All",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: selectedSubcategory == null
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),

                      // Other subcategories
                      ...selectedCategory!.subcategories.map((subcategory) {
                        bool isSelected = selectedSubcategory == subcategory;
                        return GestureDetector(
                          onTap: () => _setSubcategory(subcategory),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Color.fromARGB(255, 243, 33, 33)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: isSelected
                                    ? Color.fromARGB(255, 243, 33, 33)
                                    : Colors.grey,
                                width: 2,
                              ),
                            ),
                            child: Text(
                              subcategory,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: isSelected ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),

              const SizedBox(height: 15),

              // Recipe List Title
              Text(
                'Recipes',
                style: GoogleFonts.poppins(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              // Recipe List
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
                            return const Center(
                                child: Text("No recipes found"));
                          }
                          final recipes = snapshot.data ?? [];
                          return ListView.builder(
                            itemCount: recipes.length,
                            itemBuilder: (context, index) {
                              final recipe = RecipeModel.fromJson(
                                  recipes[index]['recipe']);
                              return RecipeCard(recipe: recipe);
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add'),
          BottomNavigationBarItem(icon: Icon(Icons.save), label: 'Save'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
