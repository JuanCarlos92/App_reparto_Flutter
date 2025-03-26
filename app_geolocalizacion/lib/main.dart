import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_geolocalizacion/screens/home_screen.dart';
import 'package:app_geolocalizacion/screens/login_screen.dart';
import 'package:app_geolocalizacion/pages/main_pages.dart';
import 'package:app_geolocalizacion/providers/timer_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TimerProvider>(
      create: (context) => TimerProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Geolocalización",
        initialRoute: '/',
        routes: {
          '/': (context) => const LoginScreen(),
          '/home': (context) => const HomeScreen(),
          '/timer': (context) => const MainPages(),
        },
      ),
    );
  }
}
