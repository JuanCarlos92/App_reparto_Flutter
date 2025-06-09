import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

class DialogUtils {
  // Mostrar un diálogo de firma
  static Future<bool?> showSignatureDialog(BuildContext context) async {
    final SignatureController controller = SignatureController(
      penStrokeWidth: 3,
      penColor: Colors.black,
    );

    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Firma de entrega'),
          content: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
            ),
            child: Signature(
              controller: controller,
              backgroundColor: Colors.white,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                controller.clear();
                Navigator.of(context).pop(false);
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                if (controller.isNotEmpty) {
                  Navigator.of(context).pop(true);
                }
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  // Método estático para mostrar un diálogo de error
  static void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        // Construye un diálogo de alerta con estilo de error
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            // Botón para cerrar el diálogo
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Método estático para mostrar un diálogo informativo
  static void showInfoDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Construye un diálogo de alerta con estilo informativo
        return AlertDialog(
          title: const Text('Información'),
          content: Text(message),
          actions: <Widget>[
            // Botón para cerrar el diálogo
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  // Método estático para mostrar un diálogo de confirmación
  static Future<bool> showConfirmationDialog(
      BuildContext context, String message) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          content: Text(
            message,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontFamily: 'Roboto',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
    return result ?? false;
  }
}
