import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ripefo/models/recipe_model.dart';
import 'package:ripefo/screens/home.dart';
import 'package:ripefo/screens/profile.dart';
import 'package:ripefo/screens/saved_recipe.dart';
import 'package:ripefo/screens/search_recipe.dart';
import 'package:ripefo/services/hive_service.dart';

class AddRecipeScreen extends StatefulWidget {
  @override
  _AddRecipeScreenState createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController sourceController = TextEditingController();
  final List<TextEditingController> _ingredientControllers = [
TextEditingController()];
  final DatabaseService _databaseService = DatabaseService();
  File? _image;

  // Image picking function
  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // Function to add a new ingredient field
  void _addIngredientField() {
    setState(() {
      _ingredientControllers.add(TextEditingController());
    });
  }

  // Function to remove an ingredient field
  void _removeIngredientField(int index) {
    if (_ingredientControllers.length > 1) {
      setState(() {
        _ingredientControllers.removeAt(index);
      });
    }
  }

  // Function to add recipe to Hive database
  void _saveRecipe() async {
  if (_image == null || nameController.text.isEmpty || _ingredientControllers.any((c) => c.text.isEmpty)) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please add an image, recipe name, and ingredients')),
    );
    return;
  }

  final recipe = AddRecipeModel(
    imagePath: _image!.path,
    recipeName: nameController.text,
    source: sourceController.text,
    ingredients: _ingredientControllers.map((c) => c.text).toList(),
  );

  await _databaseService.addNewRecipe(recipe);

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Recipe added successfully!')),
  );

  // Clear fields after saving
  setState(() {
    nameController.clear();
    sourceController.clear();
    _ingredientControllers.forEach((controller) => controller.clear());
    _image = null;
  });

  // Navigate to Search Screen and Refresh Recipes
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => const SearchRecipeScreen()),
  );
}



  int _currentIndex = 2;
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
      appBar: AppBar(title: const Text('Add Recipe')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Add Image", style: TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(8),
                  image: _image != null
                      ? DecorationImage(
                          image: FileImage(_image!),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: _image == null
                    ? const Center(
                        child: Icon(Icons.add_a_photo, color: Colors.white, size: 40),
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 20),
            const Text("Recipe Name", style: TextStyle(fontSize: 16)),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: "Enter your recipe name",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            const Text("Source", style: TextStyle(fontSize: 16)),
            TextField(
              controller: sourceController,
              decoration: InputDecoration(
                hintText: "Enter source name",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                filled: true,
                fillColor: Colors.white.withOpacity(0.1),
              ),
            ),
            const SizedBox(height: 10),
            const Text("Ingredients", style: TextStyle(fontSize: 16)),
            Column(
              children: _ingredientControllers.asMap().entries.map((entry) {
                int index = entry.key;
                TextEditingController controller = entry.value;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller,
                          decoration: InputDecoration(
                            hintText: "Enter ingredient...",
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        icon: const Icon(Icons.add_circle, color: Colors.green),
                        onPressed: _addIngredientField,
                      ),
                      IconButton(
                        icon: const Icon(Icons.remove_circle, color: Colors.red),
                        onPressed: () => _removeIngredientField(index),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: _saveRecipe,
                child: const Text(
                  "Add Recipe",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
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
