import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/recipe.dart';
import 'repository.dart';

class RecipeRepository implements Repository<Recipe> {
  List<Recipe> _cache = [];

  Future<void> _ensureLoaded() async {
    if (_cache.isNotEmpty) return;
    final raw = await rootBundle.loadString('assets/data/recipes.json');
    final List<dynamic> jsonList = jsonDecode(raw) as List<dynamic>;
    _cache = jsonList
        .map((e) => Recipe.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<Recipe>> getAll() async {
    await _ensureLoaded();
    return _cache;
  }

  @override
  Future<Recipe?> getById(String id) async {
    await _ensureLoaded();
    try {
      return _cache.firstWhere((r) => r.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> add(Recipe item) async {
    await _ensureLoaded();
    _cache.add(item);
  }

  Future<List<Recipe>> search(String query, {String? categoryId}) async {
    await _ensureLoaded();
    final q = query.toLowerCase();
    return _cache.where((r) {
      final matchesText = q.isEmpty || r.title.toLowerCase().contains(q);
      final matchesCategory = categoryId == null || r.categoryId == categoryId;
      return matchesText && matchesCategory;
    }).toList();
  }
}