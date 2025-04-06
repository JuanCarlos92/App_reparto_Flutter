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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 200, 120, 20),
        centerTitle: true,
        title: const Text(
          'Control Horario',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: 'Roboto',
            shadows: [
              Shadow(
                blurRadius: 8,
                color: Color.fromRGBO(0, 0, 0, 0.3),
                offset: Offset(2, 2),
              ),
            ],
          ),
        ),
        actions: [
          // NotificationWidget(),
        ],
      ),
      body: Column(
        children: [
          if (userName.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                userName,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 35,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
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
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                            boxShadow: [
                              BoxShadow(
                                // ignore: deprecated_member_use
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 20,
                                spreadRadius: 5,
                              ),
                            ],
                            border: Border.all(
                              color: const Color.fromARGB(255, 200, 120, 20),
                              width: 1.5,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(25),
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 200, 120, 20),
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        // ignore: deprecated_member_use
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
                                        arguments: {'startTimer': true});
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
                                    Navigator.pushReplacementNamed(
                                        context, '/login');
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
          ),
        ],
      ),
    );
  }
}