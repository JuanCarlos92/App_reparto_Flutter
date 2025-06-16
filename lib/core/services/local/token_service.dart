import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenService {
  // Clave utilizada para almacenar el token de autenticación
  static const String _tokenKey = 'auth_token';

  // Instancia del almacenamiento seguro
  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  // Obtener el token almacenado
  static Future<String?> getToken() async {
    return await _secureStorage.read(key: _tokenKey);
  }

  // Almacenar el token
  static Future<void> setToken(String token) async {
    await _secureStorage.write(key: _tokenKey, value: token);
  }

  // Eliminar el token
  static Future<void> clearToken() async {
    await _secureStorage.delete(key: _tokenKey);
  }
}
