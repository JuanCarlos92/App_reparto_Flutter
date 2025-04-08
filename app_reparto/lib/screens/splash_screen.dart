import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

// Pantalla de carga inicial de la aplicación
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

// Estado de la pantalla de carga
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Temporizador que redirige a la pantalla de login después de 4 segundos
    Timer(Duration(seconds: 4), () {
      Navigator.of(context).pushReplacementNamed('/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Fondo blanco para la pantalla
      body: Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Centra los elementos verticalmente
          children: [
            // Animación de carga usando Lottie
            Lottie.asset('assets/loading.json'),
            // Texto de carga
            Text(
              'Cargando...',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E5631), // Color verde oscuro para el texto
              ),
            ),
          ],
        ),
      ),
    );
  }
}
