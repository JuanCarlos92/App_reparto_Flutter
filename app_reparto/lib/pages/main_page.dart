import 'package:flutter/material.dart';
import 'package:app_reparto/pages/timer_page.dart';
import 'package:app_reparto/pages/visits_page.dart';

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
      children: const [TimerPage(), VisitsPage()],
    );
  }
}
