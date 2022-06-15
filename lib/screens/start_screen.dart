import 'package:carrot_market_clone/screens/signin_screen.dart';
import 'package:flutter/material.dart';

import 'intro_screen.dart';
import 'search_screen.dart';

class StartScreen extends StatelessWidget {
  StartScreen({Key? key}) : super(key: key);

  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        // physics: NeverScrollableScrollPhysics(),
        children: [
          IntroScreen(_pageController),
          SearchScreen(),
          SigninScreen(),
        ],
      ),
    );
  }
}
