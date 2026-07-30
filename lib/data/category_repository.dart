import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/category.dart';
import 'repository.dart';

class CategoryRepository implements Repository<Category> {
  List<Category> _cache = [];

  Future<void> _ensureLoaded() async {
    if (_cache.isNotEmpty) return;
    final raw = await rootBundle.loadString('assets/data/categories.json');
    final List<dynamic> jsonList = jsonDecode(raw) as List<dynamic>;
    _cache = jsonList
        .map((e) => Category.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<Category>> getAll() async {
    await _ensureLoaded();
    return _cache;
  }

  @override
  Future<Category?> getById(String id) async {
    await _ensureLoaded();
    try {
      return _cache.firstWhere((c) => c.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> add(Category item) async {
    await _ensureLoaded();
    _cache.add(item);
  }
}