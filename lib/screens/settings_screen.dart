import 'package:flutter/material.dart';
import '../main.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Réglages')),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Mode sombre'),
            value: themeController.mode == ThemeMode.dark,
            onChanged: (_) => themeController.toggle(),
          ),
        ],
      ),
    );
  }
}