import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenService {
  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  // Obtener el token de un usuario específico
  static Future<String?> getToken(String username) async {
    return await _secureStorage.read(key: _getTokenKey(username));
  }

  // Almacenar el token para un usuario específico
  static Future<void> setToken(String username, String token) async {
    await _secureStorage.write(key: _getTokenKey(username), value: token);
  }

  // Eliminar el token de un usuario específico
  static Future<void> clearToken(String username) async {
    await _secureStorage.delete(key: _getTokenKey(username));
  }

  // Eliminar todos los tokens (logout general)
  static Future<void> clearAllTokens() async {
    await _secureStorage.deleteAll();
  }

  // Generar clave única para cada usuario
  static String _getTokenKey(String username) {
    return 'auth_token_$username';
  }

  // Obtener el último usuario que inició sesión
  static Future<String?> getLastLoggedUser() async {
    return await _secureStorage.read(key: 'last_logged_user');
  }

  // Guardar el último usuario que inició sesión
  static Future<void> setLastLoggedUser(String username) async {
    await _secureStorage.write(key: 'last_logged_user', value: username);
  }
}
