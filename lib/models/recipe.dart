class Recipe {
  final String id;
  final String title;
  final String categoryId;
  final String imageUrl;
  final int prepTimeMinutes;
  final String difficulty; // "Facile", "Moyen", "Difficile"
  final List<String> ingredients;
  final String description;

  const Recipe({
    required this.id,
    required this.title,
    required this.categoryId,
    required this.imageUrl,
    required this.prepTimeMinutes,
    required this.difficulty,
    required this.ingredients,
    required this.description,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'] as String,
      title: json['title'] as String,
      categoryId: json['categoryId'] as String,
      imageUrl: json['imageUrl'] as String,
      prepTimeMinutes: json['prepTimeMinutes'] as int,
      difficulty: json['difficulty'] as String,
      ingredients: List<String>.from(json['ingredients'] as List),
      description: json['description'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'categoryId': categoryId,
      'imageUrl': imageUrl,
      'prepTimeMinutes': prepTimeMinutes,
      'difficulty': difficulty,
      'ingredients': ingredients,
      'description': description,
    };
  }
}