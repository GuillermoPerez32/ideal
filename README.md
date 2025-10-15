# Ideal - Real Estate App

Una aplicación Flutter para explorar propiedades inmobiliarias con búsqueda, favoritos y navegación intuitiva.

## 🏡 Características

- **Lista de propiedades**: Navegación con scroll infinito/paginación
- **Búsqueda avanzada**: Filtro por título o ciudad
- **Favoritos persistentes**: Marca propiedades como favoritas con almacenamiento local
- **Detalles completos**: Vista detallada de cada propiedad
- **Diseño responsivo**: Material Design 3 con soporte para modo oscuro
- **Navegación fluida**: Implementada con GoRouter
- **Cache de imágenes**: Carga optimizada con cached_network_image

## 🛠️ Tecnologías

- **Flutter**: Framework principal
- **Riverpod**: Gestión de estado
- **GoRouter**: Navegación
- **Shared Preferences**: Persistencia local
- **MockAPI.io**: API simulada para datos
- **Cached Network Image**: Cache de imágenes
- **Get It**: Inyección de dependencias
- **JSON Serializable**: Serialización de modelos

## 📱 Estructura del Proyecto

```
lib/
├── core/
│   ├── di.dart                 # Configuración de dependencias
│   └── router.dart             # Configuración de rutas
├── models/
│   ├── property.dart           # Modelo de propiedad
│   └── paginated_response.dart # Modelo de respuesta paginada
├── providers/
│   └── providers.dart          # Providers de Riverpod
├── screens/
│   ├── home_screen.dart        # Pantalla principal
│   └── property_detail_screen.dart # Pantalla de detalle
├── services/
│   ├── property_api_service.dart   # Servicio de API
│   └── favorites_service.dart      # Servicio de favoritos
├── widgets/
│   ├── property_card.dart      # Tarjeta de propiedad
│   └── search_bar_widget.dart  # Barra de búsqueda
└── main.dart                   # Punto de entrada
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

- **Colores**: Esquema basado en azul (#1976D2)
- **Tipografía**: Jerarquía clara y legible
- **Espaciado**: Consistente usando múltiplos de 8px
- **Componentes**: Cards, botones y navegación material
- **Modo oscuro**: Soporte automático del sistema

## 🧪 Testing

Ejecutar tests unitarios:

```bash
flutter test
```

Ejecutar tests de widgets:

```bash
flutter test test/widget_test.dart
```

## 📱 Funcionalidades Principales

### Pantalla Principal

- Lista de propiedades con imágenes
- Barra de búsqueda en tiempo real
- Scroll infinito para carga de más datos
- Botón de favoritos en cada card
- Pull-to-refresh

### Pantalla de Detalle

- Imagen grande de la propiedad
- Información completa (título, precio, ubicación, descripción)
- Características simuladas (dormitorios, baños, etc.)
- Botón de favorito persistente
- Botón de contacto con agente

### Funcionalidad de Favoritos

- Persistencia local con SharedPreferences
- Estado sincronizado en toda la app
- Animaciones sutiles al marcar/desmarcar

## 🔧 Arquitectura

La aplicación sigue principios de Clean Architecture:

- **Presentation Layer**: Screens y Widgets
- **Application Layer**: Providers (Riverpod)
- **Domain Layer**: Models
- **Infrastructure Layer**: Services y APIs

### Gestión de Estado

Utiliza Riverpod para:

- Estado de propiedades (lista, búsqueda, detalle)
- Estado de favoritos
- Providers de servicios
- Notifiers para operaciones complejas

## 🚀 Próximas Mejoras

- [ ] Filtros avanzados (precio, tipo de propiedad)
- [ ] Mapa con ubicaciones
- [ ] Compartir propiedades
- [ ] Notificaciones push
- [ ] Autenticación de usuarios
- [ ] Galería de imágenes múltiples
- [ ] Comparación de propiedades
- [ ] Chat con agentes

## 🐛 Problemas Conocidos

- Las imágenes se cargan desde Picsum (placeholder)
- La búsqueda es local (no en servidor)
- Datos simulados en MockAPI

## 📄 Licencia

Este proyecto es un ejemplo educativo y no tiene una licencia específica.

## 👨‍💻 Contribución

Las contribuciones son bienvenidas. Por favor:

1. Fork el proyecto
2. Crea una rama para tu feature
3. Commit tus cambios
4. Push a la rama
5. Abre un Pull Request

## 📞 Contacto

Para preguntas o sugerencias, por favor contacta al equipo de desarrollo.
