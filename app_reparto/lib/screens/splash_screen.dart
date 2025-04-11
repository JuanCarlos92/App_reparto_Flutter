import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed('/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          // Centra los elementos verticalmente
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animación de carga usando Lottie
            Lottie.asset(
              'assets/loading.json',
              width: 200,
            ),

            // Texto de carga
            Text(
              'Cargando...',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 200, 120, 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
