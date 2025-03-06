import 'dart:convert';
import 'package:http/http.dart' as http;

class RecipeService {
  static const String _apiKey =
      "e48b8468b1b6202b70df2ff573d9b0fe"; // Your API Key
  static const String _appId = "fed67870"; // Your App ID
  static const String _userId = "sharfana"; // Your Edamam User ID
  static const String _baseUrl = "https://api.edamam.com/api/recipes/v2";

  /// Fetch recipes based on query and category filter
  static Future<List<dynamic>> fetchRecipes(String query,
      {String category = "all"}) async {
    //  Apply category filter to query
    if (category == "veg") {
      query += " vegetarian";
    } else if (category == "nonveg") {
      query += " chicken OR beef OR fish OR meat";
    }

    final url = Uri.parse(
        "$_baseUrl?type=public&q=$query&app_id=$_appId&app_key=$_apiKey&to=10");

    try {
      final response = await http.get(
        url,
        headers: {"Edamam-Account-User": _userId},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        //  Handle potential null response
        if (data != null && data.containsKey('hits') && data['hits'] != null) {
          return data['hits'];
        } else {
          return [];
        }
      } else {
        throw Exception("Failed to load recipes: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching data: $e");
    }
  }
}
