import 'package:flutter/material.dart';
import 'package:ripefo/models/recipe_model.dart';
import 'package:ripefo/services/hive_service.dart';

class SearchRecipeController {
  final DatabaseService _dbService = DatabaseService();

  List<RecipeModel> getRecentRecipes() {
    return _dbService.getRecentRecipes();
  }

  String formatVisitedDate(DateTime? visitedDate) {
    if (visitedDate == null) return "Unknown date";
    final now = DateTime.now();
    final difference = now.difference(visitedDate).inDays;

    if (difference == 0) return "Today";
    if (difference == 1) return "Yesterday";
    if (difference < 7) return "$difference days ago";
    if (difference < 30) return "${(difference / 7).floor()} weeks ago";
    return "${(difference / 365).floor()} years ago";
  }

  List<AddRecipeModel> getAllAddedRecipes() {
    return _dbService.getAllAddedRecipes();
  }

  Future<void> deleteAddedRecipe(
    AddRecipeModel recipe,
    VoidCallback onDeleted,
  ) async {
    await _dbService.deleteAddedRecipe(recipe);
    onDeleted();
  }

  Future<void> saveRecentRecipe(RecipeModel recipe) async {
    await _dbService.saveRecentRecipe(recipe);
  }
}