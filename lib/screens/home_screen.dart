import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../data/recipe_repository.dart';
import '../data/category_repository.dart';
import '../models/recipe.dart';
import '../models/category.dart';
import '../widgets/recipe_card.dart';
import '../widgets/search_bar_widget.dart';
import '../utils/responsive.dart';
import '../router/app_router.dart';
import '../widgets/category_filter_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _recipeRepo = RecipeRepository();
  final _categoryRepo = CategoryRepository();

  List<Recipe> _filtered = [];
  List<Category> _categories = [];
  String _query = '';
  String? _selectedCategoryId;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final cats = await _categoryRepo.getAll();
    final results = await _recipeRepo.search('', categoryId: _selectedCategoryId);
    setState(() {
      _categories = cats;
      _filtered = results;
    });
  }

  Future<void> _applyFilters() async {
    final results = await _recipeRepo.search(_query, categoryId: _selectedCategoryId);
    setState(() => _filtered = results);
  }

  @override
  Widget build(BuildContext context) {
    final tablet = isTablet(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('RecipeBook'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.pushNamed(AppRoutes.settings),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await context.pushNamed(AppRoutes.add);
          _load();
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            SearchBarWidget(onChanged: (value) {
              _query = value;
              _applyFilters();
            }),
            const SizedBox(height: 12),
            CategoryFilterBar(
                categories: _categories,
                selectedCategoryId: _selectedCategoryId,
                onSelected: (id) {
                  _selectedCategoryId = id;
                  _applyFilters();
                },
            ),
            const SizedBox(height: 12),
            Expanded(
              child: _filtered.isEmpty
                  ? const Center(child: Text('Aucune recette trouvée'))
                  : GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: tablet ? 3 : 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 0.72,
                      ),
                      itemCount: _filtered.length,
                      itemBuilder: (context, i) {
                        final recipe = _filtered[i];
                        return RecipeCard(
                          recipe: recipe,
                          onTap: () => context.pushNamed(
                            AppRoutes.detail,
                            pathParameters: {'id': recipe.id},
                            extra: recipe,
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}