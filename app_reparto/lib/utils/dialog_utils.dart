import 'package:flutter/material.dart';

class DialogUtils {
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

  static Future<bool> showConfirmationDialog(
      BuildContext context, String message) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmación'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Sí'),
            ),
          ],
        );
      },
    );
    return result ?? false;
  }
}
