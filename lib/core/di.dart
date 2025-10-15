import 'package:get_it/get_it.dart';
import '../services/property_api_service.dart';
import '../services/favorites_service.dart';

final GetIt getIt = GetIt.instance;

void setupDependencies() {
  // Servicios
  getIt.registerLazySingleton<PropertyApiService>(() => PropertyApiService());
  getIt.registerLazySingleton<FavoritesService>(() => FavoritesService());
}
