import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_book/data/recipe_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('getAll returns non-empty list from asset', () async {
    final repo = RecipeRepository();
    final recipes = await repo.getAll();
    expect(recipes, isNotEmpty);
  });

  test('search filters by title', () async {
    final repo = RecipeRepository();
    final results = await repo.search('carbonara');
    expect(results, isNotEmpty);
    expect(results.first.title.toLowerCase(), contains('carbonara'));
  });

  test('search returns empty list for unknown query', () async {
    final repo = RecipeRepository();
    final results = await repo.search('inconnu-xyz-123');
    expect(results, isEmpty);
  });
}