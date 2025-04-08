import 'package:flutter/material.dart';
import 'package:ripefo/models/recipe_model.dart';

class CategorySelector extends StatelessWidget {
  final List<CategoryModel> categories;
  final CategoryModel? selectedCategory;
  final Function(CategoryModel) onSelectCategory;

  const CategorySelector({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onSelectCategory,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map((category) {
          bool isSelected = selectedCategory?.name == category.name;
          Color borderColor =
              category.name == "Veg" ? Colors.green : Colors.red;
          Color fillColor = isSelected
              ? borderColor.withOpacity(0.3)
              : Colors.white;

          return GestureDetector(
            onTap: () => onSelectCategory(category),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: fillColor,
                border: Border.all(
                  color: borderColor,
                  width: isSelected ? 2.5 : 1.5,
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: borderColor,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
