import 'package:flutter/material.dart';
import 'package:ripefo/models/recipe_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ripefo/screens/recipe_details.dart';

class SearchHistoryList extends StatelessWidget {
  final List<RecipeModel> recipes;
  final Function(RecipeModel) onRecipeTap;
  final String Function(DateTime?) formatVisitedDate;

  const SearchHistoryList({
    required this.recipes,
    required this.onRecipeTap,
    required this.formatVisitedDate,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: recipes.length > 3 ? 3 : recipes.length,
      itemBuilder: (context, index) {
        final recipe = recipes[index];
        return GestureDetector(
          onTap: () => onRecipeTap(recipe),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
              ],
            ),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: recipe.image,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const CircularProgressIndicator(),
                ),
              ),
              title: Text(recipe.label, style: const TextStyle(fontWeight: FontWeight.w600)),
              subtitle: Text(
                formatVisitedDate(recipe.visitedDate),
                style: const TextStyle(color: Colors.grey),
              ),
            ),
          ),
        );
      },
    );
  }
}