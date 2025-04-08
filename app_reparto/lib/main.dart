import 'package:app_reparto/providers/clients_provider.dart';
import 'package:app_reparto/providers/user_provider.dart';
import 'package:app_reparto/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_reparto/providers/timer_provider.dart';
import 'package:app_reparto/screens/visits_screen.dart';
import 'package:app_reparto/screens/home_screen.dart';
import 'package:app_reparto/screens/login_screen.dart';
import 'package:app_reparto/pages/main_page.dart';

void main() {
  runApp(
    // MultiProvider permite manejar múltiples estados con Provider
    MultiProvider(
      providers: [
        // Proveedor para la gestión del temporizador
        ChangeNotifierProvider(create: (_) => TimerProvider()),
        // Proveedor para la gestión de clientes
        ChangeNotifierProvider(create: (_) => ClientsProvider()),
        // Proveedor para la gestión de usuarios
        ChangeNotifierProvider(create: (_) => UserProvider()),
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
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/timer': (context) => const MainPage(),
        '/visits': (context) => const VisitsScreen(),
      },
    );
  }
}
