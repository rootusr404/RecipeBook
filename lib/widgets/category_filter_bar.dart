import 'package:flutter/material.dart';
import '../models/category.dart';

class CategoryFilterBar extends StatelessWidget {
  final List<Category> categories;
  final String? selectedCategoryId;
  final ValueChanged<String?> onSelected;

  const CategoryFilterBar({
    super.key,
    required this.categories,
    required this.selectedCategoryId,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          ChoiceChip(
            label: const Text('Toutes'),
            selected: selectedCategoryId == null,
            onSelected: (_) => onSelected(null),
          ),
          const SizedBox(width: 8),
          ...categories.map((c) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  avatar: Icon(c.icon, size: 16),
                  label: Text(c.name),
                  selected: selectedCategoryId == c.id,
                  onSelected: (_) => onSelected(c.id),
                ),
              )),
        ],
      ),
    );
  }
}