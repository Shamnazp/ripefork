import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/recipe_model.dart';
import '../services/hive_service.dart';

class UserProvider with ChangeNotifier {
  String _name = "Shamnas P";
  String _email = "shamnaza05@gmail.com";
  String _profileImage = "";
  String _phoneNumber = "";

  List<RecipeModel> _savedRecipes = [];

  // Getters
  String get name => _name;
  String get email => _email;
  String get profileImage => _profileImage;
  String get phoneNumber => _phoneNumber;
  List<RecipeModel> get savedRecipes => _savedRecipes;

  final DatabaseService _dbService = DatabaseService();

  UserProvider() {
    _initializeProvider();
  }

  Future<void> _initializeProvider() async {
    await _dbService.init();  // Ensure Hive is initialized
    await _loadSavedRecipes();
  }

  Future<void> _loadSavedRecipes() async {
    _savedRecipes = _dbService.getAllRecipes();
    notifyListeners();
  }

  // Save a recipe
  Future<void> saveRecipe(RecipeModel recipe) async {
    await _dbService.saveRecipe(recipe);
    _savedRecipes.add(recipe);
    notifyListeners();
  }

  // Remove a saved recipe
  Future<void> removeRecipe(String title) async {
    await _dbService.removeRecipe(title);
    _savedRecipes.removeWhere((recipe) => recipe.label == title);
    notifyListeners();
  }

  // Check if a recipe is saved
  bool isRecipeSaved(String title) {
    return _savedRecipes.any((recipe) => recipe.label == title);
  }

  // Method to update user details
  void updateUser(String newName, String newEmail, String path, String newPhone) {
    _name = newName;
    _email = newEmail;
    if (path.isNotEmpty) {
      _profileImage = path;
    }
    _phoneNumber = newPhone;
    notifyListeners();
  }
}
