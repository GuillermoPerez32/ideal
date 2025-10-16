import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'router/app_router.dart';
import 'theme.dart';
import '../features/settings/providers/settings_provider.dart';

class IdealApp extends ConsumerWidget {
  const IdealApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);

    // Intentar obtener settings, si no está inicializado usar defaults
    final settingsAsync = ref.watch(preferencesServiceProvider);

    return settingsAsync.when(
      loading: () => const MaterialApp(
        home: Scaffold(body: Center(child: CircularProgressIndicator())),
      ),
      error: (_, __) => MaterialApp.router(
        title: 'Ideal',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        routerConfig: router,
      ),
      data: (_) {
        final settings = ref.watch(settingsProvider);

        return MaterialApp.router(
          title: 'Ideal',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: settings.themeMode,
          locale: settings.locale,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('es', ''), Locale('en', '')],
          routerConfig: router,
        );
      },
    );
  }
}
