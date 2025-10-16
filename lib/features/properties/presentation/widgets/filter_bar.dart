import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../l10n/app_localizations.dart';
import '../../providers/filters_provider.dart';

class FilterBar extends ConsumerStatefulWidget {
  final List<String> availableCities;

  const FilterBar({super.key, required this.availableCities});

  @override
  ConsumerState<FilterBar> createState() => _FilterBarState();
}

class _FilterBarState extends ConsumerState<FilterBar> {
  RangeValues? _currentRangeValues;

  @override
  Widget build(BuildContext context) {
    final filters = ref.watch(filtersProvider);
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    // Initialize or sync the current range values
    _currentRangeValues ??= RangeValues(filters.minPrice, filters.maxPrice);

    // If filters were cleared externally, reset the local state
    if (!filters.hasActiveFilters &&
        (_currentRangeValues!.start != 0 || _currentRangeValues!.end != 5000)) {
      _currentRangeValues = RangeValues(filters.minPrice, filters.maxPrice);
    }

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
        if (widget.availableCities.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(l10n.cities, style: theme.textTheme.labelLarge),
          ),
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: widget.availableCities.length,
              itemBuilder: (context, index) {
                final city = widget.availableCities[index];
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
                    '\$${_currentRangeValues!.start.toInt()} - \$${_currentRangeValues!.end.toInt()}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              RangeSlider(
                values: _currentRangeValues!,
                min: 0,
                max: 5000,
                divisions: 500,
                labels: RangeLabels(
                  '\$${_currentRangeValues!.start.toInt()}',
                  '\$${_currentRangeValues!.end.toInt()}',
                ),
                onChanged: (values) {
                  setState(() {
                    _currentRangeValues = values;
                  });
                },
                onChangeEnd: (values) {
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
