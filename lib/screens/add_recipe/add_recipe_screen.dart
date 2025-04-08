import 'package:flutter/material.dart';
import 'package:ripefo/models/recipe_model.dart';
import 'package:ripefo/screens/add_recipe/add_recipe_functions.dart';
import 'package:ripefo/screens/add_recipe/add_recipe_widgets.dart';

class AddRecipeScreen extends StatefulWidget {
  final AddRecipeModel? recipe;

  const AddRecipeScreen({super.key, this.recipe});

  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final AddRecipeController controller = AddRecipeController();

  @override
  void initState() {
    super.initState();
    controller.initialize(widget.recipe);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return buildAddRecipeScaffold(context, controller, setState);
  }
}
