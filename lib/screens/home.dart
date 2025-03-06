import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ripefo/models/recipe_model.dart';
import 'package:ripefo/screens/add_recipe.dart';
import 'package:ripefo/screens/manage_profile.dart';
import 'package:ripefo/screens/profile.dart';
import 'package:ripefo/screens/recipe_card.dart';
import 'package:ripefo/screens/saved_recipe.dart';
import 'package:ripefo/screens/search_recipe.dart';
import 'package:ripefo/services/api_service.dart';
import 'package:ripefo/services/hive_service.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
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
  }
  
  List<CategoryModel> categories = CategoryModel.getCategories();
  CategoryModel? selectedCategory;
  String? selectedSubcategory;

  void _setCategory(CategoryModel category) {
    setState(() {
      
      selectedCategory = category;
      selectedSubcategory = null;
      _searchRecipes();
    });
  }

  void _setSubcategory(String? subcategory) { // Allow null value
  setState(() {
    selectedSubcategory = subcategory; // Set to null if "All" is selected
    _searchRecipes();
  });
}


  void _searchRecipes() {
  setState(() {
    String query = _searchController.text.trim();

    if (selectedSubcategory != null) {
      query = selectedSubcategory!; // Fetch subcategory-specific recipes
    } else if (selectedCategory != null) {
      query = selectedCategory!.query; // Fetch all recipes for the selected category
    } else {
      query = ""; // Default empty query to fetch all recipes
    }

    _recipeFuture = RecipeService.fetchRecipes(query);
  });
}


  int _currentIndex = 0;
  void _onTabTapped(int index) {
    if (index == 1) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => SearchRecipeScreen()));
    }
    if (index == 2) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => AddRecipeScreen()));
    }
    if (index == 3){
      Navigator.push(context, MaterialPageRoute(builder: (context) => SavedRecipesScreen()));
    }
    if (index == 4) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen(email: '')));
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
                  const CircleAvatar(
                    radius: 22,
                    backgroundImage: NetworkImage(
                      'https://th.bing.com/th?id=OIP.Blj2M36K5WYTyNd6v6Jz0QHaJf&w=220&h=283&c=8&rs=1&qlt=90&o=6&dpr=1.1&pid=3.1&rm=2',
                    ),
                  ),
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileScreen(email: ''),
                        ),
                      );
                    },
                    child: Text(
                      'Hey there, 👋\nShamnas P',
                      style: GoogleFonts.poppins(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
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
                    Color borderColor = isSelected
                        ? (category.name == "Veg" ? Colors.green : Colors.red)
                        : Colors.grey;
                    return GestureDetector(
                      onTap: () => _setCategory(category),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: borderColor, width: 2),
                          borderRadius: BorderRadius.circular(8),
                          color: isSelected ? borderColor : Colors.white,
                        ),
                        child: Text(
                          category.name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color:
                                  isSelected ? Colors.white : Colors.black),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 15),

              // Subcategory List (Dynamic
              // Subcategory List (Dynamic)
if (selectedCategory != null)
  SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: [
        // "All" button for the selected category
        GestureDetector(
          onTap: () => _setSubcategory(null), // Reset subcategory
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: selectedSubcategory == null ? Colors.blue : Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: selectedSubcategory == null ? Colors.blue : Colors.grey,
                width: 2,
              ),
            ),
            child: Text(
              "All",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: selectedSubcategory == null ? Colors.white : Colors.black,
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
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected ? Colors.blue : Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isSelected ? Colors.blue : Colors.grey,
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
                            return const Center(child: Text("No recipes found"));
                          }
                          final recipes = snapshot.data ?? [];
                          return ListView.builder(
                            itemCount: recipes.length,
                            itemBuilder: (context, index) {
                              final recipe =
                                  RecipeModel.fromJson(recipes[index]['recipe']);
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
