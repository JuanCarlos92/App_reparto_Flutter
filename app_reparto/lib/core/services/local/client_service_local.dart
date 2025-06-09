// ignore_for_file: avoid_print
import '../../../models/client.dart';

class ClientServiceLocal {
  final List<Client> _mockClients = [
    Client(
      id: '1',
      name: 'Farmacia San Juan',
      town: 'Madrid',
      address: 'Calle Mayor 123',
      latitude: 40.4168,
      longitude: -3.7038,
      durationInSeconds: 1800,
    ),
    Client(
      id: '2',
      name: 'Supermercado García',
      town: 'Madrid',
      address: 'Avenida Libertad 45',
      latitude: 40.4152,
      longitude: -3.7072,
      durationInSeconds: 2400,
    ),
    Client(
      id: '3',
      name: 'Panadería La Española',
      town: 'Madrid',
      address: 'Plaza España 7',
      latitude: 40.4233,
      longitude: -3.7126,
      durationInSeconds: 900,
    ),
    Client(
      id: '4',
      name: 'Frutería Fresh',
      town: 'Madrid',
      address: 'Calle Gran Vía 234',
      latitude: 40.4197,
      longitude: -3.7013,
      durationInSeconds: 1200,
    ),
  ];

  // Obtener lista
  Future<List<Client>> getClients() async {
    // delay
    await Future.delayed(const Duration(milliseconds: 800));
    return _mockClients;
  }

  // Método eliminar
  Future<bool> deleteClient(String clientId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      final clientIndex = _mockClients.indexWhere((c) => c.id == clientId);
      if (clientIndex == -1) {
        throw 'Cliente no encontrado';
      }
      _mockClients.removeAt(clientIndex);
      return true;
    } catch (e) {
      throw Exception('$e');
    }
  }
}
