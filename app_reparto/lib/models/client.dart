import 'dart:convert';

// Funciones auxiliares para convertir entre JSON y objetos Client
Client clientFromJson(String str) => Client.fromJson(json.decode(str));
String clientToJson(Client data) => json.encode(data.toJson());

// Clase que representa un cliente con sus datos básicos y ubicación
class Client {
  // Propiedades básicas del cliente
  String id;
  String name;        // Nombre del cliente
  String town;        // Ciudad o población
  String address;     // Dirección completa
  double latitud;     // Coordenada de latitud para geolocalización
  double longitud;    // Coordenada de longitud para geolocalización
  ArrayOptions arrayOptions;  // Opciones adicionales del cliente

  // Constructor que requiere todos los campos
  Client({
    required this.id,
    required this.name,
    required this.town,
    required this.address,
    required this.latitud,
    required this.longitud,
    required this.arrayOptions,
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
        arrayOptions: json["array_options"] != null
            ? ArrayOptions.fromJson(json["array_options"])
            : ArrayOptions(opcion1: '', opcion2: '', opcion3: ''),
      );

  // Método para convertir la instancia a un Map (JSON)
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "town": town,
        "address": address,
        "latitud": latitud,
        "longitud": longitud,
        "array_options": arrayOptions.toJson(),
      };
}

// Clase para manejar opciones adicionales del cliente
class ArrayOptions {
  String opcion1;    // Primera opción personalizable
  String opcion2;    // Segunda opción personalizable
  String opcion3;    // Tercera opción personalizable

  // Constructor que requiere todas las opciones
  ArrayOptions({
    required this.opcion1,
    required this.opcion2,
    required this.opcion3,
  });

  // Factory constructor para crear una instancia desde un Map (JSON)
  factory ArrayOptions.fromJson(Map<String, dynamic> json) => ArrayOptions(
        opcion1: json["opcion1"],
        opcion2: json["opcion2"],
        opcion3: json["opcion3"],
      );

  // Método para convertir la instancia a un Map (JSON)
  Map<String, dynamic> toJson() => {
        "opcion1": opcion1,
        "opcion2": opcion2,
        "opcion3": opcion3,
      };
}
