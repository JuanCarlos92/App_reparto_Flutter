// lib/screens/cliente_documentos_screen.dart

import 'package:flutter/material.dart';
import '../core/services/local/mock_backend_service.dart';

class InvoiceScreen extends StatefulWidget {
  const InvoiceScreen({super.key});

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  final MockBackendService _mockService = MockBackendService();
  String _tipoSeleccionado = 'Tickets';
  List<dynamic> _resultados = [];
  bool _cargando = false;

  @override
  void initState() {
    super.initState();
    _cargarDatos();
  }

  Future<void> _cargarDatos() async {
    setState(() {
      _cargando = true;
    });

    if (_tipoSeleccionado == 'Tickets') {
      _resultados = await _mockService.fetchTicketsForClient('1');
    } else {
      _resultados = await _mockService.fetchInvoicesForClient('1');
    }

    setState(() {
      _cargando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Documentos del Cliente'),
        backgroundColor: const Color(0xFFD97B1E),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              value: _tipoSeleccionado,
              items: const [
                DropdownMenuItem(value: 'Tickets', child: Text('Tickets')),
                DropdownMenuItem(value: 'Facturas', child: Text('Facturas')),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _tipoSeleccionado = value;
                  });
                  _cargarDatos();
                }
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _cargando
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: _resultados.length,
                      itemBuilder: (context, index) {
                        final item = _resultados[index];
                        return Card(
                          child: ListTile(
                            title: Text(
                              _tipoSeleccionado == 'Tickets'
                                  ? (item as Ticket).subject
                                  : 'Factura: ${(item as Invoice).number}',
                            ),
                            subtitle: Text(
                              _tipoSeleccionado == 'Tickets'
                                  ? 'Estado: ${item.status}\nFecha: ${item.dateCreation.toLocal().toString().split(' ')[0]}'
                                  : 'Importe: €${item.amount}\nFecha: ${item.date.toLocal().toString().split(' ')[0]}',
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
