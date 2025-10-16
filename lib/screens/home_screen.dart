import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/providers.dart';
import '../models/property.dart';
import '../widgets/property_card.dart';
import '../widgets/search_bar_widget.dart';
import '../features/properties/providers/filtered_properties_provider.dart';
import '../features/properties/providers/filters_provider.dart';
import '../features/properties/presentation/widgets/filter_bar.dart';
import '../features/properties/presentation/widgets/shimmer_placeholder.dart';
import '../../../l10n/app_localizations.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      // Cargar más datos cuando estemos cerca del final
      final notifier = ref.read(propertiesNotifierProvider.notifier);
      if (notifier.hasMoreData) {
        notifier.loadProperties();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final favoritesState = ref.watch(favoritesNotifierProvider);
    final favoriteCount = favoritesState.maybeWhen(
      data: (favorites) => favorites.length,
      orElse: () => 0,
    );

    return Scaffold(
      body: ref
          .watch(filteredPropertiesProvider)
          .when(
            loading: () => CustomScrollView(
              slivers: [
                _buildSliverAppBar(context, l10n, favoriteCount),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      FilterBar(
                        key: const ValueKey('filter_bar'),
                        availableCities: ref.watch(availableCitiesProvider),
                      ),
                      const Divider(height: 1),
                    ],
                  ),
                ),
                SliverFillRemaining(child: _buildShimmerLoading()),
              ],
            ),
            error: (error, stack) => CustomScrollView(
              slivers: [
                _buildSliverAppBar(context, l10n, favoriteCount),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      FilterBar(
                        key: const ValueKey('filter_bar'),
                        availableCities: ref.watch(availableCitiesProvider),
                      ),
                      const Divider(height: 1),
                    ],
                  ),
                ),
                SliverFillRemaining(child: _buildErrorWidget(error)),
              ],
            ),
            data: (properties) =>
                _buildMainContent(context, l10n, favoriteCount, properties),
          ),
    );
  }

  Widget _buildMainContent(
    BuildContext context,
    AppLocalizations l10n,
    int favoriteCount,
    List<Property> properties,
  ) {
    final filters = ref.watch(filtersProvider);
    final searchQuery = ref.watch(searchQueryProvider);

    if (properties.isEmpty) {
      return CustomScrollView(
        slivers: [
          _buildSliverAppBar(context, l10n, favoriteCount),
          SliverToBoxAdapter(
            child: Column(
              children: [
                FilterBar(
                  key: const ValueKey('filter_bar'),
                  availableCities: ref.watch(availableCitiesProvider),
                ),
                const Divider(height: 1),
              ],
            ),
          ),
          SliverFillRemaining(
            child: _buildEmptyState(l10n, filters, searchQuery),
          ),
        ],
      );
    }

    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        _buildSliverAppBar(context, l10n, favoriteCount),
        SliverToBoxAdapter(
          child: Column(
            children: [
              FilterBar(
                key: const ValueKey('filter_bar'),
                availableCities: ref.watch(availableCitiesProvider),
              ),
              const Divider(height: 1),
            ],
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              if (index == properties.length) {
                // Indicador de carga al final
                final notifier = ref.read(propertiesNotifierProvider.notifier);
                if (notifier.hasMoreData) {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                return const SizedBox.shrink();
              }

              final property = properties[index];
              return PropertyCard(
                property: property,
                onTap: () => context.push('/property/${property.id}'),
              );
            }, childCount: properties.length + 1),
          ),
        ),
      ],
    );
  }

  SliverAppBar _buildSliverAppBar(
    BuildContext context,
    AppLocalizations l10n,
    int favoriteCount,
  ) {
    return SliverAppBar(
      floating: true,
      pinned: true,
      snap: true,
      expandedHeight: 120,
      backgroundColor: Theme.of(context).colorScheme.surface,
      foregroundColor: Theme.of(context).colorScheme.onSurface,
      title: Text(
        l10n.appTitle,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      ),
      actions: [
        // Botón de favoritos con badge
        Stack(
          children: [
            IconButton(
              icon: const Icon(Icons.favorite),
              onPressed: () => context.push('/favorites'),
              tooltip: l10n.myFavorites,
            ),
            if (favoriteCount > 0)
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: Text(
                    favoriteCount > 9 ? '9+' : '$favoriteCount',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
        // Botón de perfil
        IconButton(
          icon: const Icon(Icons.person_outline),
          onPressed: () => context.push('/profile'),
          tooltip: l10n.myProfile,
        ),
        const SizedBox(width: 8),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Barra de búsqueda
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                child: SearchBarWidget(
                  hintText: l10n.searchProperties,
                  onChanged: (query) {
                    ref.read(searchQueryProvider.notifier).state = query;
                    if (query.isNotEmpty) {
                      ref
                          .read(propertiesNotifierProvider.notifier)
                          .searchProperties(query);
                    } else {
                      ref
                          .read(propertiesNotifierProvider.notifier)
                          .loadProperties(refresh: true);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorWidget(Object error) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              l10n.errorLoadingProperties,
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              _getErrorMessage(error),
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ref
                    .read(propertiesNotifierProvider.notifier)
                    .loadProperties(refresh: true);
              },
              child: Text(l10n.retry),
            ),
          ],
        ),
      ),
    );
  }

  String _getErrorMessage(Object error) {
    final errorStr = error.toString();
    // Extraer solo el mensaje relevante, no toda la traza
    if (errorStr.contains('ApiException:')) {
      final parts = errorStr.split('ApiException:');
      if (parts.length > 1) {
        // Tomar solo las primeras líneas del error
        final message = parts[1].trim();
        final lines = message.split('\n');
        return lines.first.trim();
      }
    }
    return errorStr.length > 200
        ? '${errorStr.substring(0, 200)}...'
        : errorStr;
  }

  Widget _buildShimmerLoading() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 5,
      itemBuilder: (context, index) => const PropertyCardSkeleton(),
    );
  }

  Widget _buildEmptyState(
    AppLocalizations l10n,
    FiltersState filters,
    String searchQuery,
  ) {
    final hasActiveFilters = filters.hasActiveFilters || searchQuery.isNotEmpty;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              hasActiveFilters ? Icons.filter_list_off : Icons.search_off,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 24),
            Text(
              l10n.noPropertiesFound,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              hasActiveFilters
                  ? l10n.adjustFiltersOrSearch
                  : l10n.noPropertiesAvailable,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
            if (hasActiveFilters) ...[
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () {
                  if (searchQuery.isNotEmpty) {
                    ref.read(searchQueryProvider.notifier).state = '';
                    ref
                        .read(propertiesNotifierProvider.notifier)
                        .loadProperties(refresh: true);
                  }
                  if (filters.hasActiveFilters) {
                    ref.read(filtersProvider.notifier).clearFilters();
                  }
                },
                icon: const Icon(Icons.clear_all),
                label: Text(l10n.clearFilters),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
