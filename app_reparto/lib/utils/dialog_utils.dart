import 'package:flutter/material.dart';

// Clase de utilidad para mostrar diálogos en la aplicación
class DialogUtils {
  // Método estático para mostrar un diálogo de error
  // Recibe el contexto y el mensaje a mostrar
  static void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        // Construye un diálogo de alerta con estilo de error
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),  // Muestra el mensaje de error
          actions: [
            // Botón para cerrar el diálogo
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();  // Cierra el diálogo actual
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Método estático para mostrar un diálogo informativo
  // Recibe el contexto y el mensaje a mostrar
  static void showInfoDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Construye un diálogo de alerta con estilo informativo
        return AlertDialog(
          title: const Text('Información'),
          content: Text(message),  // Muestra el mensaje informativo
          actions: <Widget>[
            // Botón para cerrar el diálogo
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();  // Cierra el diálogo actual
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }
}
