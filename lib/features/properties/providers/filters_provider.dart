import 'package:flutter_riverpod/flutter_riverpod.dart';

enum SortOption {
  priceAsc('Precio: Menor a mayor'),
  priceDesc('Precio: Mayor a menor'),
  city('Ciudad A-Z');

  final String label;
  const SortOption(this.label);
}

class FiltersState {
  final Set<String> selectedCities;
  final double minPrice;
  final double maxPrice;
  final SortOption sortOption;

  const FiltersState({
    this.selectedCities = const {},
    this.minPrice = 0,
    this.maxPrice = 1000000,
    this.sortOption = SortOption.priceAsc,
  });

  bool get hasActiveFilters =>
      selectedCities.isNotEmpty || minPrice > 0 || maxPrice < 1000000;

  FiltersState copyWith({
    Set<String>? selectedCities,
    double? minPrice,
    double? maxPrice,
    SortOption? sortOption,
  }) {
    return FiltersState(
      selectedCities: selectedCities ?? this.selectedCities,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      sortOption: sortOption ?? this.sortOption,
    );
  }
}

class FiltersNotifier extends StateNotifier<FiltersState> {
  FiltersNotifier() : super(const FiltersState());

  void toggleCity(String city) {
    final cities = Set<String>.from(state.selectedCities);
    if (cities.contains(city)) {
      cities.remove(city);
    } else {
      cities.add(city);
    }
    state = state.copyWith(selectedCities: cities);
  }

  void setPriceRange(double min, double max) {
    state = state.copyWith(minPrice: min, maxPrice: max);
  }

  void setSortOption(SortOption option) {
    state = state.copyWith(sortOption: option);
  }

  void clearFilters() {
    state = const FiltersState();
  }
}

final filtersProvider = StateNotifierProvider<FiltersNotifier, FiltersState>(
  (ref) => FiltersNotifier(),
);
