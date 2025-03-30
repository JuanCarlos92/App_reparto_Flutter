import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // librería para almacenamiento seguro

class TokenService {
  // Clave utilizada para almacenar el token de autenticación
  static const String _tokenKey = 'auth_token';

  // Instancia del almacenamiento seguro
  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  // Obtener el token almacenado
  static Future<String?> getToken() async {
    // Lee y devuelve el token almacenado
    return await _secureStorage.read(key: _tokenKey);
  }

  // Almacenar el token
  static Future<void> setToken(String token) async {
    // Guarda el token de autenticación en el almacenamiento seguro
    await _secureStorage.write(key: _tokenKey, value: token);
  }

  // Eliminar el token
  static Future<void> clearToken() async {
    // Borra el token almacenado
    await _secureStorage.delete(key: _tokenKey);
  }
}
