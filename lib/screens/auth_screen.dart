import 'package:flutter/material.dart';

import 'intro_screen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          IntroScreen(),
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
