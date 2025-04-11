import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final IconData icon;
  final Gradient gradient;
  final VoidCallback onPressed;

  // Constructor
  const ButtonWidget({
    super.key,
    required this.text,
    required this.icon,
    required this.gradient,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // Decoración exterior del botón
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      // Botón elevado con estilo personalizado
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding:
              // Espaciado vertical
              const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),

        // Función que se ejecuta al presionar
        onPressed: onPressed,

        // Contenido del botón organizado en fila
        child: Row(
          // Centra los elementos
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icono del botón
            Icon(icon, size: 24, color: Colors.white),
            // Espacio entre icono y texto
            const SizedBox(width: 10),
            Text(
              text,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
