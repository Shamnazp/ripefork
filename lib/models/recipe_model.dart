import 'package:hive/hive.dart';
part 'recipe_model.g.dart';

// =================== AddRecipeModel ===================
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

  RecipeModel({
    required this.uri,
    required this.label,
    required this.image,
    required this.source,
    required this.ingredients,
    this.visitedDate,
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
      
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'uri': uri,
      'label': label,
      'image': image,
      'source': source,
      'ingredients': ingredients,

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
        subcategories: ["Tomato", "Onion", "Green Chilly", "Pumpkin"],
      ),
      CategoryModel(
        name: "Non-Veg",
        imageUrl: "https://example.com/nonveg.jpg",
        query: "nonveg",
        subcategories: ["Chicken", "Beef", "Fish", "Prawns", "Meat"],
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



// ================
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