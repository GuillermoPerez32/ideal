import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In es, this message translates to:
  /// **'Ideal'**
  String get appTitle;

  /// No description provided for @home.
  ///
  /// In es, this message translates to:
  /// **'Inicio'**
  String get home;

  /// No description provided for @favorites.
  ///
  /// In es, this message translates to:
  /// **'Favoritos'**
  String get favorites;

  /// No description provided for @profile.
  ///
  /// In es, this message translates to:
  /// **'Perfil'**
  String get profile;

  /// No description provided for @settings.
  ///
  /// In es, this message translates to:
  /// **'Configuración'**
  String get settings;

  /// No description provided for @login.
  ///
  /// In es, this message translates to:
  /// **'Iniciar sesión'**
  String get login;

  /// No description provided for @logout.
  ///
  /// In es, this message translates to:
  /// **'Cerrar sesión'**
  String get logout;

  /// No description provided for @email.
  ///
  /// In es, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In es, this message translates to:
  /// **'Contraseña'**
  String get password;

  /// No description provided for @welcome.
  ///
  /// In es, this message translates to:
  /// **'Bienvenido'**
  String get welcome;

  /// No description provided for @loginToContinue.
  ///
  /// In es, this message translates to:
  /// **'Inicia sesión para continuar'**
  String get loginToContinue;

  /// No description provided for @emailRequired.
  ///
  /// In es, this message translates to:
  /// **'El email es requerido'**
  String get emailRequired;

  /// No description provided for @invalidEmail.
  ///
  /// In es, this message translates to:
  /// **'Email inválido'**
  String get invalidEmail;

  /// No description provided for @passwordRequired.
  ///
  /// In es, this message translates to:
  /// **'La contraseña es requerida'**
  String get passwordRequired;

  /// No description provided for @minimumCharacters.
  ///
  /// In es, this message translates to:
  /// **'Mínimo 6 caracteres'**
  String get minimumCharacters;

  /// No description provided for @loginTip.
  ///
  /// In es, this message translates to:
  /// **'Usa cualquier email con @ y contraseña de 6+ caracteres'**
  String get loginTip;

  /// No description provided for @darkMode.
  ///
  /// In es, this message translates to:
  /// **'Modo Oscuro'**
  String get darkMode;

  /// No description provided for @lightMode.
  ///
  /// In es, this message translates to:
  /// **'Modo Claro'**
  String get lightMode;

  /// No description provided for @myFavorites.
  ///
  /// In es, this message translates to:
  /// **'Mis Favoritos'**
  String get myFavorites;

  /// No description provided for @myProfile.
  ///
  /// In es, this message translates to:
  /// **'Mi Perfil'**
  String get myProfile;

  /// No description provided for @noFavoritesYet.
  ///
  /// In es, this message translates to:
  /// **'No tienes favoritos aún'**
  String get noFavoritesYet;

  /// No description provided for @exploreFavorites.
  ///
  /// In es, this message translates to:
  /// **'Explora propiedades y marca tus favoritas tocando el ícono de corazón'**
  String get exploreFavorites;

  /// No description provided for @exploreProperties.
  ///
  /// In es, this message translates to:
  /// **'Explorar Propiedades'**
  String get exploreProperties;

  /// No description provided for @errorLoadingFavorites.
  ///
  /// In es, this message translates to:
  /// **'Error al cargar favoritos'**
  String get errorLoadingFavorites;

  /// No description provided for @favoriteProperty.
  ///
  /// In es, this message translates to:
  /// **'propiedad favorita'**
  String get favoriteProperty;

  /// No description provided for @favoriteProperties.
  ///
  /// In es, this message translates to:
  /// **'propiedades favoritas'**
  String get favoriteProperties;

  /// No description provided for @errorLoadingProperties.
  ///
  /// In es, this message translates to:
  /// **'Error al cargar propiedades'**
  String get errorLoadingProperties;

  /// No description provided for @retry.
  ///
  /// In es, this message translates to:
  /// **'Reintentar'**
  String get retry;

  /// No description provided for @noPropertiesFound.
  ///
  /// In es, this message translates to:
  /// **'No se encontraron propiedades'**
  String get noPropertiesFound;

  /// No description provided for @adjustFiltersOrSearch.
  ///
  /// In es, this message translates to:
  /// **'Intenta ajustar los filtros o términos de búsqueda'**
  String get adjustFiltersOrSearch;

  /// No description provided for @noPropertiesAvailable.
  ///
  /// In es, this message translates to:
  /// **'No hay propiedades disponibles en este momento'**
  String get noPropertiesAvailable;

  /// No description provided for @clearFilters.
  ///
  /// In es, this message translates to:
  /// **'Limpiar filtros'**
  String get clearFilters;

  /// No description provided for @search.
  ///
  /// In es, this message translates to:
  /// **'Buscar'**
  String get search;

  /// No description provided for @searchProperties.
  ///
  /// In es, this message translates to:
  /// **'Buscar propiedades...'**
  String get searchProperties;

  /// No description provided for @appearance.
  ///
  /// In es, this message translates to:
  /// **'Apariencia'**
  String get appearance;

  /// No description provided for @theme.
  ///
  /// In es, this message translates to:
  /// **'Tema'**
  String get theme;

  /// No description provided for @system.
  ///
  /// In es, this message translates to:
  /// **'Sistema'**
  String get system;

  /// No description provided for @light.
  ///
  /// In es, this message translates to:
  /// **'Claro'**
  String get light;

  /// No description provided for @dark.
  ///
  /// In es, this message translates to:
  /// **'Oscuro'**
  String get dark;

  /// No description provided for @followsDevice.
  ///
  /// In es, this message translates to:
  /// **'Sigue el tema del dispositivo'**
  String get followsDevice;

  /// No description provided for @language.
  ///
  /// In es, this message translates to:
  /// **'Idioma'**
  String get language;

  /// No description provided for @spanish.
  ///
  /// In es, this message translates to:
  /// **'Español'**
  String get spanish;

  /// No description provided for @english.
  ///
  /// In es, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @currency.
  ///
  /// In es, this message translates to:
  /// **'Moneda'**
  String get currency;

  /// No description provided for @usdDollar.
  ///
  /// In es, this message translates to:
  /// **'USD - Dólar'**
  String get usdDollar;

  /// No description provided for @eurEuro.
  ///
  /// In es, this message translates to:
  /// **'EUR - Euro'**
  String get eurEuro;

  /// No description provided for @data.
  ///
  /// In es, this message translates to:
  /// **'Datos'**
  String get data;

  /// No description provided for @clearCache.
  ///
  /// In es, this message translates to:
  /// **'Limpiar caché'**
  String get clearCache;

  /// No description provided for @freeUpStorage.
  ///
  /// In es, this message translates to:
  /// **'Libera espacio de almacenamiento'**
  String get freeUpStorage;

  /// No description provided for @cacheCleared.
  ///
  /// In es, this message translates to:
  /// **'Caché limpiado correctamente'**
  String get cacheCleared;

  /// No description provided for @sortBy.
  ///
  /// In es, this message translates to:
  /// **'Ordenar por'**
  String get sortBy;

  /// No description provided for @priceLowToHigh.
  ///
  /// In es, this message translates to:
  /// **'Precio: Menor a mayor'**
  String get priceLowToHigh;

  /// No description provided for @priceHighToLow.
  ///
  /// In es, this message translates to:
  /// **'Precio: Mayor a menor'**
  String get priceHighToLow;

  /// No description provided for @cityAZ.
  ///
  /// In es, this message translates to:
  /// **'Ciudad A-Z'**
  String get cityAZ;

  /// No description provided for @cities.
  ///
  /// In es, this message translates to:
  /// **'Ciudades'**
  String get cities;

  /// No description provided for @priceRange.
  ///
  /// In es, this message translates to:
  /// **'Rango de precio'**
  String get priceRange;

  /// No description provided for @pageNotFound.
  ///
  /// In es, this message translates to:
  /// **'Página no encontrada'**
  String get pageNotFound;

  /// No description provided for @goToHome.
  ///
  /// In es, this message translates to:
  /// **'Ir al inicio'**
  String get goToHome;

  /// No description provided for @error.
  ///
  /// In es, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @errorLoadingProperty.
  ///
  /// In es, this message translates to:
  /// **'Error al cargar la propiedad'**
  String get errorLoadingProperty;

  /// No description provided for @description.
  ///
  /// In es, this message translates to:
  /// **'Descripción'**
  String get description;

  /// No description provided for @contactAgent.
  ///
  /// In es, this message translates to:
  /// **'Contactar agente'**
  String get contactAgent;

  /// No description provided for @contactAgentDescription.
  ///
  /// In es, this message translates to:
  /// **'Esta es una aplicación de demostración. En una aplicación real, aquí se mostraría la información de contacto del agente.'**
  String get contactAgentDescription;

  /// No description provided for @cancel.
  ///
  /// In es, this message translates to:
  /// **'Cancelar'**
  String get cancel;

  /// No description provided for @understood.
  ///
  /// In es, this message translates to:
  /// **'Entendido'**
  String get understood;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
