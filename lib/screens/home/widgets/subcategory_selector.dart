import 'package:flutter/material.dart';
import 'package:ripefo/models/recipe_model.dart';

class SubcategorySelector extends StatelessWidget {
  final CategoryModel selectedCategory;
  final String? selectedSubcategory;
  final Function(String?) onSelectSubcategory;

  const SubcategorySelector({
    super.key,
    required this.selectedCategory,
    required this.selectedSubcategory,
    required this.onSelectSubcategory,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: [
        GestureDetector(
          onTap: () => onSelectSubcategory(null),
          child: _subcategoryChip("All", selectedSubcategory == null),
        ),
        ...selectedCategory.subcategories.map((sub) {
          return GestureDetector(
            onTap: () => onSelectSubcategory(sub),
            child: _subcategoryChip(sub, selectedSubcategory == sub),
          );
        }).toList(),
      ],
    );
  }

  Widget _subcategoryChip(String text, bool isSelected) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFF32121) : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isSelected ? const Color(0xFFF32121) : Colors.grey,
          width: 2,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: isSelected ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
