import 'package:go_router/go_router.dart';
import '../screens/home_screen.dart';
import '../screens/detail_screen.dart';
import '../screens/add_recipe_screen.dart';
import '../screens/settings_screen.dart';
import '../models/recipe.dart';

class AppRoutes {
  static const home = 'home';
  static const detail = 'detail';
  static const add = 'add';
  static const settings = 'settings';
}

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: AppRoutes.home,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/recipe/:id',
      name: AppRoutes.detail,
      builder: (context, state) {
        final recipe = state.extra as Recipe;
        return DetailScreen(recipe: recipe);
      },
    ),
    GoRoute(
      path: '/add',
      name: AppRoutes.add,
      builder: (context, state) => const AddRecipeScreen(),
    ),
    GoRoute(
      path: '/settings',
      name: AppRoutes.settings,
      builder: (context, state) => const SettingsScreen(),
    ),
  ],
);