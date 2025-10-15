import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/providers.dart';
import '../models/property.dart';
import '../widgets/property_card.dart';
import '../widgets/search_bar_widget.dart';

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
    final propertiesState = ref.watch(propertiesNotifierProvider);
    final favoritesState = ref.watch(favoritesNotifierProvider);
    final themeMode = ref.watch(themeModeProvider);
    final favoriteCount = favoritesState.maybeWhen(
      data: (favorites) => favorites.length,
      orElse: () => 0,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ideal',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.surface,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        actions: [
          // Botón para cambiar tema
          IconButton(
            icon: Icon(
              themeMode == ThemeMode.light ? Icons.dark_mode : Icons.light_mode,
            ),
            onPressed: () {
              ref.read(themeModeProvider.notifier).toggleTheme();
            },
            tooltip: themeMode == ThemeMode.light
                ? 'Modo Oscuro'
                : 'Modo Claro',
          ),
          // Botón de favoritos con badge
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.favorite),
                onPressed: () => context.push('/favorites'),
                tooltip: 'Mis Favoritos',
              ),
              if (favoriteCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
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
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          // Barra de búsqueda
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SearchBarWidget(
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

          // Lista de propiedades
          Expanded(
            child: propertiesState.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => _buildErrorWidget(error),
              data: (properties) => _buildPropertiesList(properties),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget(Object error) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Error al cargar propiedades',
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
              child: const Text('Reintentar'),
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

  Widget _buildPropertiesList(List<Property> properties) {
    if (properties.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.search_off, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              'No se encontraron propiedades',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Intenta con otros términos de búsqueda',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        ref
            .read(propertiesNotifierProvider.notifier)
            .loadProperties(refresh: true);
      },
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.all(16),
        itemCount: properties.length + 1, // +1 para el indicador de carga
        itemBuilder: (context, index) {
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
        },
      ),
    );
  }
}
