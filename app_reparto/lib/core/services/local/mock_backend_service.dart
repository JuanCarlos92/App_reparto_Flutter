class Ticket {
  final String ref;
  final String subject;
  final String status;
  final DateTime dateCreation;

  Ticket({required this.ref, required this.subject, required this.status, required this.dateCreation});
}

class Invoice {
  final String number;
  final double amount;
  final DateTime date;

  Invoice({required this.number, required this.amount, required this.date});
}

class MockBackendService {
  Future<List<Ticket>> fetchTicketsForClient(String clientId) async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      Ticket(ref: 'TS2506-0001', subject: 'Consulta comercial', status: 'Abierto', dateCreation: DateTime.now().subtract(const Duration(days: 1))),
      Ticket(ref: 'TS2506-0002', subject: 'Soporte técnico', status: 'Cerrado', dateCreation: DateTime.now().subtract(const Duration(days: 5))),
    ];
  }

  Future<List<Invoice>> fetchInvoicesForClient(String clientId) async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      Invoice(number: 'F2025-001', amount: 150.0, date: DateTime.now().subtract(const Duration(days: 10))),
      Invoice(number: 'F2025-002', amount: 75.5, date: DateTime.now().subtract(const Duration(days: 30))),
    ];
  }
}
