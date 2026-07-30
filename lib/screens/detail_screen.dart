import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../widgets/section_title.dart';

class DetailScreen extends StatelessWidget {
  final Recipe recipe;
  const DetailScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(recipe.title),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    recipe.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder:(_, _, _) => Container(color: Colors.grey),
                  ),
                  Container(color: Colors.black26),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.timer, size: 18),
                      Text(' ${recipe.prepTimeMinutes} min'),
                      const SizedBox(width: 12),
                      Chip(label: Text(recipe.difficulty)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(recipe.description),
                  const SectionTitle('Ingrédients'),
                  ...recipe.ingredients.map((i) => ListTile(
                        leading: const Icon(Icons.check_circle_outline),
                        title: Text(i),
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}