import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_book/models/recipe.dart';

void main() {
  group('Recipe model', () {
    test('fromJson parses correctly', () {
      final json = {
        'id': 'r1',
        'title': 'Tarte',
        'categoryId': 'cat3',
        'imageUrl': '',
        'prepTimeMinutes': 30,
        'difficulty': 'Facile',
        'ingredients': ['pomme', 'sucre'],
        'description': 'desc',
      };
      final recipe = Recipe.fromJson(json);
      expect(recipe.title, 'Tarte');
      expect(recipe.ingredients.length, 2);
      expect(recipe.categoryId, 'cat3');
    });

    test('toJson round-trips correctly', () {
      const recipe = Recipe(
        id: 'r1',
        title: 'Tarte',
        categoryId: 'cat3',
        imageUrl: '',
        prepTimeMinutes: 30,
        difficulty: 'Facile',
        ingredients: ['pomme'],
        description: 'desc',
      );
      final json = recipe.toJson();
      expect(json['title'], 'Tarte');
      expect(json['prepTimeMinutes'], 30);
    });
  });
}