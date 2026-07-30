# RecipeBook 🍲

Application Flutter multi-écrans de gestion de recettes de cuisine — projet réalisé dans le cadre de la certification Flutter (multi-screen app with navigation).

## Fonctionnalités

- Liste des recettes avec recherche en temps réel et filtre par catégorie
- Détail d'une recette (image, ingrédients, description)
- Ajout d'une recette via un formulaire validé (4 champs)
- Thème clair / sombre

## Correspondance avec les exigences du projet

| Exigence | Implémentation |
|---|---|
| 4 écrans distincts | `lib/screens/home_screen.dart`, `detail_screen.dart`, `add_recipe_screen.dart`, `settings_screen.dart` |
| Navigation GoRouter, routes nommées | `lib/router/app_router.dart` (routes `home`, `detail`, `add`, `settings`) |
| Liste + recherche/filtrage | `HomeScreen` + `SearchBarWidget` + filtre par catégorie (ChoiceChip) |
| Détail + passage de paramètre | `DetailScreen(recipe: recipe)` reçu via `state.extra` dans le router |
| Formulaire ≥ 3 champs validés | `AddRecipeScreen` (titre, temps, ingrédients, difficulté, catégorie) |
| Thème clair/sombre | `lib/theme/app_theme.dart` + `ThemeController` (`ChangeNotifier`) |
| ≥ 8 widgets différents | Scaffold, AppBar, GridView, ListView, Card, InkWell, TextField, DropdownButtonFormField, SliverAppBar, Stack, Chip, ChoiceChip, FloatingActionButton, SwitchListTile |
| ≥ 3 widgets réutilisables dans `widgets/` | `RecipeCard`, `SearchBarWidget`, `SectionTitle` |
| Responsive mobile/tablette | `lib/utils/responsive.dart`, GridView adaptatif (2 colonnes mobile / 3 tablette) |
| Pas de données en dur dans les widgets | `assets/data/recipes.json`, `assets/data/categories.json`, chargés via les repositories |

## Architecture
- lib/
- models/ -> modèles de données (Recipe, Category)
- data/ -> Repository<T> générique (interface) + implémentations JSON
- router/ -> configuration GoRouter (routes nommées)
- theme/ -> thèmes clair/sombre + contrôleur
- screens/ -> écrans de l'application
- widgets/ -> composants réutilisables
- utils/ -> helpers (responsive)

### Choix de conception

- **Repository générique (`Repository<T>`)** : interface commune implémentée par `RecipeRepository` et `CategoryRepository`, pour garantir une séparation stricte entre les écrans et la source de données (actuellement des fichiers JSON en assets, remplaçable par une API sans toucher aux écrans).
- **Immutabilité des modèles** : `Recipe` et `Category` utilisent des champs `final` et des constructeurs `const`.
- **State management léger** : `StatefulWidget` + `setState` pour les écrans, `ChangeNotifier` pour le thème — suffisant à cette échelle, mais migrable vers Provider/Riverpod si le projet grandit.

## Lancer le projet

```bash
flutter pub get
flutter run
```

## Lancer les tests

```bash
flutter test
```

5 tests couvrant : modèles (sérialisation), repository (chargement asset + recherche), widget (affichage + interaction).

## CI/CD

Un workflow GitHub Actions (`.github/workflows/flutter_ci.yml`) exécute `flutter analyze` et `flutter test` à chaque push/PR sur `main`.

## Captures d'écran

| Accueil | Détail | Formulaire | Réglages |
|---|---|---|---|
| ![home](screenshots/home.png) | ![detail](screenshots/detail.png) | ![form](screenshots/form.png) | ![settings](screenshots/settings.png) |
