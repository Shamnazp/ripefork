import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ripefo/models/recipe_model.dart';
import 'package:ripefo/screens/main_screen.dart';
import 'package:ripefo/screens/search_recipe/search_recipe_screen.dart';
import 'package:ripefo/services/hive_service.dart';

class AddRecipeController {
  final nameController = TextEditingController();
  final sourceController = TextEditingController();
  final caloriesController = TextEditingController();
  final instructionsController = TextEditingController();
  final List<TextEditingController> ingredientControllers = [TextEditingController()];

  final DatabaseService _databaseService = DatabaseService();
  File? image;
  bool isEditing = false;
  int? recipeKey;

  void initialize(AddRecipeModel? recipe) {
    if (recipe != null) {
      isEditing = true;
      nameController.text = recipe.recipeName;
      sourceController.text = recipe.source;
      caloriesController.text = recipe.calories.toString();
      instructionsController.text = recipe.instructions;
      image = File(recipe.imagePath);
      recipeKey = _databaseService.getKeyForRecipe(recipe);
      ingredientControllers.clear();
      for (var ingredient in recipe.ingredients) {
        ingredientControllers.add(TextEditingController(text: ingredient));
      }
    }
  }

  Future<void> pickImage(Function(File) onImagePicked) async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      onImagePicked(image!);
    }
  }

  void addIngredientField() {
    ingredientControllers.add(TextEditingController());
  }

  void removeIngredientField(int index) {
    if (ingredientControllers.length > 1) {
      ingredientControllers.removeAt(index);
    }
  }

  Future<void> saveRecipe(BuildContext context) async {
    if (image == null ||
        nameController.text.isEmpty ||
        ingredientControllers.any((c) => c.text.isEmpty) ||
        caloriesController.text.isEmpty ||
        instructionsController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please fill all the fields and add an image.'),
      ));
      return;
    }

    final recipe = AddRecipeModel(
      imagePath: image!.path,
      recipeName: nameController.text,
      source: sourceController.text,
      ingredients: ingredientControllers.map((c) => c.text).toList(),
      calories: int.tryParse(caloriesController.text) ?? 0,
      instructions: instructionsController.text,
    );

    if (isEditing && recipeKey != null) {
      await _databaseService.updateRecipe(recipeKey!, recipe);
    } else {
      await _databaseService.addNewRecipe(recipe);
    }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(isEditing ? 'Recipe updated successfully!' : 'Recipe added successfully!')));

   Navigator.pushReplacement(
  context,
  MaterialPageRoute(
    builder: (_) => MainScreen(),
  ),
);

  }

  void dispose() {
    nameController.dispose();
    sourceController.dispose();
    caloriesController.dispose();
    instructionsController.dispose();
    for (var c in ingredientControllers) {
      c.dispose();
    }
  }
}

