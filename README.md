# Ideal - Real Estate App 🏡

Una aplicación Flutter para explorar propiedades inmobiliarias con búsqueda, favoritos y navegación intuitiva.

## 📸 Capturas de Pantalla

<p align="center">
  <img src="docs/home.png" alt="Pantalla Principal" width="300"/>
  <img src="docs/detail.png" alt="Detalle de Propiedad" width="300"/>
</p>

## 🎥 Demo

https://github.com/user-attachments/assets/demo.mp4

<!-- Si prefieres un enlace directo al video -->

[Ver video de demostración](docs/demo.mp4)

## 🏡 Características

### ✨ Funcionalidades Principales

- **Lista de propiedades**: Navegación con scroll infinito y paginación inteligente
- **Búsqueda con debounce**: Filtro optimizado por título o ciudad (500ms de espera)
- **Favoritos persistentes**: Marca propiedades como favoritas con almacenamiento local
- **Detalles completos**: Vista detallada de cada propiedad con Hero animations
- **Tema claro/oscuro**: Cambio dinámico entre temas con un botón en el AppBar
- **Shimmer loading**: Efectos de carga tipo skeleton para mejor UX
- **Navegación fluida**: Implementada con GoRouter y transiciones suaves
- **Cache de imágenes**: Carga optimizada con cached_network_image

### 🎨 Diseño y UX

- **Material Design 3**: Diseño moderno y consistente
- **Temas personalizados**: Sistema de temas bien estructurado y mantenible
- **Modo oscuro**: Soporte completo con colores optimizados
- **Animaciones**: Hero animations en imágenes de propiedades
- **Badge de favoritos**: Contador visual en el AppBar
- **Estados de carga**: Shimmer placeholders en lugar de spinners

## 🛠️ Tecnologías

### Core

- **Flutter SDK**: 3.35.3 - Framework principal multiplataforma
- **Dart SDK**: 3.9.2 - Lenguaje de programación

### Estado y Navegación

- **Riverpod**: 2.5.1 - Gestión de estado reactiva y robusta
- **GoRouter**: 14.2.7 - Navegación declarativa con rutas tipadas

### Networking y Persistencia

- **HTTP**: 1.2.2 - Cliente HTTP para consumo de APIs
- **Shared Preferences**: 2.3.2 - Persistencia local de favoritos
- **MockAPI.io**: Servicio de API REST simulada

### UI y Assets

- **Cached Network Image**: 3.4.1 - Cache inteligente de imágenes
- **Shimmer**: 3.0.0 - Efectos de carga skeleton
- **RxDart**: 0.28.0 - Streams reactivos para debounce de búsqueda

### Herramientas de Desarrollo

- **Get It**: 8.0.0 - Inyección de dependencias (Service Locator)
- **JSON Annotation**: 4.9.0 - Anotaciones para serialización
- **JSON Serializable**: 6.8.0 - Generación de código para JSON
- **Build Runner**: 2.4.13 - Herramienta de generación de código

## 📱 Estructura del Proyecto

```
lib/
├── core/
│   ├── app.dart                # Widget principal de la app (Consumer)
│   ├── di.dart                 # Configuración de dependencias (GetIt)
│   ├── router.dart             # Configuración de rutas (GoRouter)
│   └── theme.dart              # Sistema de temas claro/oscuro
├── models/
│   ├── property.dart           # Modelo de propiedad con JSON
│   └── paginated_response.dart # Modelo de respuesta paginada
├── providers/
│   └── providers.dart          # Providers de Riverpod + ThemeMode
├── screens/
│   ├── home_screen.dart        # Pantalla principal con búsqueda
│   ├── property_detail_screen.dart # Detalle con Hero animation
│   └── favorites_screen.dart   # Pantalla de favoritos
├── services/
│   ├── property_api_service.dart   # Servicio de API con isolates
│   └── favorites_service.dart      # Servicio de favoritos con cache
├── widgets/
│   ├── property_card.dart          # Card de propiedad reutilizable
│   ├── property_card_shimmer.dart  # Placeholder shimmer
│   ├── search_bar_widget.dart      # Búsqueda con debounce
│   └── filters_bottom_sheet.dart   # Bottom sheet de filtros
└── main.dart                       # Punto de entrada con ProviderScope

test/
└── widget_test.dart            # 7 tests de widgets (todos pasando ✅)

docs/
├── home.png                    # Screenshot de pantalla principal
├── detail.png                  # Screenshot de detalle
└── demo.mp4                    # Video de demostración
```

## 🚀 Configuración

### Prerrequisitos

- Flutter SDK (3.35.3 o superior)
- Dart SDK
- IDE compatible (VS Code, Android Studio)

### Instalación

1. **Clonar el repositorio**

   ```bash
   git clone <repository-url>
   cd ideal
   ```

2. **Instalar dependencias**

   ```bash
   flutter pub get
   ```

3. **Generar código JSON**

   ```bash
   dart run build_runner build
   ```

