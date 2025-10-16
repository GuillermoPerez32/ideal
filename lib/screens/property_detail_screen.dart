import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../providers/providers.dart';
import '../models/property.dart';
import '../l10n/app_localizations.dart';
import '../features/settings/providers/settings_provider.dart';
import '../core/utils/currency_formatter.dart';

class PropertyDetailScreen extends ConsumerWidget {
  final String propertyId;

  const PropertyDetailScreen({super.key, required this.propertyId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final propertyState = ref.watch(propertyDetailProvider(propertyId));
    final favoritesState = ref.watch(favoritesNotifierProvider);

    return Scaffold(
      body: propertyState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => _buildErrorWidget(context, error, ref),
        data: (property) =>
            _buildPropertyDetail(context, ref, property, favoritesState),
      ),
    );
  }

  Widget _buildErrorWidget(BuildContext context, Object error, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                l10n.errorLoadingProperty,
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                error.toString(),
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  ref.invalidate(propertyDetailProvider(propertyId));
                },
                child: Text(l10n.retry),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPropertyDetail(
    BuildContext context,
    WidgetRef ref,
    Property property,
    AsyncValue<Set<String>> favoritesState,
  ) {
    final l10n = AppLocalizations.of(context)!;
    final isFavorite = favoritesState.maybeWhen(
      data: (favorites) => favorites.contains(property.id),
      orElse: () => false,
    );

    // Obtener configuración de moneda
    final settingsAsync = ref.watch(preferencesServiceProvider);
    final currency = settingsAsync.maybeWhen(
      data: (_) => ref.watch(settingsProvider).currency,
      orElse: () => 'USD',
    );

    return CustomScrollView(
      slivers: [
        // App Bar con imagen
        SliverAppBar(
          expandedHeight: 300,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            background: Hero(
              tag: 'property-image-${property.id}',
              child: CachedNetworkImage(
                imageUrl: property.image,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Colors.grey[300],
                  child: const Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(
                      Icons.image_not_supported,
                      size: 48,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          ),
          actions: [
            Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.9),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : Colors.grey[600],
                ),
                onPressed: () {
                  ref
                      .read(favoritesNotifierProvider.notifier)
                      .toggleFavorite(property.id);
                },
              ),
            ),
          ],
        ),

        // Contenido de la propiedad
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Título y precio
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            property.title,
                            style: Theme.of(context).textTheme.headlineMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 20,
                                color: Colors.grey[600],
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  property.city,
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(color: Colors.grey[600]),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          CurrencyFormatter.format(property.price, currency),
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Descripción
                Text(
                  l10n.description,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Text(
                  property.description,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(height: 1.6),
                ),

                const SizedBox(height: 32),

                // Botón de contacto
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _showContactDialog(context);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      l10n.contactAgent,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showContactDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.contactAgent),
        content: Text(l10n.contactAgentDescription),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.understood),
          ),
        ],
      ),
    );
  }
}
