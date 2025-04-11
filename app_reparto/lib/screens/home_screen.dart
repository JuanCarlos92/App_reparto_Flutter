// import 'package:app_reparto/services/work_session_service.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/local/geolocation_service.dart';
import '../widgets/button_widget.dart';
import 'package:app_reparto/providers/user_provider.dart';
import '../utils/dialog_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Temporizador para actualizar la ubicación
  Timer? _locationTimer;
  // Servicio de geolocalización
  final GeolocationService _geolocationService = GeolocationService();

  @override
  // Se ejecuta cuando las dependencias cambian, útil para inicializar datos
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context)?.settings.arguments;

    // Procesa el nombre de usuario si se recibe como argumento
    if (arguments != null && arguments is String) {
      final userName = capitalizeFirstLetter(arguments);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<UserProvider>().setUserName(userName);
      });
    }
  }

  // Inicia la actualización periódica de la ubicación
  void startLocationUpdates() {
    _locationTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _geolocationService.getCurrentLocation();
    });
  }

  // Detiene la actualización de ubicación
  void stopLocationUpdates() {
    _locationTimer?.cancel();
  }

  // Future<void> _handleStartWork() async {
  //   if (!mounted) return;

  //   final bool confirm = await DialogUtils.showConfirmationDialog(
  //       context, '¿Quieres iniciar tu jornada?');

  //   if (!mounted) return;

  //   if (confirm) {
  //     try {
  //       await WorkSessionService.startWorkSession();
  //       if (!mounted) return;

  //       startLocationUpdates();
  //       Navigator.pushNamed(context, '/timer', arguments: {'startTimer': true});
  //     } catch (e) {
  //       if (!mounted) return;
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //             content: Text('Error al iniciar la jornada: ${e.toString()}')),
  //       );
  //     }
  //   }
  // }

  @override
  // Limpia recursos cuando se destruye el widget
  void dispose() {
    stopLocationUpdates();
    super.dispose();
  }

  // Función auxiliar para capitalizar la primera letra del texto
  String capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    // Obtiene el nombre de usuario del provider
    final userName = context.watch<UserProvider>().userName;

    return Scaffold(
      // Barra superior de la aplicación
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
          // Espacio para widget de notificaciones futuro
        ],
      ),

      // Cuerpo principal de la página
      body: Column(
        children: [
          // Muestra el nombre del usuario si está disponible
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

          // Contenedor principal expandible
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Center(
                child: SizedBox(
                  // 90% del ancho de la pantalla
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Column(
                    children: [
                      // Sección superior con icono de temporizador
                      Container(
                        padding: const EdgeInsets.fromLTRB(25, 20, 25, 30),
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

                      // Contenedor principal con los botones de acción
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
                                // Icono
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

                                // Botón para iniciar la jornada
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
                                  // onPressed: _handleStartWork,

                                  onPressed: () async {
                                    if (!context.mounted) return;
                                    final bool confirm = await DialogUtils
                                        .showConfirmationDialog(context,
                                            '¿Quieres iniciar tu jornada?');

                                    if (!context.mounted) return;
                                    if (confirm) {
                                      startLocationUpdates();
                                      Navigator.pushNamed(context, '/timer',
                                          arguments: {'startTimer': true});
                                    }
                                  },
                                ),
                                const SizedBox(height: 20),

                                // Botón para cerrar sesión
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
