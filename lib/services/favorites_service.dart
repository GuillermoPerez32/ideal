import 'package:shared_preferences/shared_preferences.dart';

class FavoritesService {
  static const String _favoritesKey = 'favorite_properties';

  SharedPreferences? _prefs;

  /// Ensure SharedPreferences instance is loaded once and reused
  Future<SharedPreferences> _getPrefs() async {
    if (_prefs != null) return _prefs!;
    _prefs = await SharedPreferences.getInstance();
    return _prefs!;
  }

  Future<Set<String>> getFavorites() async {
    try {
      final prefs = await _getPrefs();
      final favorites = prefs.getStringList(_favoritesKey) ?? [];
      return favorites.toSet();
    } catch (e) {
      throw FavoritesException('Error al cargar favoritos: $e');
    }
  }

  Future<void> addFavorite(String propertyId) async {
    try {
      final favorites = await getFavorites();
      favorites.add(propertyId);
      await _saveFavorites(favorites);
    } catch (e) {
      throw FavoritesException('Error al agregar favorito: $e');
    }
  }

  Future<void> removeFavorite(String propertyId) async {
    try {
      final favorites = await getFavorites();
      favorites.remove(propertyId);
      await _saveFavorites(favorites);
    } catch (e) {
      throw FavoritesException('Error al remover favorito: $e');
    }
  }

  Future<bool> isFavorite(String propertyId) async {
    try {
      final favorites = await getFavorites();
      return favorites.contains(propertyId);
    } catch (e) {
      return false;
    }
  }

  Future<void> toggleFavorite(String propertyId) async {
    final isCurrentlyFavorite = await isFavorite(propertyId);

    if (isCurrentlyFavorite) {
      await removeFavorite(propertyId);
    } else {
      await addFavorite(propertyId);
    }
  }

  Future<void> _saveFavorites(Set<String> favorites) async {
    final prefs = await _getPrefs();
    await prefs.setStringList(_favoritesKey, favorites.toList());
  }

  Future<void> clearAllFavorites() async {
    try {
      final prefs = await _getPrefs();
      await prefs.remove(_favoritesKey);
    } catch (e) {
      throw FavoritesException('Error al limpiar favoritos: $e');
    }
  }
}

class FavoritesException implements Exception {
  final String message;

  const FavoritesException(this.message);

  @override
  String toString() => 'FavoritesException: $message';
}
