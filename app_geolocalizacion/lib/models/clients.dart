class Client {
  final String name;
  final String address;

  Client({required this.name, required this.address});

  // crear un cliente desde un JSON
  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      name: json['name'] ?? 'Sin Nombre',
      address: json['address'] ?? 'Sin Dirección',
    );
  }
}
