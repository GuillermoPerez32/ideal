import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'models/auth_user.dart';

class AuthRepository {
  final FlutterSecureStorage _storage;
  static const String _tokenKey = 'auth_token';
  static const String _userKey = 'auth_user';

  AuthRepository({FlutterSecureStorage? storage})
    : _storage = storage ?? const FlutterSecureStorage();

  /// Simula login con validaciones básicas
  Future<AuthUser> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1)); // Simula latencia

    // Validaciones
    if (!email.contains('@')) {
      throw Exception('Email inválido');
    }
    if (password.length < 6) {
      throw Exception('La contraseña debe tener al menos 6 caracteres');
    }

    // Mock de respuesta exitosa
    final user = AuthUser(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      email: email,
      role: 'user',
      token: 'mock_token_${DateTime.now().millisecondsSinceEpoch}',
    );

    // Guardar en storage
    await _storage.write(key: _tokenKey, value: user.token);
    await _storage.write(key: _userKey, value: jsonEncode(user.toJson()));

    return user;
  }

  /// Recupera el usuario actual desde storage
  Future<AuthUser?> getCurrentUser() async {
    try {
      final token = await _storage.read(key: _tokenKey);
      final userJson = await _storage.read(key: _userKey);

      if (token == null || userJson == null) return null;

      return AuthUser.fromJson(jsonDecode(userJson));
    } catch (e) {
      return null;
    }
  }

  /// Verifica si hay token válido
  Future<bool> isAuthenticated() async {
    final token = await _storage.read(key: _tokenKey);
    return token != null && token.isNotEmpty;
  }

  /// Cierra sesión
  Future<void> logout() async {
    await _storage.delete(key: _tokenKey);
    await _storage.delete(key: _userKey);
  }
}
