import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ideal/features/auth/presentation/login_screen.dart';
import 'package:ideal/features/auth/providers/auth_provider.dart';
import 'package:ideal/features/profile/presentation/profile_screen.dart';
import 'package:ideal/features/settings/presentation/settings_screen.dart';
import 'package:ideal/screens/home_screen.dart';
import 'package:ideal/screens/property_detail_screen.dart';
import 'package:ideal/screens/favorites_screen.dart';

// Provider para el router con autenticación y protección de rutas
final goRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final isAuthenticated = authState.isAuthenticated;
      final isLoginRoute = state.matchedLocation == '/login';

      // Rutas protegidas
      final protectedRoutes = ['/favorites', '/profile', '/settings'];
      final isProtectedRoute = protectedRoutes.any(
        (route) => state.matchedLocation.startsWith(route),
      );

      // Si no está autenticado y trata de acceder a ruta protegida
      if (!isAuthenticated && isProtectedRoute) {
        return '/login';
      }

      // Si está autenticado y trata de acceder al login
      if (isAuthenticated && isLoginRoute) {
        return '/';
      }

      return null; // No redirect
    },
    routes: [
      // Home - Ruta pública
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),

      // Login
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),

      // Detalle de propiedad - Ruta pública
      GoRoute(
        path: '/property/:id',
        name: 'property-detail',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return PropertyDetailScreen(propertyId: id);
        },
      ),

      // Favoritos - Ruta protegida
      GoRoute(
        path: '/favorites',
        name: 'favorites',
        builder: (context, state) => const FavoritesScreen(),
      ),

      // Perfil - Ruta protegida
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) => const ProfileScreen(),
      ),

      // Configuración - Ruta protegida
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Página no encontrada',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: const Text('Ir al inicio'),
            ),
          ],
        ),
      ),
    ),
  );
});
