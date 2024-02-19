import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController pageController = PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer.periodic(Duration(seconds: 3), (timer) {
      int? nextPage = pageController.page?.toInt();

      if (nextPage == null) {
        return;
      }

      if (nextPage == 5) {
        nextPage = 0;
      } else {
        nextPage++;
      }
      pageController.animateToPage(
        nextPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: [1, 2, 3, 4, 5, 6]
            .map(
              (e) => Image.asset(
                'assets/pageview$e.png',
                fit: BoxFit.cover,
              ),
            )
            .toList(),
      ),
    );
  }
}
