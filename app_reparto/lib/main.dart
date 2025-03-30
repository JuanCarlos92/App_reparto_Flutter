import 'package:app_reparto/providers/clients_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_reparto/providers/timer_provider.dart';
import 'package:app_reparto/pages/visits_page.dart';
import 'package:app_reparto/screens/home_screen.dart';
import 'package:app_reparto/screens/login_screen.dart';
import 'package:app_reparto/pages/main_pages.dart';

void main() {
  runApp(
    // MultiProvider permite manejar múltiples estados con Provider
    MultiProvider(
      providers: [
        // Proveedor para la gestión del temporizador
        ChangeNotifierProvider(create: (_) => TimerProvider()),
        // Proveedor para la gestión de clientes
        ChangeNotifierProvider(create: (_) => ClientsProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Geolocalización",
      initialRoute: '/home',
      routes: {
        '/': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/timer': (context) => const MainPages(),
        '/visits': (context) => const VisitsPage(),
      },
    );
  }
}
