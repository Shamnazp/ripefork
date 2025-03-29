import 'package:flutter/material.dart';
import 'package:ripefo/models/cart_model.dart';
import 'package:ripefo/models/recipe_model.dart';
import 'package:ripefo/models/user.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  //store
  late Box<RecipeModel> _recipeBox;
  late Box<User> _userBox;
  late Box<AddRecipeModel> _addRecipeBox;
  late Box<RecipeModel> _recentRecipesBox;

  factory DatabaseService() {
    return _instance;
  }
  DatabaseService._internal();

  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Hive.initFlutter();

    // Register Adapters
    if (!Hive.isAdapterRegistered(3)) {
      Hive.registerAdapter(UserAdapter());
    }
    if (!Hive.isAdapterRegistered(5)) {
      Hive.registerAdapter(AddRecipeModelAdapter());
    }

    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(RecipeModelAdapter());
    }

    if (!Hive.isAdapterRegistered(6)) {
      Hive.registerAdapter(CartItemAdapter());
    }

    // // Open Hive Boxes

    _userBox = await Hive.openBox<User>('userBox');
    _recipeBox = await Hive.openBox<RecipeModel>('savedRecipes');
    _addRecipeBox = await Hive.openBox<AddRecipeModel>('addRecipeBox');
    await Hive.openBox<CartItem>('shoppingCart');


    _recentRecipesBox = await Hive.openBox<RecipeModel>('recentRecipes');
  }
                //save
//save recipe
  Future<void> saveRecipe(RecipeModel recipe) async {
    await _recipeBox.put(recipe.label, recipe);
  }

  // Remove a Recipe
  Future<void> removeRecipe(String title) async {
    await _recipeBox.delete(title);
  }

  // Get All Saved Recipes
  List<RecipeModel> getAllRecipes() {
    return _recipeBox.values.toList();
  }

  // Check if Recipe is Saved
  bool isRecipeSaved(String title) {
    return _recipeBox.containsKey(title);
  }

  // Add Recipe 

  Future<void> addNewRecipe(AddRecipeModel recipe) async {
    await _addRecipeBox.add(recipe);
  }
  // Remove Recipe from Added Recipes
  Future<void> deleteAddedRecipe(AddRecipeModel recipe) async {
    final key = _addRecipeBox.keys.firstWhere(
      (k) => _addRecipeBox.get(k) == recipe,
      orElse: () => null,
    );

    if (key != null) {
      await _addRecipeBox.delete(key);
    }
  }

  List<AddRecipeModel> getAllAddedRecipes() {
    return _addRecipeBox.values.toList();
  }


    Future<void> updateRecipe(int key, AddRecipeModel recipe) async {
    await _addRecipeBox.put(key, recipe);
  }

  int? getKeyForRecipe(AddRecipeModel recipe) {
    return _addRecipeBox.keys.firstWhere(
      (k) => _addRecipeBox.get(k) == recipe,
      orElse: () => null,
    );
  }


//sign up
  User? getUser(String email) {
    return _userBox.get(email);
  }

  Future<bool> userExists(String email) async {
    return _userBox.containsKey(email);
  }

  Future<void> addUser(User user) async {
    await _userBox.put(user.email, user);
  }






  // Save a recently viewed recipe
Future<void> saveRecentRecipe(RecipeModel recipe) async {
  final existingIndex =
      _recentRecipesBox.values.toList().indexWhere((r) => r.uri == recipe.uri);
  
  if (existingIndex != -1) {
    await _recentRecipesBox.deleteAt(existingIndex);
  }

  recipe.visitedDate = DateTime.now();
  await _recentRecipesBox.add(recipe);

  // Keep only the last 3 recipes
  if (_recentRecipesBox.length > 3) {
    await _recentRecipesBox.deleteAt(0);
  }
}

// Get last 3 viewed recipes
List<RecipeModel> getRecentRecipes() {
  return _recentRecipesBox.values.toList().reversed.toList();
}
}
