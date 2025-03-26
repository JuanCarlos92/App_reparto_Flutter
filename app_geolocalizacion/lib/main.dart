import 'package:app_geolocalizacion/providers/clients_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_geolocalizacion/providers/timer_provider.dart';
import 'package:app_geolocalizacion/pages/visits_page.dart';
import 'package:app_geolocalizacion/screens/home_screen.dart';
import 'package:app_geolocalizacion/screens/login_screen.dart';
import 'package:app_geolocalizacion/pages/main_pages.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TimerProvider()),
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
