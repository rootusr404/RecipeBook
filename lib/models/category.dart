import 'package:flutter/material.dart';

class Category {
  final String id;
  final String name;
  final IconData icon;

  const Category({required this.id, required this.name, required this.icon});

  factory Category.fromJson(Map<String, dynamic> json) {
  return Category(
    id: json['id'] as String,
    name: json['name'] as String,
    // ignore: non_const_argument_for_const_parameter
    icon: IconData(
      json['iconCodePoint'] as int,
      fontFamily: 'MaterialIcons',
    ),
  );
}

Map<String, dynamic> toJson() {
  return {'id': id, 'name': name, 'iconCodePoint': icon.codePoint};
}

}

