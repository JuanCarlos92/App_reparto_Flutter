import 'package:flutter/material.dart';

// Widget personalizado para crear botones con estilo consistente
class ButtonWidget extends StatelessWidget {
  // Propiedades requeridas para personalizar el botón
  final String text; // Texto que se mostrará en el botón
  final IconData icon; // Icono que se mostrará junto al texto
  final Gradient gradient; // Gradiente para el fondo del botón
  final VoidCallback
      onPressed; // Función que se ejecutará al presionar el botón

  // Constructor del widget que requiere todas las propiedades
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
        gradient: gradient, // Aplica el gradiente de fondo
        borderRadius: BorderRadius.circular(15), // Bordes redondeados
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.2), // Sombra suave
            blurRadius: 8,
            offset: const Offset(0, 4), // Desplazamiento de la sombra
          ),
        ],
      ),
      // Botón elevado con estilo personalizado
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors
              .transparent, // Fondo transparente para mostrar el gradiente
          shadowColor: Colors.transparent, // Sin sombra propia del botón
          padding:
              const EdgeInsets.symmetric(vertical: 18), // Espaciado vertical
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15), // Bordes redondeados
          ),
        ),
        onPressed: onPressed, // Función que se ejecuta al presionar
        // Contenido del botón organizado en fila
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center, // Centra los elementos
          children: [
            Icon(icon, size: 24, color: Colors.white), // Icono del botón
            const SizedBox(width: 10), // Espacio entre icono y texto
            Text(
              text, // Texto del botón
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
