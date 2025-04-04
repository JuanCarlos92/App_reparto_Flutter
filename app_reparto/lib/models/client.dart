class Client {
  final String name;
  final String address;
  final double latitude;
  final double longitude;
  double distanceToDelivery;

  Client({
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    this.distanceToDelivery = 0.0,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      name: json['name'] ?? 'Sin Nombre',
      address: json['address'] ?? 'Sin Dirección',
      latitude: json['latitude'] ?? 0.0,
      longitude: json['longitude'] ?? 0.0,
    );
  }
}
