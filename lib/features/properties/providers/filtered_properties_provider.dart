import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/property.dart';
import '../../../providers/providers.dart';
import 'filters_provider.dart';

/// Provider que combina propiedades con filtros y ordenamiento
final filteredPropertiesProvider = Provider<AsyncValue<List<Property>>>((ref) {
  final propertiesState = ref.watch(propertiesNotifierProvider);
  final filters = ref.watch(filtersProvider);

  return propertiesState.when(
    loading: () => const AsyncValue.loading(),
    error: (error, stack) => AsyncValue.error(error, stack),
    data: (properties) {
      var filtered = properties;

      // Aplicar filtro de búsqueda (ya viene filtrado del provider)
      // No necesitamos hacer nada aquí porque el PropertiesNotifier ya maneja la búsqueda

      // Aplicar filtro de ciudad
      if (filters.selectedCities.isNotEmpty) {
        filtered = filtered.where((p) {
          return filters.selectedCities.contains(p.city);
        }).toList();
      }

      // Aplicar filtro de rango de precio
      filtered = filtered.where((p) {
        return p.price >= filters.minPrice && p.price <= filters.maxPrice;
      }).toList();

      // Aplicar ordenamiento
      switch (filters.sortOption) {
        case SortOption.priceAsc:
          filtered.sort((a, b) => a.price.compareTo(b.price));
          break;
        case SortOption.priceDesc:
          filtered.sort((a, b) => b.price.compareTo(a.price));
          break;
        case SortOption.city:
          filtered.sort((a, b) => a.city.compareTo(b.city));
          break;
      }

      return AsyncValue.data(filtered);
    },
  );
});

/// Provider que obtiene la lista de ciudades disponibles
final availableCitiesProvider = Provider<List<String>>((ref) {
  final propertiesState = ref.watch(propertiesNotifierProvider);

  return propertiesState.maybeWhen(
    data: (properties) {
      final cities = properties.map((p) => p.city).toSet().toList();
      cities.sort();
      return cities;
    },
    orElse: () => [],
  );
});
