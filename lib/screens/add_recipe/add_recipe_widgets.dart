import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ripefo/screens/add_recipe/add_recipe_functions.dart';

Widget buildAddRecipeScaffold(BuildContext context, AddRecipeController controller, void Function(void Function()) setStateCallback) {
  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      title: Text("Add Recipe", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildImagePicker(controller, setStateCallback),
          const SizedBox(height: 20),
          buildCardInput(controller.nameController, "Recipe Name", Icons.fastfood),
          buildCardInput(controller.sourceController, "Source", Icons.source),
          const SizedBox(height: 15),
          const Text("Ingredients", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          Column(
            children: controller.ingredientControllers.asMap().entries.map((entry) {
              int index = entry.key;
              var controllerField = entry.value;
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    Expanded(child: buildCardInput(controllerField, "Ingredient", Icons.kitchen)),
                    IconButton(
                      icon: const Icon(Icons.add_circle, color: Colors.green),
                      onPressed: () => setStateCallback(() => controller.addIngredientField()),
                    ),
                    IconButton(
                      icon: const Icon(Icons.remove_circle, color: Colors.red),
                      onPressed: () => setStateCallback(() => controller.removeIngredientField(index)),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          buildCardInput(controller.caloriesController, "Calories", Icons.local_fire_department),
          const SizedBox(height: 10),
          buildInstructionInput(controller.instructionsController),
          Center(
            child: SizedBox(
              width: 170,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () => controller.saveRecipe(context),
                child: const Text("Add Recipe", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildImagePicker(AddRecipeController controller, void Function(void Function()) setStateCallback) {
  return Center(
    child: GestureDetector(
      onTap: () => controller.pickImage((_) => setStateCallback(() {})),
      child: Stack(
        children: [
          CircleAvatar(
            radius: 60,
            backgroundColor: Colors.grey[300],
            backgroundImage: controller.image != null ? FileImage(controller.image!) : null,
            child: controller.image == null ? const Icon(Icons.camera_alt, color: Colors.grey, size: 30) : null,
          ),
          Positioned(
            bottom: 5,
            right: 5,
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              child: const Icon(Icons.edit, color: Colors.red, size: 18),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildCardInput(TextEditingController controller, String hint, IconData icon) {
  return Card(
    elevation: 3,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.red),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(hintText: hint, border: InputBorder.none),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildInstructionInput(TextEditingController controller) {
  return Card(
    elevation: 3,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.notes, color: Colors.red),
              SizedBox(width: 10),
              Text("Instructions", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
          TextField(
            controller: controller,
            maxLines: 5,
            decoration: const InputDecoration(
              hintText: "Enter detailed cooking instructions...",
              border: InputBorder.none,
            ),
          ),
        ],
      ),
    ),
  );
}