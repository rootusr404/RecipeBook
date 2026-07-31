import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_book/models/category.dart';
import 'package:recipe_book/widgets/category_filter_bar.dart';

void main() {
  testWidgets('CategoryFilterBar shows categories and reacts to selection', (tester) async {
    const cat = Category(id: 'c1', name: 'Dessert', icon: Icons.cake);
    String? selected;

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: CategoryFilterBar(
          categories: const [cat],
          selectedCategoryId: null,
          onSelected: (id) => selected = id,
        ),
      ),
    ));

    expect(find.text('Toutes'), findsOneWidget);
    expect(find.text('Dessert'), findsOneWidget);

    await tester.tap(find.text('Dessert'));
    expect(selected, 'c1');
  });
}