import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/property.dart';

class PropertyApiService {
  static const String baseUrl =
      'https://68ee5522df2025af78034e56.mockapi.io/api/v1';

  final http.Client _client;

  PropertyApiService({http.Client? client}) : _client = client ?? http.Client();

  /// Obtiene las propiedades con paginación y filtros opcionales
  Future<List<Property>> getProperties({
    int page = 1,
    int limit = 10,
    String? search,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl/properties').replace(
        queryParameters: {
          'page': page.toString(),
          'limit': limit.toString(),
          if (search != null && search.isNotEmpty) 'search': search,
        },
      );

      final response = await _client.get(uri);

      if (response.statusCode == 200) {
        // Decodificar el JSON en un isolate para no bloquear el hilo UI
        final List<dynamic> jsonList = await compute(
          _parseJsonList,
          response.body,
        );

        return jsonList
            .map((json) => Property.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw ApiException(
          'Error al cargar propiedades: ${response.statusCode}',
        );
      }
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException('Error de conexión: $e');
    }
  }

  /// Obtiene una propiedad específica por ID
  Future<Property> getPropertyById(String id) async {
    try {
      final uri = Uri.parse('$baseUrl/properties/$id');
      final response = await _client.get(uri);

      if (response.statusCode == 200) {
        // Parse JSON in an isolate to avoid blocking the UI
        final Map<String, dynamic> json = await compute(
          _parseJsonObject,
          response.body,
        );
        return Property.fromJson(json);
      } else if (response.statusCode == 404) {
        throw ApiException('Propiedad no encontrada');
      } else {
        throw ApiException('Error al cargar propiedad: ${response.statusCode}');
      }
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException('Error de conexión: $e');
    }
  }

  /// Busca propiedades por título o ciudad
  Future<List<Property>> searchProperties(String query) async {
    try {
      final allProperties = await getProperties(limit: 100);

      if (query.isEmpty) return allProperties;

      final lowerQuery = query.toLowerCase();
      return allProperties.where((property) {
        return property.title.toLowerCase().contains(lowerQuery) ||
            property.city.toLowerCase().contains(lowerQuery);
      }).toList();
    } catch (e) {
      throw ApiException('Error en la búsqueda: $e');
    }
  }

  void dispose() {
    _client.close();
  }
}

class ApiException implements Exception {
  final String message;

  const ApiException(this.message);

  @override
  String toString() => 'ApiException: $message';
}

// Top-level functions para usar con compute (deben estar fuera de cualquier clase)
List<dynamic> _parseJsonList(String body) {
  final decoded = json.decode(body);
  if (decoded is List) {
    return decoded;
  }
  return [];
}

Map<String, dynamic> _parseJsonObject(String body) {
  final decoded = json.decode(body);
  if (decoded is Map) return Map<String, dynamic>.from(decoded);
  return <String, dynamic>{};
}
