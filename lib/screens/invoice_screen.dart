// lib/screens/cliente_documentos_screen.dart

import 'package:flutter/material.dart';
import '../core/services/local/mock_backend_service.dart';

class InvoiceScreen extends StatefulWidget {
  final String clientId;
  
  const InvoiceScreen({super.key, required this.clientId});

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  final MockBackendService _mockService = MockBackendService();
  List<Invoice> _facturas = [];
  bool _cargando = false;

  @override
  void initState() {
    super.initState();
    _cargarFacturas();
  }

  Future<void> _cargarFacturas() async {
    setState(() {
      _cargando = true;
    });

    _facturas = await _mockService.fetchInvoicesForClient(widget.clientId);

    setState(() {
      _cargando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Facturas'),
        backgroundColor: const Color(0xFFD97B1E),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _cargando
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: _facturas.length,
                itemBuilder: (context, index) {
                  final factura = _facturas[index];
                  return Card(
                    child: ListTile(
                      title: Text('Factura: ${factura.number}'),
                      subtitle: Text(
                          'Importe: €${factura.amount}\nFecha: ${factura.date.toLocal().toString().split(' ')[0]}'),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
