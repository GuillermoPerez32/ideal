import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../core/di.dart';
import '../services/property_api_service.dart';
import '../services/favorites_service.dart';
import '../models/property.dart';

// Providers de servicios
final propertyApiServiceProvider = Provider<PropertyApiService>((ref) {
  return getIt<PropertyApiService>();
});

final favoritesServiceProvider = Provider<FavoritesService>((ref) {
  return getIt<FavoritesService>();
});

// Provider para búsqueda
final searchQueryProvider = StateProvider<String>((ref) => '');

// Provider para propiedades
final propertiesProvider = FutureProvider.family<List<Property>, int>((
  ref,
  page,
) async {
  final apiService = ref.read(propertyApiServiceProvider);
  final searchQuery = ref.watch(searchQueryProvider);

  if (searchQuery.isNotEmpty) {
    return await apiService.searchProperties(searchQuery);
  }

  return await apiService.getProperties(page: page, limit: 10);
});

// Provider para una propiedad específica
final propertyDetailProvider = FutureProvider.family<Property, String>((
  ref,
  id,
) async {
  final apiService = ref.read(propertyApiServiceProvider);
  return await apiService.getPropertyById(id);
});

// Provider para favoritos
final favoritesProvider = FutureProvider<Set<String>>((ref) async {
  final favoritesService = ref.read(favoritesServiceProvider);
  return await favoritesService.getFavorites();
});

// Provider para verificar si una propiedad es favorita
final isFavoriteProvider = FutureProvider.family<bool, String>((
  ref,
  propertyId,
) async {
  final favoritesService = ref.read(favoritesServiceProvider);
  return await favoritesService.isFavorite(propertyId);
});

// Notifier para manejar favoritos
class FavoritesNotifier extends StateNotifier<AsyncValue<Set<String>>> {
  final FavoritesService _favoritesService;

  FavoritesNotifier(this._favoritesService)
    : super(const AsyncValue.loading()) {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    try {
      final favorites = await _favoritesService.getFavorites();
      state = AsyncValue.data(favorites);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> toggleFavorite(String propertyId) async {
    try {
      await _favoritesService.toggleFavorite(propertyId);
      final updatedFavorites = await _favoritesService.getFavorites();
      state = AsyncValue.data(updatedFavorites);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  bool isFavorite(String propertyId) {
    return state.maybeWhen(
      data: (favorites) => favorites.contains(propertyId),
      orElse: () => false,
    );
  }
}

final favoritesNotifierProvider =
    StateNotifierProvider<FavoritesNotifier, AsyncValue<Set<String>>>((ref) {
      final favoritesService = ref.read(favoritesServiceProvider);
      return FavoritesNotifier(favoritesService);
    });

// Notifier para manejar la lista de propiedades con paginación
class PropertiesNotifier extends StateNotifier<AsyncValue<List<Property>>> {
  final PropertyApiService _apiService;
  int _currentPage = 1;
  bool _hasMoreData = true;
  final List<Property> _allProperties = [];

  PropertiesNotifier(this._apiService) : super(const AsyncValue.loading()) {
    loadProperties();
  }

  Future<void> loadProperties({bool refresh = false}) async {
    if (refresh) {
      _currentPage = 1;
      _hasMoreData = true;
      _allProperties.clear();
      state = const AsyncValue.loading();
    }

    if (!_hasMoreData) return;

    try {
      final newProperties = await _apiService.getProperties(
        page: _currentPage,
        limit: 10,
      );

      if (newProperties.isEmpty) {
        _hasMoreData = false;
      } else {
        _allProperties.addAll(newProperties);
        _currentPage++;
      }

      state = AsyncValue.data(List.from(_allProperties));
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> searchProperties(String query) async {
    state = const AsyncValue.loading();
    try {
      final searchResults = await _apiService.searchProperties(query);
      state = AsyncValue.data(searchResults);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  bool get hasMoreData => _hasMoreData;
}

final propertiesNotifierProvider =
    StateNotifierProvider<PropertiesNotifier, AsyncValue<List<Property>>>((
      ref,
    ) {
      final apiService = ref.read(propertyApiServiceProvider);
      return PropertiesNotifier(apiService);
    });

// Provider para el tema (modo claro/oscuro)
class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  ThemeModeNotifier() : super(ThemeMode.system);

  void toggleTheme() {
    state = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }

  void setThemeMode(ThemeMode mode) {
    state = mode;
  }
}

final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, ThemeMode>((
  ref,
) {
  return ThemeModeNotifier();
});
