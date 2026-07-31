import 'package:flutter/material.dart';
import '../data/recipe_repository.dart';
import '../data/category_repository.dart';
import '../models/recipe.dart';
import '../models/category.dart';

class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({super.key});
  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleCtrl = TextEditingController();
  final _timeCtrl = TextEditingController();
  final _ingredientsCtrl = TextEditingController();
  final _imageUrlCtrl = TextEditingController();
  String _difficulty = 'Facile';
  String? _categoryId;
  List<Category> _categories = [];

  final _recipeRepo = RecipeRepository();
  final _categoryRepo = CategoryRepository();

  @override
  void initState() {
    super.initState();
    _categoryRepo.getAll().then((cats) {
      setState(() {
        _categories = cats;
        _categoryId = cats.isNotEmpty ? cats.first.id : null;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nouvelle recette')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _titleCtrl,
              decoration: const InputDecoration(labelText: 'Titre'),
              validator: (v) => (v == null || v.trim().length < 3)
                  ? 'Titre trop court (min 3 caractères)'
                  : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _timeCtrl,
              decoration: const InputDecoration(labelText: 'Temps de préparation (min)'),
              keyboardType: TextInputType.number,
              validator: (v) {
                if (v == null || v.isEmpty) return 'Champ requis';
                final n = int.tryParse(v);
                if (n == null || n <= 0) return 'Entrez un nombre valide';
                return null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _imageUrlCtrl,
              decoration: const InputDecoration(labelText: 'URL de l\'image'),
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'Ajoutez une URL d\'image'
                  : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _ingredientsCtrl,
              decoration: const InputDecoration(
                labelText: 'Ingrédients (séparés par des virgules)',
              ),
              maxLines: 3,
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'Ajoutez au moins un ingrédient'
                  : null,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
             initialValue: _difficulty,
              decoration: const InputDecoration(labelText: 'Difficulté'),
              items: const ['Facile', 'Moyen', 'Difficile']
                  .map((d) => DropdownMenuItem(value: d, child: Text(d)))
                  .toList(),
              onChanged: (v) => setState(() => _difficulty = v!),
            ),
            const SizedBox(height: 12),
            if (_categories.isNotEmpty)
              DropdownButtonFormField<String>(
               initialValue: _categoryId,
                decoration: const InputDecoration(labelText: 'Catégorie'),
                items: _categories
                    .map((c) => DropdownMenuItem(value: c.id, child: Text(c.name)))
                    .toList(),
                onChanged: (v) => setState(() => _categoryId = v),
                validator: (v) => v == null ? 'Sélectionnez une catégorie' : null,
              ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _submit,
              child: const Text('Enregistrer'),
            ),
          ],
        ),
      ),
    );
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final recipe = Recipe(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: _titleCtrl.text.trim(),
      categoryId: _categoryId!,
      imageUrl: _imageUrlCtrl.text.trim(), 
      prepTimeMinutes: int.parse(_timeCtrl.text),
      difficulty: _difficulty,
      ingredients: _ingredientsCtrl.text.split(',').map((e) => e.trim()).toList(),
      description: '',
    );
    await _recipeRepo.add(recipe);
    if (mounted) Navigator.pop(context);
  }
}