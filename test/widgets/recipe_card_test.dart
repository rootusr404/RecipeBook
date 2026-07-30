import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_book/models/recipe.dart';
import 'package:recipe_book/widgets/recipe_card.dart';

void main() {
  testWidgets('RecipeCard displays title and reacts to tap', (tester) async {
    const recipe = Recipe(
      id: 'r1',
      title: 'Salade César',
      categoryId: 'cat1',
      imageUrl: '',
      prepTimeMinutes: 15,
      difficulty: 'Facile',
      ingredients: ['laitue'],
      description: 'desc',
    );
    var tapped = false;

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: RecipeCard(recipe: recipe, onTap: () => tapped = true),
      ),
    ));

    expect(find.text('Salade César'), findsOneWidget);
    expect(find.text('Facile'), findsOneWidget);

    await tester.tap(find.byType(RecipeCard));
    expect(tapped, isTrue);
  });
}