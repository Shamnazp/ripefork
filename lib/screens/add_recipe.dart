import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ripefo/models/recipe_model.dart';
import 'package:ripefo/screens/home.dart';
import 'package:ripefo/screens/profile.dart';
import 'package:ripefo/screens/saved_recipe.dart';
import 'package:ripefo/screens/search_recipe.dart';
import 'package:ripefo/services/hive_service.dart';

class AddRecipeScreen extends StatefulWidget {
  final AddRecipeModel? recipe; // Optional parameter for editing

  AddRecipeScreen({this.recipe});

  @override
  _AddRecipeScreenState createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController sourceController = TextEditingController();
  final List<TextEditingController> _ingredientControllers = [];
  final TextEditingController caloriesController = TextEditingController();
final TextEditingController instructionsController = TextEditingController();
  final DatabaseService _databaseService = DatabaseService();
  File? _image;
  bool isEditing = false;
  int? recipeKey; // Key for updating the recipe in Hive
  @override
  void initState() {
    super.initState();
    if (widget.recipe != null) {
      isEditing = true;
      nameController.text = widget.recipe!.recipeName;
      sourceController.text = widget.recipe!.source;
      _image = File(widget.recipe!.imagePath);
      recipeKey = _databaseService.getKeyForRecipe(widget.recipe!);
      // Load New Fields if Editing
    caloriesController.text = widget.recipe!.calories.toString();
    instructionsController.text = widget.recipe!.instructions;

      for (var ingredient in widget.recipe!.ingredients) {
        _ingredientControllers.add(TextEditingController(text: ingredient));
      }
    } else {
      _ingredientControllers.add(TextEditingController());
    }
  }

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
  if (_image == null ||
      nameController.text.isEmpty ||
      _ingredientControllers.any((c) => c.text.isEmpty) ||
      caloriesController.text.isEmpty ||
      instructionsController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text('Please fill all fields including calories and instructions')),
    );
    return;
  }

  final recipe = AddRecipeModel(
    imagePath: _image!.path,
    recipeName: nameController.text,
    source: sourceController.text,
    ingredients: _ingredientControllers.map((c) => c.text).toList(),
    calories: int.tryParse(caloriesController.text) ?? 0, // Convert to int
    instructions: instructionsController.text,
  );

  if (isEditing && recipeKey != null) {
    await _databaseService.updateRecipe(recipeKey!, recipe);
  } else {
    await _databaseService.addNewRecipe(recipe);
  }

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        content: Text(isEditing
            ? 'Recipe updated successfully!'
            : 'Recipe added successfully!')),
  );

  // Navigate to Search Screen and Refresh Recipes
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => const SearchRecipeScreen()),
  );
}


  int _currentIndex = 2;
  void _onTabTapped(int index) {
    if (index == 1) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => SearchRecipeScreen()));
    }
    if (index == 2) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AddRecipeScreen()));
    }
    if (index == 3) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => SavedRecipesScreen()));
    }
    if (index == 4) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => ProfileScreen(email: '')));
    }
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Add Recipe",
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
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
            Center(
              child: GestureDetector(
                onTap: _pickImage,
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.grey[300],
                      backgroundImage:
                          _image != null ? FileImage(_image!) : null,
                      child: _image == null
                          ? const Icon(Icons.camera_alt,
                              color: Colors.grey, size: 30)
                          : null,
                    ),
                    Positioned(
                      bottom: 5,
                      right: 5,
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child:
                            const Icon(Icons.edit, color: Colors.red, size: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),
            // Card based Input Fields
            _buildCardInput(nameController, "Recipe Name", Icons.fastfood),
            _buildCardInput(sourceController, "Source", Icons.source),
            
            const SizedBox(height: 15),
            const Text(
              "Ingredients",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Column(
              children: _ingredientControllers.asMap().entries.map((entry) {
                int index = entry.key;
                TextEditingController controller = entry.value;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      Expanded(
                          child: _buildCardInput(
                              controller, "Ingredient", Icons.kitchen)),
                      IconButton(
                        icon: const Icon(Icons.add_circle, color: Colors.green),
                        onPressed: _addIngredientField,
                      ),
                      IconButton(
                        icon:
                            const Icon(Icons.remove_circle, color: Colors.red),
                        onPressed: () => _removeIngredientField(index),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            // Calories Input
_buildCardInput(caloriesController, "Calories", Icons.local_fire_department),

const SizedBox(height: 10),

// Instructions Input (Multiline)
Card(
  elevation: 3,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.notes, color: Colors.red),
            const SizedBox(width: 10),
            Text("Instructions", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
        TextField(
          controller: instructionsController,
          maxLines: 5,
          decoration: const InputDecoration(
            hintText: "Enter detailed cooking instructions...",
            border: InputBorder.none,
          ),
        ),
      ],
    ),
  ),
),


            
            Center(
              child: SizedBox(
                width: 170,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: _saveRecipe,
                  child: const Text(
                    "Add Recipe",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
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

  // Card-based Styled 
  Widget _buildCardInput(
      TextEditingController controller, String hint, IconData icon) {
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
                decoration: InputDecoration(
                  hintText: hint,
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
