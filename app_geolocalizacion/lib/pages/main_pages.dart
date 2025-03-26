import 'package:flutter/material.dart';
import 'package:app_geolocalizacion/pages/timer_page.dart';
import 'package:app_geolocalizacion/pages/visits_page.dart';

class MainPages extends StatefulWidget {
  const MainPages({super.key});

  @override
  State<MainPages> createState() => _MainPagesState();
}

class _MainPagesState extends State<MainPages> {
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
