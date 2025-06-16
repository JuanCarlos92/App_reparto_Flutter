// ignore_for_file: deprecated_member_use, avoid_print

import 'package:flutter/material.dart';
import '../screens/invoice_screen.dart';

class BarDetailsWidget extends StatelessWidget {
  final String clienteId;

  const BarDetailsWidget({super.key, required this.clienteId});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Ver presupuesto
            IconButton(
              icon: const Icon(
                Icons.description,
                color: Color(0xFFD97B1E),
                size: 30,
              ),
              tooltip: 'Ver presupuesto',
              onPressed: () {
                Navigator.pushNamed(context, '/budget-view');
              },
            ),
            // Botón de Factura
            IconButton(
              icon: const Icon(
                Icons.receipt,
                color: Color(0xFFD97B1E),
                size: 30,
              ),
              tooltip: 'Ver factura',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InvoiceScreen(clientId: clienteId),
                  ),
                );
              },
            ),
            // Ver pedido
            IconButton(
              icon: const Icon(
                Icons.shopping_cart,
                color: Color(0xFFD97B1E),
                size: 30,
              ),
              tooltip: 'Ver pedido',
              onPressed: () {
                Navigator.pushNamed(context, '/order-view');
              },
            ),
            // Reportar problema
            IconButton(
              icon: const Icon(
                Icons.report_problem,
                color: Color(0xFFD97B1E),
                size: 30,
              ),
              tooltip: 'Reportar problema',
              onPressed: () {
                Navigator.pushNamed(context, '/report-issue');
              },
            ),
          ],
        ),
      ),
    );
  }
}