4. **Configurar MockAPI** (Opcional)

   El proyecto está configurado para usar MockAPI.io. Si quieres usar tu propio endpoint:

   - Ve a [mockapi.io](https://mockapi.io)
   - Crea un nuevo proyecto
   - Crea un recurso llamado `properties`
   - Usa los datos de ejemplo en `assets/sample_properties.json`
   - Actualiza la URL en `lib/services/property_api_service.dart`

5. **Ejecutar la aplicación**
   ```bash
   flutter run
   ```

## 📊 API Endpoints

La aplicación utiliza los siguientes endpoints de MockAPI:

- `GET /properties` - Lista todas las propiedades
- `GET /properties?page=1&limit=10` - Paginación
- `GET /properties/:id` - Obtiene una propiedad específica
- `GET /properties?search=query` - Búsqueda (implementada localmente)

### Estructura de datos

```json
{
  "id": "1",
  "title": "Lujoso Apartamento en el Centro",
  "city": "Barcelona, España",
  "price": 2500000,
  "image": "https://picsum.photos/800/600?random=1",
  "description": "Descripción detallada de la propiedad..."
}
```

## 🎨 Diseño

La aplicación sigue los principios de Material Design 3 con:

### Sistema de Temas

- **Colores**: Esquema basado en azul (#1976D2) como color primario
- **Tema Claro**: Optimizado para uso diurno con alta legibilidad
- **Tema Oscuro**: Reduce fatiga visual en ambientes de baja luz
- **Cambio Dinámico**: Botón en AppBar para alternar entre temas
- **Configuración Centralizada**: Archivo `theme.dart` con toda la configuración

### Componentes Personalizados

- **Cards**: Bordes redondeados de 16px con elevación sutil
- **Botones**: Formas redondeadas de 12px consistentes
- **Inputs**: Estilo filled con bordes redondeados
- **AppBar**: Sin elevación con scrolledUnderElevation
- **Chips**: Bordes redondeados de 8px

### Detalles de UX

- **Tipografía**: Jerarquía clara con pesos y tamaños definidos
- **Espaciado**: Consistente usando múltiplos de 8px
- **Animaciones**: Hero transitions para continuidad visual
- **Estados de Carga**: Shimmer placeholders en lugar de spinners genéricos
- **Feedback Visual**: Badges, tooltips y estados hover/pressed

## 🧪 Testing

La aplicación cuenta con una suite de tests completa:

### Ejecutar todos los tests

```bash
flutter test
```

### Tests implementados (7 tests ✅)

1. **App loads correctly** - Verifica que la app carga correctamente
2. **Search bar is present and accepts input** - Prueba funcionalidad de búsqueda
3. **Favorites button is visible** - Verifica presencia del botón de favoritos
4. **Loading state appears initially** - Comprueba estados de carga
5. **Favorites icon button is tappable** - Verifica interactividad
6. **Theme toggle button is visible and works** - Prueba cambio de tema
7. **Theme toggle button exists** - Confirma presencia del botón de tema

### Cobertura

Los tests cubren:

- ✅ Carga inicial de la aplicación
- ✅ Widgets principales (AppBar, SearchBar, Cards)
- ✅ Interacciones de usuario (búsqueda, favoritos)
- ✅ Sistema de temas (toggle claro/oscuro)
- ✅ Navegación básica

### Ejecutar tests específicos

```bash
# Solo tests de widgets
flutter test test/widget_test.dart

# Test específico
flutter test --plain-name "Theme toggle button is visible and works"
```

## 📱 Funcionalidades Principales

### 🏠 Pantalla Principal (Home)

- **Lista de propiedades** con imágenes en alta calidad
- **Barra de búsqueda** en tiempo real con debounce de 500ms
- **Scroll infinito** para carga progresiva de más datos
- **Shimmer loading** mientras se cargan las propiedades
- **Badge de favoritos** con contador en el AppBar
- **Botón de cambio de tema** (claro ↔ oscuro)
- **Hero animations** en las imágenes de propiedades
- **Botón de favorito** en cada card (sincronizado con estado global)

### 🏡 Pantalla de Detalle

- **Imagen grande** de la propiedad con Hero animation
- **Información completa**: título, precio, ubicación, descripción
- **Características** de la propiedad (preparado para expansión)
- **Botón de favorito persistente** con estado sincronizado
- **Navegación suave** con transición animada
- **Scroll view** para contenido largo

### ❤️ Pantalla de Favoritos

- **Lista de propiedades favoritas** persistente
- **Estado vacío** con ilustración cuando no hay favoritos
- **Contador** de favoritos en el header
- **Sincronización** automática al marcar/desmarcar
- **Mismo diseño** que la pantalla principal para consistencia

### 🎨 Sistema de Temas

- **Tema claro**: Optimizado para uso diurno
- **Tema oscuro**: Reduce fatiga visual nocturna
- **Botón de toggle**: En el AppBar de la pantalla principal
- **Cambio instantáneo**: Sin recargar la app
- **Persistencia**: El tema seleccionado se mantiene (preparado)

### 🔍 Búsqueda Optimizada

- **Debounce de 500ms**: Reduce llamadas innecesarias a la API
- **Búsqueda reactiva**: Actualización automática de resultados
- **Filtrado local**: Por título o ciudad
- **Feedback visual**: Indicador de búsqueda activa
- **Limpieza fácil**: Botón para borrar búsqueda

## 🔧 Arquitectura

La aplicación sigue principios de **Clean Architecture** con separación de responsabilidades:

### Capas de la Arquitectura

#### 📱 Presentation Layer (Screens & Widgets)

- **Screens**: `home_screen.dart`, `property_detail_screen.dart`, `favorites_screen.dart`
- **Widgets**: Componentes reutilizables (`property_card.dart`, `search_bar_widget.dart`, etc.)
- **Responsabilidad**: UI y manejo de interacciones del usuario

#### 🔄 Application Layer (Providers)

- **Providers**: Estado reactivo con Riverpod
- **Notifiers**: Lógica de negocio (`PropertiesNotifier`, `FavoritesNotifier`, `ThemeModeNotifier`)
- **Responsabilidad**: Gestión de estado y coordinación entre capas

#### 🎯 Domain Layer (Models)

- **Models**: `property.dart`, `paginated_response.dart`
- **Responsabilidad**: Entidades de negocio y reglas de dominio

#### 🏗️ Infrastructure Layer (Services)

- **Services**: `property_api_service.dart`, `favorites_service.dart`
- **Configuración**: `di.dart` (inyección de dependencias), `router.dart`, `theme.dart`
- **Responsabilidad**: Acceso a datos externos, persistencia y configuración

### Optimizaciones de Rendimiento

#### 🚀 Isolates para JSON Parsing

```dart
// Parsing en isolate separado para evitar bloqueo del UI thread
final properties = await compute(_parseJsonList, response.body);
```

#### 💾 Cache de SharedPreferences

```dart
// Instancia cacheada para evitar múltiples llamadas a getInstance()
SharedPreferences? _cachedPrefs;
```

#### ⏱️ Debounce en Búsqueda

```dart
// RxDart con 500ms de espera para reducir llamadas a API
_searchSubject.debounceTime(Duration(milliseconds: 500))
```

#### 🖼️ Cache de Imágenes

```dart
// CachedNetworkImage para evitar recargas innecesarias
CachedNetworkImage(cacheKey: property.id)
```

### Gestión de Estado con Riverpod

#### Providers Principales

- `propertiesNotifierProvider` - Estado de lista de propiedades con paginación
- `favoritesNotifierProvider` - Estado de favoritos persistente
- `themeModeProvider` - Estado del tema (claro/oscuro)
- `searchQueryProvider` - Estado de la búsqueda actual

#### Ventajas de Riverpod

- ✅ **Type-safe**: Detección de errores en tiempo de compilación
- ✅ **Testeable**: Fácil de mockear y probar
- ✅ **Dispose automático**: Limpieza automática de recursos
- ✅ **Dev tools**: Inspección de estado en tiempo real
- ✅ **No BuildContext**: Providers accesibles desde cualquier lugar

## 🚀 Próximas Mejoras

### ✅ Implementado

- [x] Sistema de temas claro/oscuro con toggle
- [x] Shimmer loading effects
- [x] Debounce en búsqueda (500ms)
- [x] Hero animations en imágenes
- [x] Badge de favoritos con contador
- [x] Pantalla de favoritos completa
- [x] Tests de widgets (7 tests pasando)
- [x] Optimización con isolates
- [x] Cache de SharedPreferences

### Recursos Externos

- [Flutter Documentation](https://docs.flutter.dev/)
- [Riverpod Documentation](https://riverpod.dev/)
- [GoRouter Documentation](https://pub.dev/packages/go_router)
- [Material Design 3](https://m3.material.io/)

## 📄 Licencia

Este proyecto es un ejemplo educativo y de demostración. Siéntete libre de usar el código para aprendizaje y proyectos personales.

## 📞 Contacto

Para preguntas, sugerencias o colaboraciones:

- 📧 Email: [luisguillermo.rodriguez32@gmail.com]
- 🌐 Website: [guilleperez.com]

---

<p align="center">
  Hecho con ❤️ usando Flutter
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.35.3-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter">
  <img src="https://img.shields.io/badge/Dart-3.9.2-0175C2?style=for-the-badge&logo=dart&logoColor=white" alt="Dart">
  <img src="https://img.shields.io/badge/Riverpod-2.5.1-5C6BC0?style=for-the-badge" alt="Riverpod">
  <img src="https://img.shields.io/badge/Material-Design_3-757575?style=for-the-badge&logo=material-design&logoColor=white" alt="Material Design 3">
</p>
