import 'dart:async';
import 'package:flutter/material.dart';
import '../services/geolocation_service.dart';
import '../widgets/button_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Timer? _locationTimer;
  final GeolocationService _geolocationService = GeolocationService();
  String userName = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments != null && arguments is String) {
      userName = arguments;
    }
  }

  void startLocationUpdates() {
    _locationTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _geolocationService.getCurrentLocation();
    });
  }

  void stopLocationUpdates() {
    _locationTimer?.cancel();
  }

  @override
  void dispose() {
    stopLocationUpdates();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0D3A21), // Verde muy oscuro
              Color(0xFF1E5631), // Verde oscuro principal
              Color(0xFF4FC98E), // Verde claro
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(25, 60, 25, 30),
              child: Column(
                children: [
                  const Icon(
                    Icons.timer,
                    size: 42,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "Control Horario",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      fontFamily: 'Roboto',
                      shadows: [
                        Shadow(
                          blurRadius: 8,
                          color: Colors.black.withOpacity(0.3),
                          offset: const Offset(2, 2),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Contenido principal
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromARGB(255, 91, 92, 91),
                        Color.fromARGB(255, 232, 238, 235),
                      ]),
                  color: Colors.grey,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (userName.isNotEmpty)
                        Text(
                          userName, // Mostrar el nombre del usuario
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      const SizedBox(height: 5),
                      // Icono de reparto
                      Container(
                        padding: const EdgeInsets.all(25),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFF1E5631),
                              Color(0xFF4FC98E),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.delivery_dining,
                          size: 80,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 40),

                      // Botón Iniciar Jornada
                      ButtonWidget(
                        text: 'INICIAR JORNADA',
                        icon: Icons.timer,
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF1E5631),
                            Color(0xFF4FC98E),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        onPressed: () {
                          startLocationUpdates();
                          Navigator.pushNamed(context, '/timer',
                              arguments: true);
                        },
                      ),
                      const SizedBox(height: 20),

                      // Botón Cerrar Sesión
                      ButtonWidget(
                        text: 'CERRAR SESIÓN',
                        icon: Icons.logout,
                        gradient: LinearGradient(
                          colors: [
                            Colors.grey[700]!,
                            Colors.grey[600]!,
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/');
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
