import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../l10n/app_localizations.dart';
import '../../providers/filters_provider.dart';

class FilterBar extends ConsumerWidget {
  final List<String> availableCities;

  const FilterBar({super.key, required this.availableCities});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filters = ref.watch(filtersProvider);
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Ordenar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            children: [
              Icon(Icons.sort, size: 20, color: theme.colorScheme.primary),
              const SizedBox(width: 8),
              Expanded(
                child: DropdownButton<SortOption>(
                  value: filters.sortOption,
                  isExpanded: true,
                  underline: const SizedBox(),
                  items: [
                    DropdownMenuItem(
                      value: SortOption.priceAsc,
                      child: Text(l10n.priceLowToHigh),
                    ),
                    DropdownMenuItem(
                      value: SortOption.priceDesc,
                      child: Text(l10n.priceHighToLow),
                    ),
                    DropdownMenuItem(
                      value: SortOption.city,
                      child: Text(l10n.cityAZ),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      ref.read(filtersProvider.notifier).setSortOption(value);
                    }
                  },
                ),
              ),
            ],
          ),
        ),

        // Ciudades
        if (availableCities.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(l10n.cities, style: theme.textTheme.labelLarge),
          ),
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: availableCities.length,
              itemBuilder: (context, index) {
                final city = availableCities[index];
                final isSelected = filters.selectedCities.contains(city);
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: FilterChip(
                    label: Text(city),
                    selected: isSelected,
                    onSelected: (_) {
                      ref.read(filtersProvider.notifier).toggleCity(city);
                    },
                  ),
                );
              },
            ),
          ),
        ],

        // Rango de precio
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(l10n.priceRange, style: theme.textTheme.labelLarge),
                  Text(
                    '\$${filters.minPrice.toInt()} - \$${filters.maxPrice.toInt()}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              RangeSlider(
                values: RangeValues(filters.minPrice, filters.maxPrice),
                min: 0,
                max: 1000000,
                divisions: 100,
                labels: RangeLabels(
                  '\$${filters.minPrice.toInt()}',
                  '\$${filters.maxPrice.toInt()}',
                ),
                onChanged: (values) {
                  ref
                      .read(filtersProvider.notifier)
                      .setPriceRange(values.start, values.end);
                },
              ),
            ],
          ),
        ),

        // Limpiar filtros
        if (filters.hasActiveFilters)
          Center(
            child: TextButton.icon(
              onPressed: () {
                ref.read(filtersProvider.notifier).clearFilters();
              },
              icon: const Icon(Icons.clear),
              label: Text(l10n.clearFilters),
            ),
          ),
      ],
    );
  }
}
