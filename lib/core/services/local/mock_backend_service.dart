class Ticket {
  final String ref;
  final String subject;
  final String status;
  final DateTime dateCreation;

  Ticket(
      {required this.ref,
      required this.subject,
      required this.status,
      required this.dateCreation});
}

class Invoice {
  final String number;
  final double amount;
  final DateTime date;

  Invoice({required this.number, required this.amount, required this.date});
}

class MockBackendService {
  Future<List<Invoice>> fetchInvoicesForClient(String clientId) async {
    await Future.delayed(const Duration(seconds: 1));
    
    switch (clientId) {
      case '1': // Farmacia San Juan
        return [
          Invoice(
            number: 'F2025-001',
            amount: 150.0,
            date: DateTime.now().subtract(const Duration(days: 10))
          ),
          Invoice(
            number: 'F2025-002',
            amount: 75.5,
            date: DateTime.now().subtract(const Duration(days: 30))
          ),
        ];
      case '2': // Supermercado García
        return [
          Invoice(
            number: 'F2025-003',
            amount: 320.75,
            date: DateTime.now().subtract(const Duration(days: 5))
          ),
          Invoice(
            number: 'F2025-004',
            amount: 445.90,
            date: DateTime.now().subtract(const Duration(days: 15))
          ),
          Invoice(
            number: 'F2025-005',
            amount: 180.25,
            date: DateTime.now().subtract(const Duration(days: 45))
          ),
        ];
      case '3': // Panadería La Española
        return [
          Invoice(
            number: 'F2025-006',
            amount: 95.30,
            date: DateTime.now().subtract(const Duration(days: 7))
          ),
        ];
      case '4': // Frutería Fresh
        return [
          Invoice(
            number: 'F2025-007',
            amount: 250.45,
            date: DateTime.now().subtract(const Duration(days: 3))
          ),
          Invoice(
            number: 'F2025-008',
            amount: 175.60,
            date: DateTime.now().subtract(const Duration(days: 20))
          ),
        ];
      default:
        return [];
    }
  }
}
