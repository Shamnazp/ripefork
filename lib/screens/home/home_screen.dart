import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ripefo/screens/home/widgets/profile_header.dart';
import 'package:ripefo/screens/home/widgets/search_bar.dart';
import 'package:ripefo/screens/home/widgets/category_selector.dart';
import 'package:ripefo/screens/home/widgets/subcategory_selector.dart';
import 'package:ripefo/screens/home/widgets/recipe_list.dart';
import 'package:ripefo/models/recipe_model.dart';
import 'package:ripefo/services/api_service.dart';
import 'package:ripefo/services/hive_service.dart';

class HomeScreen extends StatefulWidget {
  final String email;
  const HomeScreen({super.key, required this.email});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  Future<List<dynamic>>? _recipeFuture;
  List<CategoryModel> categories = CategoryModel.getCategories();
  CategoryModel? selectedCategory;
  String? selectedSubcategory;

  @override
  void initState() {
    super.initState();
    DatabaseService().init();
    _fetchDefaultRecipes();
  }

  void _fetchDefaultRecipes() {
    setState(() {
      _recipeFuture = RecipeService.fetchRecipes("popular");
    });
  }

  void _searchRecipes() {
    setState(() {
      String query = _searchController.text.trim();
      if (query.isEmpty) {
        _recipeFuture = RecipeService.fetchRecipes("all");
      } else {
        selectedCategory = null;
        selectedSubcategory = null;
        _recipeFuture = RecipeService.fetchRecipes(query);
      }
    });
  }

  void _setCategory(CategoryModel category) {
    setState(() {
      selectedCategory = category;
      selectedSubcategory = null;
      _recipeFuture = RecipeService.fetchRecipes(category.query);
    });
  }

  void _setSubcategory(String? subcategory) {
    setState(() {
      selectedSubcategory = subcategory;
      if (subcategory == null && selectedCategory != null) {
        String query = selectedCategory!.query == "nonveg"
            ? "non-veg"
            : selectedCategory!.query;
        _recipeFuture = RecipeService.fetchRecipes(query);
      } else if (subcategory != null) {
        _recipeFuture = RecipeService.fetchRecipes(subcategory);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              const ProfileHeader(),
              const SizedBox(height: 10),
              SearchBarWidget(
                controller: _searchController,
                onChanged: _searchRecipes,
              ),
              const SizedBox(height: 15),
              Text(
                "What is inside your cooler?",
                style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              const SizedBox(height: 15),
              CategorySelector(
                categories: categories,
                selectedCategory: selectedCategory,
                onSelectCategory: _setCategory,
              ),
              const SizedBox(height: 15),
              if (selectedCategory != null)
                SubcategorySelector(
                  selectedCategory: selectedCategory!,
                  selectedSubcategory: selectedSubcategory,
                  onSelectSubcategory: _setSubcategory,
                ),
              const SizedBox(height: 15),
              Text(
                'Recipes',
                style: GoogleFonts.poppins(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: RecipeList(recipeFuture: _recipeFuture),
              )
            ],
          ),
        ),
      ),
    );
  }
}
