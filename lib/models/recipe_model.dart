import 'package:hive/hive.dart';
part 'recipe_model.g.dart';

// =================== RecipeModel ===================
@HiveType(typeId: 1)
class RecipeModel {
  @HiveField(0)
  String uri;

  @HiveField(1)
  String label;

  @HiveField(2)
  String image;

  @HiveField(3)
  String source;

  @HiveField(4)
  List<String> ingredients;

  @HiveField(5)
  DateTime? visitedDate;

  @HiveField(6)
  double? calories;

  @HiveField(7)
  List<String>? healthLabels; // ✅ FIXED: Changed to List<String>


@HiveField(8)
  Map<String, dynamic>? totalNutrients; // ✅ ADDED: Total Nutrients Map


@HiveField(9)
  List<String>? instructions;

  RecipeModel({
    required this.uri,
    required this.label,
    required this.image,
    required this.source,
    required this.ingredients,
    this.visitedDate,
    this.calories, // Initialize Calories
    this.healthLabels,
    this.totalNutrients,
    this.instructions, // Include instructions

  });



 factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      uri: json['uri'],
      label: json['label'],
      image: json['image'],
      source: json['source'],
      ingredients: (json['ingredientLines'] as List<dynamic>?)
        ?.map((item) => item.toString())
        .toList() ?? [],

        calories: json['calories'] != null
          ? (json['calories'] as num).toDouble()
          : 0.0, // Fetch Calories

 healthLabels: json['healthLabels'] != null
          ? List<String>.from(json['healthLabels']) // ✅ FIXED: Parse correctly
          : [],
          

totalNutrients: json['totalNutrients'] != null
          ? Map<String, dynamic>.from(json['totalNutrients']) // ✅ ADDED: Parse correctly
          : {}, 

    
      instructions: json['instructions'] != null
          ? List<String>.from(json['instructions']) // If instructions exist
          : [json['url'] ?? "No instructions available"], 
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'uri': uri,
      'label': label,
      'image': image,
      'source': source,
      'ingredients': ingredients,
      'calories': calories, // Include Calories in JSON
      'healthLabels': healthLabels, // ✅ FIXED: Include in JSON
      'totalNutrients': totalNutrients, // ✅ Include Total Nutrients in JSON
      'instructions': instructions, // ✅ Include instructions


    };
  }
}


class CategoryModel {
  final String name;
  final String imageUrl;
  final String query;
  final List<String> subcategories;

  CategoryModel({
    required this.name,
    required this.imageUrl,
    required this.query,
    required this.subcategories,
  });

  // Method to get predefined categories
  static List<CategoryModel> getCategories() {
    return [
      CategoryModel(
        name: "Veg",
        imageUrl: "https://example.com/veg.jpg",
        query: "vegetarian",
        subcategories: ["Tomato", "Onion", "Green Chilly", "Pumpkin","Potato","Carrot","Radish"],
      ),
      CategoryModel(
        name: "Non-Veg",
        imageUrl: "https://example.com/nonveg.jpg",
        query: "non-veg",
        subcategories: ["Chicken", "Beef", "Fish", "Prawns", "Meat","Turkey","Duck","Pork","Squid",],
      ),
    ];
  }
}
  
// // =================== AddRecipeModel ===================
@HiveType(typeId: 5) // Unique ID
class AddRecipeModel {
  @HiveField(0)
  String imagePath;

  @HiveField(1)
  String recipeName;

  @HiveField(2)
  String source;

  @HiveField(3)
  List<String> ingredients;

  
  

  AddRecipeModel({
    required this.imagePath,
    required this.recipeName,
    required this.source,
    required this.ingredients,
  });
}



// ======save model==========
@HiveType(typeId: 4)
class SavedModel {
  @HiveField(0)
  String title;

  @HiveField(1)
  String imageUrl;

  @HiveField(2)
  int cookingTime;

  @HiveField(3)
  int likes;

  SavedModel({
    required this.title,
    required this.imageUrl,
    required this.cookingTime,
    required this.likes,
  });
}