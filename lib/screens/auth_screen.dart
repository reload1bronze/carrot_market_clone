import 'package:flutter/material.dart';

import 'intro_screen.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({Key? key}) : super(key: key);

  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          IntroScreen(_pageController),
          Container(
            color: Colors.accents[2],
          ),
          Container(
            color: Colors.accents[4],
          ),
        ],
      ),
    );
  }
}
