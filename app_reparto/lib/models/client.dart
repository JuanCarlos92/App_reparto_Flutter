import 'dart:convert';

// Funciones auxiliares para convertir entre JSON y objetos Client
Client clientFromJson(String str) => Client.fromJson(json.decode(str));
String clientToJson(Client data) => json.encode(data.toJson());

// Clase que representa un cliente con sus datos básicos y ubicación
class Client {
  // Propiedades básicas del cliente
  String id;
  String name; // Nombre del cliente
  String town; // Ciudad o población
  String address; // Dirección completa
  double latitud; // Coordenada de latitud para geolocalización
  double longitud; // Coordenada de longitud para geolocalización

  // Constructor que requiere todos los campos
  Client({
    required this.id,
    required this.name,
    required this.town,
    required this.address,
    required this.latitud,
    required this.longitud,
  });

  // Factory constructor para crear una instancia desde un Map (JSON)
  // Incluye validación y valores por defecto para datos faltantes
  factory Client.fromJson(Map<String, dynamic> json) => Client(
        id: json["id"]?.toString() ?? '',
        name: json["name"]?.toString() ?? '',
        town: json["town"]?.toString() ?? '',
        address: json["address"]?.toString() ?? '',
        latitud: (json["latitud"] != null)
            ? double.parse(json["latitud"].toString())
            : 0.0,
        longitud: (json["longitud"] != null)
            ? double.parse(json["longitud"].toString())
            : 0.0,
      );

  // Método para convertir la instancia a un Map (JSON)
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "town": town,
        "address": address,
        "latitud": latitud,
        "longitud": longitud,
      };
}
