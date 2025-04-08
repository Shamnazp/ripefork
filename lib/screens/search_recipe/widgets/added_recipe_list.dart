import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ripefo/models/recipe_model.dart';
import 'package:ripefo/screens/add_recipe/add_recipe_screen.dart';

class AddedRecipeList extends StatelessWidget {
  final List<AddRecipeModel> recipes;
  final void Function(AddRecipeModel) onDelete;
  final void Function(AddRecipeModel) onEdit;

  const AddedRecipeList({
    super.key,
    required this.recipes,
    required this.onDelete,
    required this.onEdit,
  });
  

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: recipes.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final recipe = recipes[index];

          return GestureDetector(
            child: Container(
              width: 180,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                        child: recipe.imagePath.isNotEmpty
                            ? Image.file(
                                File(recipe.imagePath),
                                width: 180,
                                height: 100,
                                fit: BoxFit.cover,
                              )
                            : Container(
                                width: 180,
                                height: 100,
                                color: Colors.grey[300],
                                child: const Center(child: Text('No Image')),
                              ),
                      ),
                      Positioned(
                        top: 6,
                        right: 42,
                        child: IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
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
                        top: 6,
                        right: 0,
                        child: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _showDeleteDialog(context, recipe),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      recipe.recipeName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, AddRecipeModel recipe) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Text("Delete Recipe"),
          content: const Text("Are you sure you want to delete this recipe?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
                onDelete(recipe);
              },
              child: const Text("Delete", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}