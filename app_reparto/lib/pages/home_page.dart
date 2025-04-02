import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/geolocation_service.dart';
import '../widgets/button_widget.dart';
import 'package:app_reparto/providers/user_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Timer? _locationTimer;
  final GeolocationService _geolocationService = GeolocationService();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments != null && arguments is String) {
      final userName = capitalizeFirstLetter(arguments);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<UserProvider>().setUserName(userName);
      });
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

  String capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    final userName = context.watch<UserProvider>().userName;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 200, 120, 20),
              Color.fromARGB(255, 252, 231, 197),
            ],
            stops: [0.0, 1],
          ),
        ),
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
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
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(40)),
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
                              userName,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 35,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          const SizedBox(height: 20),
                          Container(
                            padding: const EdgeInsets.all(25),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 200, 120, 20),
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
                          ButtonWidget(
                            text: 'INICIAR JORNADA',
                            icon: Icons.timer,
                            gradient: const LinearGradient(
                              colors: [
                                Color.fromARGB(255, 200, 120, 20),
                                Color.fromARGB(255, 200, 120, 20),
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
                              Navigator.pushReplacementNamed(context, '/login');
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
