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
  double latitude; // Coordenada de latitud para geolocalización
  double longitude; // Coordenada de longitud para geolocalización
  int durationInSeconds; // Duracion estimada

  // Constructor que requiere todos los campos
  Client({
    required this.id,
    required this.name,
    required this.town,
    required this.address,
    required this.latitude,
    required this.longitude,
    this.durationInSeconds = 0,
  });

  // Método para convertir un Map (JSON) a una instancia de Client
  factory Client.fromJson(Map<String, dynamic> json) {
    double parseLat = 0.0;
    double parseLong = 0.0;

    try {
      if (json["latitud"] != null) {
        parseLat = json["latitud"] is double
            ? json["latitud"]
            : double.parse(json["latitud"].toString());
      }
      if (json["longitud"] != null) {
        parseLong = json["longitud"] is double
            ? json["longitud"]
            : double.parse(json["longitud"].toString());
      }
    } catch (e) {
      print('Error - parsing coordinates: $e');
    }

    // Crear una instancia de Client con los datos del Map
    return Client(
      id: json["id"]?.toString() ?? '',
      name: json["name"]?.toString() ?? '',
      town: json["town"]?.toString() ?? '',
      address: json["address"]?.toString() ?? '',
      latitude: parseLat,
      longitude: parseLong,
      durationInSeconds: json["durationInSeconds"] ?? 0,
    );
  }

  // Método para convertir la instancia a un Map (JSON)
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "town": town,
        "address": address,
        "latitud": latitude,
        "longitud": longitude,
      };
}
