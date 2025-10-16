import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/settings_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Configuración')),
      body: ListView(
        children: [
          // Tema
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Apariencia',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 8),
                Card(
                  child: Column(
                    children: [
                      RadioListTile<ThemeMode>(
                        title: const Text('Sistema'),
                        subtitle: const Text('Sigue el tema del dispositivo'),
                        value: ThemeMode.system,
                        groupValue: settings.themeMode,
                        onChanged: (value) {
                          if (value != null) {
                            ref
                                .read(settingsProvider.notifier)
                                .setThemeMode(value);
                          }
                        },
                      ),
                      RadioListTile<ThemeMode>(
                        title: const Text('Claro'),
                        value: ThemeMode.light,
                        groupValue: settings.themeMode,
                        onChanged: (value) {
                          if (value != null) {
                            ref
                                .read(settingsProvider.notifier)
                                .setThemeMode(value);
                          }
                        },
                      ),
                      RadioListTile<ThemeMode>(
                        title: const Text('Oscuro'),
                        value: ThemeMode.dark,
                        groupValue: settings.themeMode,
                        onChanged: (value) {
                          if (value != null) {
                            ref
                                .read(settingsProvider.notifier)
                                .setThemeMode(value);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Idioma
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Idioma',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 8),
                Card(
                  child: Column(
                    children: [
                      RadioListTile<String>(
                        title: const Text('Español'),
                        value: 'es',
                        groupValue: settings.locale.languageCode,
                        onChanged: (value) {
                          if (value != null) {
                            ref
                                .read(settingsProvider.notifier)
                                .setLocale(value);
                          }
                        },
                      ),
                      RadioListTile<String>(
                        title: const Text('English'),
                        value: 'en',
                        groupValue: settings.locale.languageCode,
                        onChanged: (value) {
                          if (value != null) {
                            ref
                                .read(settingsProvider.notifier)
                                .setLocale(value);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Moneda
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Moneda',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 8),
                Card(
                  child: Column(
                    children: [
                      RadioListTile<String>(
                        title: const Text('USD - Dólar'),
                        subtitle: const Text('\$1,234.56'),
                        value: 'USD',
                        groupValue: settings.currency,
                        onChanged: (value) {
                          if (value != null) {
                            ref
                                .read(settingsProvider.notifier)
                                .setCurrency(value);
                          }
                        },
                      ),
                      RadioListTile<String>(
                        title: const Text('EUR - Euro'),
                        subtitle: const Text('€1.234,56'),
                        value: 'EUR',
                        groupValue: settings.currency,
                        onChanged: (value) {
                          if (value != null) {
                            ref
                                .read(settingsProvider.notifier)
                                .setCurrency(value);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Acciones
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Datos',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 8),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.delete_outline),
                    title: const Text('Limpiar caché'),
                    subtitle: const Text('Libera espacio de almacenamiento'),
                    onTap: () async {
                      await ref.read(settingsProvider.notifier).clearCache();
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Caché limpiado correctamente'),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
