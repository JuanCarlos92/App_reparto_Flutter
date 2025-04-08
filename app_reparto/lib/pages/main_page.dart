import 'package:flutter/material.dart';
import 'package:app_reparto/screens/timer_screen.dart';
import 'package:app_reparto/screens/visits_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: const BouncingScrollPhysics(),
      children: const [TimerScreen(), VisitsScreen()],
    );
  }
}
